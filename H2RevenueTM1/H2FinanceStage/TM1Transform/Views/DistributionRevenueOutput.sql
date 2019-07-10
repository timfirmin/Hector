





CREATE VIEW [TM1Transform].[DistributionRevenueOutput]
AS

SELECT 
	 pd.[Company] AS [CompanyCode]
	,pd.[EL1Code] as AccountCodeEL1
	,pd.EL1Description as AccountDescrEL1
	,pd.[EL2Code] as AccountCodeEL2
	,pd.EL2Description as AccountDescrEL2
	,pd.[PlanningScenario]
	,pd.[PlanningPeriod]
	,pd.[PlanningYear]
	,pd.[PlanningFilePeriodSeq]
	,pd.[PlanningPeriodFirstDay]
	,[Level4] as TM1CategoryOnlineBroadcast
	,[Level1] as TM1BroadcastGroup
	,sum(pd.[ValueGBP]) as [ValueGBP]
	,[PlanningFileLogKey] as TM1PlanningFileLogKey
	,pd.[InsertLoadId]


  FROM [TM1Transform].[PlanningData] pd
  JOIN [TM1Control].[PlanningScenario] ps on pd.PlanningScenarioKey = ps.PlanningScenarioUniqueKey

  WHERE ps.PlanningScenarioValidFPV = 'Y'
  and pd.[EL2Code] like 'C%'
  and pd.[Class] = 'Revenue'

 GROUP  BY 
	 pd.[Company]
	,pd.[EL1Code]
	,pd.EL1Description 
	,pd.[EL2Code]
	,pd.EL2Description 
	,pd.PlanningScenario
	,pd.[PlanningPeriod]
	,pd.[PlanningYear]
	,pd.[PlanningFilePeriodSeq]
	,pd.[PlanningPeriodFirstDay] 
	,pd.[Level4] 
	,pd.[Level1]
	,pd.[PlanningFileLogKey] 
	,pd.[InsertLoadId]