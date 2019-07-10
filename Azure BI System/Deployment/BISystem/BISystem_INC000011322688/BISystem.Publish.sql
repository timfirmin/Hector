PRINT 'Creating [Audit].[InsertRowThroughputFromLastLoad]...';

GO

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

GO

PRINT 'Altering [Control].[VerifyIfPackageAlreadyRun]...';

GO

ALTER PROCEDURE [Control].[VerifyIfPackageAlreadyRun]
	@EntityId INT,
	@ProcessStream VARCHAR(50),
	@LoadProcess VARCHAR(50),
	@LoadId INT
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE	@return_value int
	DECLARE @LoadStatus INT = 0;
	DECLARE @LastLoadId INT = 0 
	DECLARE @EndTime datetime = GETDATE()
	

	SELECT TOP 1 @LoadStatus = eps.LoadStatusTypeId,
                 @LastLoadId = eps.LoadId
	FROM [Control].[EntityProcessStream] eps
	LEFT JOIN [Control].[Entity] e			ON eps.EntityId = e.EntityId
	LEFT JOIN [Control].[EntityType] et		ON et.EntityTypeId = e.EntityTypeId
	WHERE eps.EntityId = @EntityId
	  AND eps.LoadId <>  @LoadId
	  AND eps.ProcessStream = @ProcessStream
	  AND eps.LoadProcess = @LoadProcess
	ORDER BY eps.LoadId DESC
	
	IF (@LoadStatus = 2 OR @LoadStatus = 5)
		BEGIN 
			EXEC [Audit].InsertRowThroughputFromLastLoad @LoadId, @LastLoadId

			EXEC [Control].[UpdatePackageLoad] @LoadId, 'AlreadyRun', @EndTime

			EXEC [Control].[InsertEntityProcessStream] @EntityId, @LoadProcess, @ProcessStream, @LoadId, 'AlreadyRun'

			SET @return_value = 1

		END 
	ELSE 
		BEGIN 

			SET @return_value = 0
		END
    
	
		SELECT @return_value AS Return_Value

END

GO