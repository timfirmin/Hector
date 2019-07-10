CREATE view  [Reporting].[vAnalogyStationParameters]
AS

SELECT DISTINCT ParentLoadId AS LoadId, 
SourceSystem,
 CONVERT(varchar(10),
  SysStartTime, 103) AS LoadDate,
   CONVERT(varchar(20), SysStartTime, 113) AS LoadDateTime
FROM  Transform.AnalogyStationAlerts
GO

