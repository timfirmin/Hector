


CREATE VIEW [TM1Control].[DataCheckTransform]
AS

SELECT
       ods.[Company]
	  ,ift.PlanningFileTypeName as RevenueFileTypeName
      ,ods.Level2 as FinanceSection
      ,ods.[PlanningScenario]
      ,ods.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,ods.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [TM1Transform].[PlanningData] ods

JOIN [TM1Control].[ImportFileLog] ifl on ods.PlanningFileLogKey = ifl.[FileLogUniqueKey]
JOIN [TM1Control].[PlanningScenario] ps on ods.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [TM1Control].[ImportFileType] ift on ods.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY
       ods.[Company]
	  ,ift.PlanningFileTypeName
      ,ods.Level2 
      ,ods.[PlanningScenario]
      ,ods.[PlanningYear]
	  ,ods.[InsertLoadId] 
	  ,ifl.[FileName]