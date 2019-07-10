CREATE PROCEDURE [Audit].[InsertRowThroughput]
	@Taskname Varchar(100),
	@ExecutionId int,
	@ProcessStream Varchar(50),
	@ExtractedRows int = 0,
	@InsertedRows int = 0,
	@UpdatedRows int = 0,
	@DeletedRows int = 0,
	@FailedRows int = 0,
	@ArchivedRows int = 0,
	@BadRows int = 0,
	@EntityId int = -1,
	@LoadProcess Varchar(50) = '',

	@LoadId int
AS

DECLARE @ApplicationId SMALLINT = 0

SELECT TOP 1 @ApplicationId = ApplicationId FROM Control.Entity WHERE EntityId = @EntityId

--If @ExecutionId = 0
Begin
	INSERT INTO [Audit].[RowThroughput]
			   ([ExecutionId]
			   ,[ProcessStream]
			   ,[ExtractedRows]
			   ,[InsertedRows]
			   ,[UpdatedRows]
			   ,[DeletedRows]
			   ,[FailedRows]
			   ,[ArchivedRows]
			   ,[BadRows]
			   ,[LoadId]
			   ,[TaskName]
			   ,[EntityId]
			   ,[LoadProcess]
			   ,[ApplicationId]
			   )
		 VALUES
			   (@ExecutionId
			   ,@ProcessStream
			   ,@ExtractedRows
			   ,@InsertedRows
			   ,@UpdatedRows
			   ,@DeletedRows
			   ,@FailedRows
			   ,@ArchivedRows
			   ,@BadRows
			   ,@LoadId
			   ,@Taskname
			   ,@EntityId
			   ,@LoadProcess
			   ,@ApplicationId
			   )
end




--If @ExecutionId <> 0
--Begin

--	Declare @ExecutableId int

--	SELECT DISTINCT    
--           @ExecutableId = execl.[executable_id]
--FROM       ([SSISDB].[internal].[executions] (NOLOCK) execs 
--		INNER JOIN [SSISDB].[internal].[executable_statistics] (NOLOCK) stat 
--           ON execs.[execution_id] = stat.[execution_id]) 
--		   INNER JOIN [SSISDB].[internal].[executables] (NOLOCK) execl
--           ON stat.[executable_id] = execl.[executable_id] 


--	INSERT INTO [Audit].[RowThroughput]
--			   ([ExecutionId]
--			   ,[ExecutableId]
--			   ,[EnvironmentId]
--			   ,[ProcessStream]
--			   ,[ExtractedRows]
--			   ,[InsertedRows]
--			   ,[UpdatedRows]
--			   ,[DeletedRows]
--			   ,[FailedRows]
--			   ,[ArchivedRows]
--			   ,[BadRows]
--			   ,[LoadId]
--			   ,[TaskName]
--			   ,[EntityId]
--			   ,[LoadProcess]
--			    )
--		 VALUES
--			   (@ExecutionId
--			   ,@ExecutableId
--			   ,-1
--			   ,@ProcessStream
--			   ,@ExtractedRows
--			   ,@InsertedRows
--			   ,@UpdatedRows
--			   ,@DeletedRows
--			   ,@FailedRows
--			   ,@ArchivedRows
--			   ,@BadRows
--			   ,@LoadId
--			   ,@Taskname
--			   ,@EntityId
--			   ,@LoadProcess
--			    )
--End
