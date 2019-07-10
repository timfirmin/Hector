CREATE VIEW [Transform].[v_SuppliedStationDetails]
AS

SELECT 
    (case when NewRecordFlag = 'Y' Then 'New'  Else 'Updated' END ) as [Action],
	SuppliedStationName AS Name ,
	SuppliedStationSource AS  DataSource,
	SuppliedStationCode AS Code,
	LoadId ,
	[SysStartTime]
FROM [Transform].[SuppliedStationData]