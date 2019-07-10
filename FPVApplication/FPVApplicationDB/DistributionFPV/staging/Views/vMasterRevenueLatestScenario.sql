




CREATE VIEW [staging].[vMasterRevenueLatestScenario] 
as

--This logic can only work for Customer Codes Mapped in MasterStation
--2019Jan20 Changed to Include Preference Scenarios
--added Licence Period
SELECT DISTINCT	
	   dpr.[CompanyCode]
	  ,ms.FirstDistributionGroup as DistributionGroup
	  ,gcse.DistributionCode as DistributionCode
      ,dpr.[AccountCodeEL2]
      ,dpr.[PlanningYear]
	  ,dpr.PlanningPeriod
      ,dpr.[PlanningScenario]
	  ,dpr.[PlanningPeriodFirstDay]
	  ,gcse.LicensingStartDate
	  ,'P' + right('00' + cast(datediff(month,gcse.LicensingStartDate,dpr.[PlanningPeriodFirstDay]) + 1 as varchar(2)),2) as LicencePeriod
	  ,mps.ScenarioLatestForYearFlag as LatestScenario
	  ,case when lpsp.[PlanningScenario] is null then 'N' else 'Y' end as PreferenceScenario
	  ,ROW_NUMBER() OVER(PARTITION BY dpr.[CompanyCode], ms.FirstDistributionGroup, gcse.DistributionCode ,dpr.[AccountCodeEL2],  dpr.[PlanningYear] ,dpr.PlanningPeriod ORDER BY (case when mps.ScenarioLatestForYearFlag  = 'Y' then 0 else mps.ScenarioLatestRank end) ASC) as LatestScenarioRank
	  ,ROW_NUMBER() OVER(PARTITION BY dpr.[CompanyCode], ms.FirstDistributionGroup, gcse.DistributionCode ,dpr.[AccountCodeEL2],  dpr.[PlanningYear] ,dpr.PlanningPeriod ORDER BY (case when lpsp.[PlanningScenario] is not null then 0 else case when mps.ScenarioLatestForYearFlag  = 'Y' then 1 else mps.ScenarioLatestRank + 1 end end) ASC) as PreferredScenarioRank
	  
  FROM [staging].[vMasterRevenueByScenario] dpr
  JOIN [staging].[MasterPlanningScenario] mps ON dpr.[PlanningYear] = mps.PlanningYear and dpr.PlanningScenario = mps.PlanningScenario
  JOIN (SELECT [CodaCustomerCode], MAX([DistributionGroup]) as FirstDistributionGroup FROM [staging].[MasterStation] where [DistributionGroup] is not null GROUP BY [CodaCustomerCode] ) ms on dpr.AccountCodeEL2 = ms.CodaCustomerCode
  JOIN [staging].[vDistributionGroupCodeStartEnd] gcse on ms.FirstDistributionGroup = gcse.DistributionGroup and  dpr.PlanningPeriodFirstDay between gcse.LicensingStartDate and gcse.LicensingEndDate
  LEFT JOIN [staging].[vLicencePeriodScenarioPivot] lpsp on 
						dpr.PlanningYear = lpsp.PlanningYear
					and dpr.PlanningPeriod  = lpsp.PlanningPeriod
					and dpr.[PlanningScenario]   = lpsp.[PlanningScenario]
					and dpr.CompanyCode = 'PRS'
					and ms.FirstDistributionGroup = lpsp.DistributionGroup 
					and gcse.DistributionCode = lpsp.DistributionCode 

 --order by 1,2,3,4,5,6,12