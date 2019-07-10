
CREATE VIEW [FPV].[vApplicationFPVProcessCalculationView]
AS
WITH Calculations AS (
SELECT *
FROM
(
	SELECT e.[FPVCalculationEventID],
			e.[DistributionGroupCode],
			e.[DistributionCode],
			e.[Society]
			,c.[StationID]
		,e.[Comment][CalculationEventComment]
		,e.[SysDateTime] [CalculationEventTime]
		,d.[CalculationName]
		,d.[CalculationName] + 'Status'[CalculationStatusName]
		,c.[CalculationStatus]
		,c.[CalculationValue]
		,dense_rank() over (partition by e.[DistributionGroupCode],e.[DistributionCode],e.[Society],c.[StationID] order by c.[SysCalcTime] desc)[CalcRecency]
	FROM [FPV].[CalculationGroup] g
	JOIN [FPV].[FPVCalculationEvent] e ON e.DistributionGroupCode=g.DistributionGroupCode
											and
											e.DistributionCode=g.DistributionCode
											and
											e.Society=g.Society
	JOIN [FPV].[FPVCalculation] c ON c.[FPVCalculationEventID]=e.[FPVCalculationEventID]
	JOIN [FPV].[FPVCalculationDef] d ON d.FPVCalculationDefID=c.FPVCalculationDefID
) c
PIVOT(MAX([CalculationValue]) FOR [CalculationName] IN ([HedgePercentFPV],[CombinedAdminRateFPV])) AS P1
PIVOT (MAX([CalculationStatus]) FOR [CalculationStatusName] IN ([HedgePercentFPVStatus],[CombinedAdminRateFPVStatus])) AS P2
)

SELECT	c.[FPVCalculationEventID]
		,c.[CalculationEventComment]
		,c.[CalculationEventTime]
		,dense_rank() over (partition by c.[DistributionGroupCode],c.[DistributionCode],c.[Society],c.[StationID]  order by c.[CalculationEventTime] desc)[CalculationEventRecency]
		,c.[DistributionGroupCode]
		,c.[DistributionCode]
		,c.[Society]
		,c.[StationID]
		,s.[StationName]
		,s.[IsExcluded]
		,s.[HedgePercent]
		,s.[GroupAdminRate]
		,s.[PRAdminRate]
		,max(c.[HedgePercentFPV])[HedgePercentFPV]
		,max(c.[HedgePercentFPVStatus])[HedgePercentFPVStatus]
		,max(c.[CombinedAdminRateFPV])[CombinedAdminRateFPV]
		,max(c.[CombinedAdminRateFPVStatus])[CombinedAdminRateFPVStatus]
FROM	Calculations c
JOIN	[FPV].[vCalculationGroupStation] s ON c.[DistributionGroupCode]=s.[DistributionGroupCode]
													and
													c.[DistributionCode]=s.[DistributionCode]
													and
													c.[Society]=s.[Society]
													and
													c.[StationID]=s.[StationID]
													and
													c.[CalculationEventTime] BETWEEN s.SysStartTime and s.SysEndTime
GROUP BY c.[FPVCalculationEventID]
		,c.[CalculationEventComment]
		,c.[CalculationEventTime]
		,c.[DistributionGroupCode]
		,c.[DistributionCode]
		,c.[Society]
		,c.[StationID]
		,s.[StationName]
		,s.[IsExcluded]
		,s.[HedgePercent]
		,s.[GroupAdminRate]
		,s.[PRAdminRate]