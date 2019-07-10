




CREATE VIEW [TM1Transform].[FinancialAnalyticsOutput]
AS

SELECT 
		CAST(HashBytes('SHA1', pd.[Company])	AS bigint) AS [CompanyKey]
		,CAST(HashBytes('SHA1', pd.[Company] + '_TM1')	AS bigint) AS [DocumentKey]
		  ,isnull(replace(ift.PlanningFileTypeName,'Data',''), 'Unknown') as TM1CostRevenue
      ,min([Class]) as TM1Class
      ,min([Level4]) as TM1Level4
      ,min([Level3]) as TM1Level3
      ,min([Level2]) as TM1Level2
      ,min([Level1]) as TM1Level1
      ,cast(pd.[Company] + '_' + pd.[EL1Code] as varchar(50)) as AccountCode_EL1
	  ,isnull(el1.AccountEL1_KEY, CAST(HashBytes('SHA1', pd.[Company] + '_ ') AS bigint)) as AccountKey_EL1
      ,cast(pd.[Company] + '_' + pd.[EL2Code] as varchar(50)) as AccountCode_EL2
	  ,isnull(el2.AccountEL2_KEY, CAST(HashBytes('SHA1', pd.[Company] + '_ ') AS bigint)) as AccountKey_EL2
      ,pd.[PlanningPeriod]
      ,pd.[PlanningYear]
	  ,pd.[PlanningPeriodFirstDay] as CodaFiscalDate
      ,pd.[PlanningFilePeriodSeq]

	,sum(case when pd.[PlanningScenario] = 'Budget' then pd.[ValueGBP] else 0 end) as BudgetValue
	,sum(case when pd.[PlanningScenario] = 'Forecast Q1' then pd.[ValueGBP] else 0 end) as ForecastQ1Value
	,sum(case when pd.[PlanningScenario] = 'Forecast Q2' then pd.[ValueGBP] else 0 end) as ForecastQ2Value
	,sum(case when pd.[PlanningScenario] = 'Forecast Q3' then pd.[ValueGBP] else 0 end) as ForecastQ3Value
	,sum(case when pd.[PlanningScenario] in ('Budget','Forecast Q1','Forecast Q2','Forecast Q3') then pd.[ValueGBP] else 0 end) as FullSendValue
      ,[PlanningFileLogKey] as SourcePlanningFileLogKey
      ,pd.[InsertLoadId]
  FROM [TM1Transform].[PlanningData] pd
  JOIN [TM1Control].[PlanningScenario] ps on pd.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
  LEFT JOIN [CodaTransform].[Dim_Accounts_EL1] el1 ON cast(pd.[Company] + '_' + pd.[EL1Code] as varchar(50)) =	el1.AccountKey_EL1
  LEFT JOIN [CodaTransform].[Dim_Accounts_EL2] el2 ON cast(pd.[Company] + '_' + pd.[EL2Code] as varchar(50)) =	el2.AccountKey_EL2
  LEFT JOIN [TM1Control].[ImportFileType] ift on pd.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey
  WHERE ps.PlanningScenarioValidFDM = 'Y'
  GROUP  BY 
 pd.[Company]
,pd.[PlanningFilePeriodSeq]
,pd.[EL1Code]
,pd.[EL2Code]
,pd.[PlanningPeriod]
,pd.[PlanningYear]
,pd.[PlanningPeriodFirstDay]
,pd.[PlanningFileLogKey]
,pd.[InsertLoadId]
,el1.AccountEL1_KEY	
,el2.AccountEL2_KEY
,ift.PlanningFileTypeName

having sum(case when pd.[PlanningScenario] in ('Budget','Forecast Q1','Forecast Q2','Forecast Q3') then pd.[ValueGBP] else 0 end) <> 0