CREATE PROCEDURE [Azure].[GetProcessComponents]
	@ProcessName VARCHAR(255),
	@Date DATE
AS
BEGIN
	WITH FilterProcessSchedule 
	AS 
	(
		SELECT 
			s.[Day],
			s.[ProcessID],
			c.[ComponentTag],
			s.[Enabled]
		FROM [Azure].[vwDefaultProcessSchedule] s
			JOIN [Azure].ProcessComponent pc ON pc.ProcessId = s.Processid
			JOIN [Azure].Component c ON c.ComponentId = pc.ComponentId
		WHERE ProcessName = @ProcessName 
		  AND [Day] = DATENAME(dw,@Date)
	) 
	SELECT DISTINCT
		d.[ComponentTag]
	FROM FilterProcessSchedule d 
		LEFT JOIN [Azure].[ProcessScheduleException] e 
			ON e.[Date] = @Date
			AND e.[ProcessID] = d.[ProcessID]
	WHERE COALESCE(e.[Enabled], d.[Enabled]) = 1
	  AND e.ProcessId IS NULL
END