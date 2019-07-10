-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date:		26/04/2016
-- Description:		Inserts record into Batch Control table for logging source files included in a load
--					@GlobalLoadId			- the LoadId of the package that initated the whole load.
--					@ExecutionId			- the unique identifier for the package execution
--					@PackageId				- the unique identifier for the package
--					@StartTime				- start time for the new batch
-- ==========================================================================================

CREATE PROCEDURE [Control].[InsertBatchControl]
	@GlobalLoadId int = 0, 
	@ExecutionId uniqueidentifier, 
	@StartTime datetime,
	@SourceFileId int
AS

--either @ParentLoadId or @LoadProcessShortName must contain real values for the Load Process to be ascertained
IF @GlobalLoadId = 0
BEGIN
	RAISERROR ('Invalid @ParentLoadId value in call to Batch Control Table', 16, 1) WITH SETERROR;
	RETURN;
END

-- Insert new load
INSERT INTO [Control].[BatchControl]
	( GlobalLoadId, GlobalExecutionId, StartTime, SourceFileId )
VALUES 
	( @GlobalLoadId, @ExecutionId, @StartTime, @SourceFileId );
