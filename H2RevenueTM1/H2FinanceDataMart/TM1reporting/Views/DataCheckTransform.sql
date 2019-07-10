



CREATE VIEW [TM1reporting].[DataCheckTransform]
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
       ods.[Company]
	  ,replace(ift.PlanningFileTypeName, 'Data','') as RevenueFileTypeName 
      ,ods.Level2 as FinanceSection
      ,ods.[PlanningScenario]
      ,ods.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,ods.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [FinanceStage].[TM1Transform].[PlanningData] ods

JOIN [FinanceStage].[TM1Control].[ImportFileLog] ifl on ods.PlanningFileLogKey = ifl.[FileLogUniqueKey]
JOIN [FinanceStage].[TM1Control].[PlanningScenario] ps on ods.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [FinanceStage].[TM1Control].[ImportFileType] ift on ods.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY
       ods.[Company]
	  ,ift.PlanningFileTypeName
      ,ods.Level2 
      ,ods.[PlanningScenario]
      ,ods.[PlanningYear]
	  ,ods.[InsertLoadId] 
	  ,ifl.[FileName] 
)) PivotBase
PIVOT
(SUM(ScenarioYearValue) FOR 
[PlanningScenario] IN ([Budget], [Forecast Q1], [Forecast Q2], [Forecast Q3])
) AS PivotTable;