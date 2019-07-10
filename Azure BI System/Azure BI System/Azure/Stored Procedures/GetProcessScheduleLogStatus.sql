CREATE PROCEDURE [Azure].[GetProcessScheduleLogStatus]
	@ProcessName VARCHAR(255),
	@Date DATE,
	@Status INT OUT
AS
BEGIN
	DECLARE @CurrentStatus INT = 0;

	SELECT
		@CurrentStatus = L.[Status]
	FROM [Azure].[ProcessScheduleLog] L
		JOIN [Azure].[Process] P ON P.[ProcessID]=L.[ProcessID]
	WHERE L.[Date] = @Date 
	  AND P.[Name] = @ProcessName

	SET @Status = COALESCE (@CurrentStatus,0);
END;  