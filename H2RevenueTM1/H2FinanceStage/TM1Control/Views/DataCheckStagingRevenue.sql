
 CREATE VIEW [TM1Control].[DataCheckStagingRevenue]
AS

SELECT  
       pec.[Company]
	  ,ift.PlanningFileTypeName as RevenueFileTypeName
      ,pec.Level2 as FinanceSection
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,pec.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [TM1Staging].[PlanningExtractRevenue] pec

JOIN [TM1Control].[ImportFileLog] ifl on pec.FileLogUniqueKey = ifl.[FileLogUniqueKey]
JOIN [TM1Control].[PlanningScenario] ps on pec.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [TM1Control].[ImportFileType] ift on pec.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY 
	   pec.[Company]
	  ,ift.PlanningFileTypeName
      ,pec.Level2
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
      ,pec.[InsertLoadId]
	  ,ifl.[FileName]