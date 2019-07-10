
CREATE PROCEDURE [Control].[ProcessLoadPackage]
   @PackageName nVarchar(100), 
   @ProjectName nVarchar(100), 
   @FolderName nVarchar(100) = 'Folder',
   @LoadId int,
   @Async int = 0,
   @Use32BitRuntime int = 0,
   @CheckPackageIsRunning int = 1, 
   @Environment VARCHAR(100) = NULL,
   @FileTypeCode nVarchar(20) = NULL,
   @FileDateKey int = NULL,
   @FileTimeKey int = NULL
AS

  DECLARE @FolderId int
  DECLARE @ProjectId int
  DECLARE @ProjectVersionId int
  DECLARE @PackageId int
  DECLARE @PackagesRunning int = 0
  DECLARE @ValidationId bigint
  DECLARE @EnvironmentName VARCHAR(100)
  DECLARE @EnvironmentId bigint
  DECLARE @EnvironmentScope CHAR(1) = 'D'
  DECLARE @ExecutionId BIGINT

--Test Defaults
--SET @PackageName  = 'StageToScrub.Census.Addresses.dtsx'
-- SET @FolderName  = 'Folder'
-- SET @ProjectNAme = 'StageToScrub'

--Check Folder Exists 
SELECT @FolderId = Folder_Id FROM [SSISDB].internal.folders  WHERE Name = @FolderName
IF @FolderId IS NULL 
BEGIN
       RAISERROR ('Invalid Folder Name value in call to Process Package', 16, 1) WITH SETERROR
       RETURN;
END

--Check Project Exists
   SELECT @ProjectId = Project_Id, @ProjectVersionId = object_version_lsn  FROM [SSISDB].internal.projects WHERE Folder_Id = @FolderId AND name = @ProjectName
   IF @ProjectId IS NULL 
BEGIN
       RAISERROR ('Invalid Project Name value in call to Process Package', 16, 1) WITH SETERROR
       RETURN;
END
--Check Package Exists in Project 
  SELECT @PackageId = package_id FROM [SSISDB].internal.packages WHERE project_version_lsn = @ProjectVersionId AND name = @PackageName 
 IF @ProjectId IS NULL 
BEGIN
       RAISERROR ('Invalid Package Name value in call to Process Package', 16, 1) WITH SETERROR
       RETURN;
END



--Check to See if this package is already Running. 

SELECT @PackagesRunning = COUNT(*) FROM [SSISDB].[catalog].[executions]
WHERE  package_name=@PackageName AND    
         folder_name=@FolderName AND 
         project_name=@ProjectName AND 
               project_lsn = @ProjectVersionId AND 
               Status IN (2,5,8)  

-- Check to See if we should be using a Specific Environment 

SELECT 
       @EnvironmentName = Value 
FROM 
       Config.ObtainVariable ('SSISEnvironment')
	   WHERE Value = @Environment

IF  @EnvironmentName IS NULL 
SELECT 
      @EnvironmentName Value 
FROM 
       Config.ObtainVariable ('SSISEnvironmentDefault')

IF @EnvironmentName IS NOT NULL 
BEGIN 
  SELECT @EnvironmentId = [reference_id]
  FROM [SSISDB].[catalog].[environment_references]  
  WHERE [environment_name] = @EnvironmentName AND project_id = @ProjectId 
END 


IF @EnvironmentId IS NOT NULL SET @EnvironmentScope = 'S'

IF @PackagesRunning > 0 AND @CheckPackageIsRunning = 1  
BEGIN
       RAISERROR ('Package Already Running', 16, 1) WITH SETERROR
       RETURN;
END

EXEC [SSISDB].[catalog].[Validate_Package] 
  @package_name=@PackageName,    
         @folder_name=@FolderName, 
         @project_name=@ProjectName,
         @use32bitruntime=@Use32BitRuntime, 
         @reference_id=@EnvironmentId,             --Environment reference, if null then no environment configuration is applied.
                @environment_scope  = @EnvironmentScope,
         @validation_id= @ValidationId OUTPUT

 -- Check Validation 

DECLARE @EndDate DAteTime
DECLARE @Status int
WHILE @EndDate IS NOT NULL
BEGIN
  SELECT 
          @EndDate = [end_time]
      ,@Status = [status]
  FROM [SSISDB].[catalog].[validations]  (NOLOCK)
  WHERE validation_id=@ValidationId
END

