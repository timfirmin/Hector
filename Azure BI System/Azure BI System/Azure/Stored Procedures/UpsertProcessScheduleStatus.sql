CREATE PROCEDURE [Azure].[UpsertProcessScheduleStatus]
	@ProcessName VARCHAR(255)
	,@Date DATE
	,@Status INT
AS
BEGIN
	MERGE [Azure].[ProcessScheduleLog] t
		USING (
			SELECT [ProcessID]
				,@Date [Date]
				,@Status [Status]
			FROM [Azure].[Process]
			WHERE [Name] = @ProcessName) s ([ProcessID],[Date],[Status])
	ON t.[ProcessID] = s.[ProcessID] 
	AND t.[Date] = s.[Date]

	WHEN NOT MATCHED THEN
		INSERT ([ProcessID],[Date],[Status],[UpdatedAt])
		VALUES (s.[ProcessID],s.[Date],s.[Status],NULL)

	WHEN MATCHED THEN
		UPDATE SET [Status] = s.[Status],
				   [UpdatedAt] = SYSDATETIME();
END