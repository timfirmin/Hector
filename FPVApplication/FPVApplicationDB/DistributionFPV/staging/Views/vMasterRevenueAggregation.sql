
CREATE VIEW [staging].[vMasterRevenueAggregation]
as
--Currently For Analysis Purposes Only
SELECT 
	 cast(ms.DistributionGroup as varchar(20)) as DistributionGroupCode
	,cast(gcse.DistributionCode as varchar(20)) as DistributionCode
	,cast(dpr.[CompanyCode] as varchar(10)) as Society
	,cast(dpr.[AccountCodeEL2] as varchar(20)) as CodaCustomerCode
	,cast(replace(replace(dpr.[AccountDescrEL2],dpr.[AccountCodeEL2],''),' - ','') as varchar(150)) as CodaCustomerDescription
	,dpr.[PlanningScenario] as Scenario
	--,cast(@pUserName as varchar(100)) as UpdatedBy
	,cast('Planning Unapportioned Revenue' as varchar(255)) as UpdateComment
	,dpr.PlanningYear as PlanningYear 
	,month(dpr.[PlanningPeriodFirstDay]) as PlanningPeriod --dpr.PlanningPeriod

	,isnull(mps.[LatestScenario],'N') as LatestScenarioFlag
	,isnull(mps.[PreferenceScenario],'N') as PreferenceScenarioFlag
	,case when isnull(mps.[PreferredScenarioRank],99) = 1 then 'Y' else 'N' end as ActiveScenarioFlag

	,cast(sum(dpr.[ValueGBP]) as decimal(18,3)) as Revenue
	--,@pLoadId as InsertLoadId
	--,cast(getdate() as datetime2(7)) as InsertTimeStamp
FROM 
  staging.[MasterStation] ms 
  JOIN [staging].[vDistributionGroupCodeStartEnd] gcse on  ms.DistributionGroup = gcse.DistributionGroup
  JOIN [staging].[DistributionPlanningRevenue] dpr on  dpr.[AccountCodeEL2] = ms.CodaCustomerCode and dpr.PlanningPeriodFirstDay between gcse.LicensingStartDate and gcse.LicensingEndDate
  LEFT JOIN [staging].[vMasterRevenueLatestScenario] mps 
  on dpr.[CompanyCode] = mps.[CompanyCode] 
  and dpr.AccountCodeEL2 = mps.AccountCodeEL2 
  and dpr.PlanningYear = mps.PlanningYear 
  and dpr.PlanningPeriod = mps.PlanningPeriod 
  and dpr.PlanningScenario = mps.PlanningScenario
  and ms.DistributionGroup = mps.[DistributionGroup]
  and gcse.DistributionCode = mps.[DistributionCode]

WHERE ms.DistributionGroup in (SELECT [Name] FROM [staging].[MasterDistributionGroup] WHERE [HectorInScope] = 'Y')

GROUP BY
		 dpr.[AccountCodeEL2]
		,dpr.[AccountDescrEL2]
		,dpr.[CompanyCode]
		,dpr.[PlanningScenario]  
		,ms.DistributionGroup
		,gcse.DistributionCode
		,dpr.PlanningYear  
		,dpr.[PlanningPeriodFirstDay]  
		,mps.[LatestScenario]
		,mps.[PreferenceScenario]
		,mps.[PreferredScenarioRank]