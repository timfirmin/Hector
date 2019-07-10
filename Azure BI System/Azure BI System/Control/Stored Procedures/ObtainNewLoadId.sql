-- =============================================
-- Author:		Adatis Consulting
-- Create date:		06/11/2006
-- Description:		Inserts record into PackageLoad table with status 'In Progress' to 
--					signify the start of a new package load.
--					@EnvShortName			- the environment ShortName
--					@ParentLoadId			- optional - the LoadId of the parent package.
--											- required if @LoadProcessShortName is null
--					@ExecutionId			- the unique identifier for the package execution
--					@PackageId				- the unique identifier for the package
--					@LoadProcessShortName	- optional - the short name for the load process.
--											- required if @ParentLoadId = 0
--					@StartTime				- start time for the new load
--					@LoadId					- Output for resultant LoadId for new load
-- ==========================================================================================

CREATE PROCEDURE [Control].[ObtainNewLoadId]
	@ParentLoadId int = 0, 
	@ExecutionId uniqueidentifier, 
	--@EnvironmentId int,
	@PackageId uniqueidentifier,
	@VersionId uniqueidentifier = null,
	@PackageName NVarchar(100) = null,
	@LoadProcessShortName varchar(20) = NULL,
	@StartTime datetime, 
	@SSISCatalogExecutionId int, 
	@LoadId int Output
AS

DECLARE @SystemId int, @LoadStatusId int, 
		@IsLoadProcessPackage bit, @LoadProcessId int, @SSISCatPackageId int, @SSISCatProjectId int

--either @ParentLoadId or @LoadProcessShortName must contain real values for the Load Process to be ascertained
IF @ParentLoadId = 0 AND @LoadProcessShortName IS NULL
BEGIN
	RAISERROR ('Invalid @ParentLoadId, @LoadProcessShortName values in call to Obtain New LoadId', 16, 1) WITH SETERROR;
	RETURN;
END

SET @LoadId = 0
SET @LoadProcessId = 0

SELECT @LoadStatusId = LoadStatusTypeId FROM LoadStatusType WHERE ShortName = 'InProgress'

IF @LoadStatusId IS NULL 
BEGIN
	RAISERROR ('Invalid @LoadStatusId value in call to Obtain New LoadId', 16, 1) WITH SETERROR
	RETURN;
END


--catch bad @PackageId values
IF @PackageId IS NULL
BEGIN
	RAISERROR ('Invalid @PackageId values value in call to Obtain New LoadId', 16, 1) WITH SETERROR;
	RETURN
END

DECLARE @EnvironmentId int = -1

--SELECT @IsLoadProcessPackage = IsLoadProcessPackage,
--@LoadProcessId = dbo.ufnGetLoadProcessId(@PackageId, @EnvironmentId, @ParentLoadId, @LoadProcessShortName)
--FROM Package 
--WHERE PackageId = @PackageId
--AND EnvironmentId = @EnvironmentId

SET @ParentLoadId = nullif(@ParentLoadId, 0)

--IF @LoadProcessId IS NULL 
--BEGIN
--	RAISERROR ('Invalid @LoadProcessId value returned from ufnGetLoadProcessId() in call to uspNewLoad', 16, 1) WITH SETERROR
--	RETURN;
--END

-- Insert new load
INSERT INTO Audit.PackageLoad
	(EnvironmentId, ParentLoadId, PackageGUID, ExecutionGUID, ProjectId,  PackageName, LoadStatusId, StartTime, ExecutionId, LoadProcess, PackageVersionGUID )
VALUES 
	(@EnvironmentId, @ParentLoadId, @PackageId, @ExecutionId , @SSISCatProjectId, @PackageName, @LoadStatusId,  @StartTime, @SSISCatalogExecutionId, @LoadProcessShortName, @VersionId )
-- get the inserted Identity
SET @LoadId = @@Identity
RETURN;
