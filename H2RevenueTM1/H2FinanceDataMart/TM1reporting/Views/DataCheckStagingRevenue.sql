



CREATE VIEW [TM1reporting].[DataCheckStagingRevenue]
AS

select 
	Company,	
	RevenueFileTypeName, 
	FinanceSection, 
	[PlanningYear],
	isnull([Budget],0) as [Budget], 
	isnull([Forecast Q1],0) as [ForecastQ1], 
	isnull([Forecast Q2],0) as [ForecastQ2], 
	isnull([Forecast Q3],0) as [ForecastQ3], 
	[StagingLoadId] ,
	[StagingFileName]
from 
(
(
SELECT  
       pec.[Company]
	  ,replace(ift.PlanningFileTypeName, 'Data','') as RevenueFileTypeName 
      ,pec.Level2 as FinanceSection
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,pec.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [FinanceStage].[TM1Staging].[PlanningExtractRevenue] pec

JOIN [FinanceStage].[TM1Control].[ImportFileLog] ifl on pec.FileLogUniqueKey = ifl.[FileLogUniqueKey]
JOIN [FinanceStage].[TM1Control].[PlanningScenario] ps on pec.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [FinanceStage].[TM1Control].[ImportFileType] ift on pec.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY 
	   pec.[Company]
	  ,ift.PlanningFileTypeName
      ,pec.Level2
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
      ,pec.[InsertLoadId]
	  ,ifl.[FileName]
)) PivotBase
PIVOT
(SUM(ScenarioYearValue) FOR 
[PlanningScenario] IN ([Budget], [Forecast Q1], [Forecast Q2], [Forecast Q3])
) AS PivotTable;