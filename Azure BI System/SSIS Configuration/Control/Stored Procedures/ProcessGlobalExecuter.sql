﻿-- =============================================
-- Author:		Adatis
-- Create date: 18/03/2013
-- Description:	Kicks off a Standard SSIS Package, with 2 Varables - Queue Task Id 
-- and EntityId (File).  Return ExecutionId from SSISDB to be used to trigger completion. 
-- =============================================

CREATE PROCEDURE [Control].[ProcessGlobalExecuter]

   @PackageName nVarchar(100), 
   @ProjectName nVarchar(100), 
   @FolderName nVarchar(100) = 'Environment',
   @LoadId int,
   @FileTypeCode nVarchar(10), 
   @Async int = 0,
    @Use32BitRuntime [smallint] = 0



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


-- Check to See if we should be using a Specific Environment 

SELECT 
	@EnvironmentName = Value 
FROM 
	Config.ObtainVariable ('SSISEnvironment')
IF @EnvironmentName IS NOT NULL 
BEGIN 
  SELECT @EnvironmentId = [reference_id]
  FROM [SSISDB].[catalog].[environment_references]  
  WHERE [environment_name] = @EnvironmentName AND project_id = @ProjectId 
END 

IF @EnvironmentId IS NOT NULL SET @EnvironmentScope = 'S'


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




     EXEC [SSISDB].[catalog].[create_execution] 
         @package_name=@PackageName,    
         @folder_name=@FolderName, 
         @project_name=@ProjectName,
         @use32bitruntime=@Use32BitRuntime, 
         @reference_id=@EnvironmentId,             --Environment reference, if null then no environment configuration is applied.
         @execution_id=@ExecutionId OUTPUT   --The paramter is outputed and contains the execution_id of your SSIS execution context.


-- Add Knonw Params
DECLARE @svParentLoadId sql_variant 
DECLARE @svFileTypeCode sql_variant
DECLARE @svUse32Bit sql_variant

SET @svParentLoadId = @LoadId
SET @svFileTypeCode = @FileTypeCode
SET @svUse32Bit = @Use32BitRuntime


     EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
         @ExecutionId,  
         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
         @parameter_name=N'intParentLoadId',  --Parameter name
         @parameter_value=@svParentLoadId


		 
     EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
         @ExecutionId,  
         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
         @parameter_name=N'strFileTypeCode',  --Parameter name
         @parameter_value=@svFileTypeCode
BEGIN try
   EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
         @ExecutionId,  
         @object_type=30,  --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
         @parameter_name=N'intRun32BitMode',  --Parameter name
         @parameter_value=@svUse32Bit
END TRY
BEGIN CATCH 
END CATCH 



EXEC [SSISDB].[catalog].[start_execution] @ExecutionId


DEclare @StatusId int

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
