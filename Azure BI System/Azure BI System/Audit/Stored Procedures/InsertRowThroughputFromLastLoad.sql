CREATE PROCEDURE [Audit].[InsertRowThroughputFromLastLoad]
	@LoadId INT,
	@LastLoadId INT
AS
BEGIN
	INSERT INTO [Audit].[RowThroughput] (
			    [ExecutionId]
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
	SELECT		ExecutionId
			   ,ProcessStream
			   ,ExtractedRows
			   ,InsertedRows
			   ,UpdatedRows
			   ,DeletedRows
			   ,FailedRows
			   ,ArchivedRows
			   ,BadRows
			   ,@LoadId
			   ,Taskname
			   ,EntityId
			   ,LoadProcess
			   ,ApplicationId
	FROM [Audit].[RowThroughput]
	WHERE LoadId = @LastLoadId
END