IF  @Status <> 7 
BEGIN
DECLARE @PackageVersion VARCHAR(40)
DECLARE @PackageGUID  VARCHAR(40)
DECLARE @ExecutionGUID  VARCHAR(40)
DECLARE @return_value int
-- Get Package Details 
SELECT 
      @PackageVersion = [version_guid],
     @PackageGUID = [Package_guid]
  FROM [SSISDB].[catalog].[packages]  (NOLOCK)
  WHERE [package_id] = @PackageId and Project_Id = @ProjectId

-- GEt the Execution GUID 
SELECT @ExecutionGUID = [operation_guid]
  FROM [SSISDB].[internal].[operations] (NOLOCK)
  WHERE operation_ID = @ValidationId
       RAISERROR ('Package Failed To Validate', 16, 1) WITH SETERROR
       RETURN;
END

-- Check if we have a package Pending - and If so - Use that one.... 
 SELECT @ExecutionId = MIN(Execution_Id)  FROM [SSISDB].[catalog].[executions]
WHERE  package_name=@PackageName AND    
         folder_name=@FolderName AND 
         project_name=@ProjectName AND 
                project_lsn = @ProjectVersionId AND 
               Status IN (1)  


IF COALESCE(@ExecutionId,0) = 0 
BEGIN

     EXEC [SSISDB].[catalog].[create_execution] 
         @package_name=@PackageName,    
         @folder_name=@FolderName, 
         @project_name=@ProjectName,
         @use32bitruntime=@Use32BitRuntime, 
         @reference_id=@EnvironmentId,             --Environment reference, if null then no environment configuration is applied.
         @execution_id=@ExecutionId OUTPUT   --The paramter is outputed and contains the execution_id of your SSIS execution context.

END

-- Add Knonw Params
DECLARE @svParentLoadId sql_variant 
DECLARE @svFileTypeCode sql_variant
DECLARE @svFileDateKey sql_variant
DECLARE @svFileTimeKey sql_variant

SET @svParentLoadId = @LoadId


     EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
         @ExecutionId,  
         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
         @parameter_name=N'intParentLoadId',  --Parameter name
         @parameter_value=@svParentLoadId

IF @FileTypeCode IS NOT NULL 
BEGIN 
SET @svFileTypeCode = @FileTypeCode
   EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
         @ExecutionId,  
         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
         @parameter_name=N'strFileTypeCode',  --Parameter name
         @parameter_value=@svFileTypeCode
END 


IF @FileDateKey IS NOT NULL 
BEGIN 
SET @svFileDateKey = @FileDateKey
   EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
         @ExecutionId,  
         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
         @parameter_name=N'intDateKey',  --Parameter name
         @parameter_value=@svFileDateKey
END 

--IF @FileTimeKey IS NOT NULL 
--BEGIN 
--SET @svFileTimeKey = @FileTimeKey
--   EXEC [$(SSISDB)].[catalog].[set_execution_parameter_value] 
--         @ExecutionId,  
--         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
--         @parameter_name=N'intTimeKey',  --Parameter name
--         @parameter_value=@svFileTimeKey
--END 




EXEC [SSISDB].[catalog].[start_execution] @ExecutionId

DECLARE @StatusId int

IF @Async = 0 
BEGIN 
 WHILE 1 = 1
BEGIN
  SELECT @StatusId = [Status]
  FROM [SSISDB].[catalog].[executions]
  WHERE Execution_Id = @ExecutionId

     --created (1), running (2), canceled (3), failed (4), pending (5), ended unexpectedly (6), succeeded (7), stopping (8), and completed (9).
       
        IF @StatusId = 7 
        BEGIN
         BREAK;
     END;
       IF @StatusId = 4 
        BEGIN
             RAISERROR ('Package Failed', 16, 1) WITH SETERROR
         BREAK;
     END;

              IF @StatusId = 3 
        BEGIN
             RAISERROR ('Package Cancelled', 16, 1) WITH SETERROR
         BREAK;
     END;

                     IF @StatusId = 6 
        BEGIN
             RAISERROR ('ended unexpectedly', 16, 1) WITH SETERROR
         BREAK;
     END;

                      IF @StatusId = 8 
        BEGIN
             RAISERROR ('Stopping', 16, 1) WITH SETERROR
         BREAK;
     END;

                            IF @StatusId = 9
       BEGIN
       
         BREAK;
     END;


       WAITFOR DELAY '00:00:15';

END
END




