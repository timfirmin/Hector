CREATE VIEW [Azure].[vwDefaultProcessSchedule]
AS
WITH DefaultSchedule 
AS 
(
	SELECT p.[Name]
			,d.[ProcessId]
			,d.[Monday]
			,d.[Tuesday]
			,d.[Wednesday]
			,d.[Thursday]
			,d.[Friday]
			,d.[Saturday]
			,d.[Sunday]
	FROM [Azure].[DefaultProcessSchedule] d
	JOIN [Azure].[Process] p ON p.[ProcessId] = d.[ProcessId]
)
SELECT u.ProcessId
		,u.[Name][ProcessName]
		,u.[Day]
		,u.[Enabled]
FROM DefaultSchedule d
UNPIVOT
(
	[Enabled] FOR [Day] IN ([Monday],[Tuesday],[Wednesday],[Thursday],[Friday],[Saturday],[Sunday])
) u;