
   --    ,pec.[BusinessUnit] as Class
   --   ,pec.[SubBusinessUnit] as Level4
   --   ,pec.[Category] as Level3
   --   ,pec.[Mapping] as Level2
	  --,'Costs' as Level1

CREATE VIEW [TM1Control].[DataCheckStagingCosts]
AS

SELECT  
       pec.[Company]
	  ,ift.PlanningFileTypeName as RevenueFileTypeName
      ,pec.Mapping as FinanceSection
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,pec.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [TM1Staging].[PlanningExtractCosts] pec

JOIN [TM1Control].[ImportFileLog] ifl on pec.FileLogUniqueKey = ifl.[FileLogUniqueKey]
JOIN [TM1Control].[PlanningScenario] ps on pec.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [TM1Control].[ImportFileType] ift on pec.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY 
	   pec.[Company]
	  ,ift.PlanningFileTypeName
      ,pec.Mapping
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
      ,pec.[InsertLoadId]
	  ,ifl.[FileName]