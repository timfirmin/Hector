CREATE VIEW Test.RevenueDistributionLogic
as

SELECT 
	 cast(ms.DistributionGroup as varchar(20)) as DistributionGroupCode
	,cast(se.DistributionCode as varchar(20)) as DistributionCode
	,cast(dpr.[CompanyCode] as varchar(10)) as Society
	,cast(dpr.[AccountCodeEL2] as varchar(20)) as CodaCustomerCode
	,cast(replace(replace(dpr.[AccountDescrEL2],dpr.[AccountCodeEL2],''),' - ','') as varchar(150)) as CodaCustomerDescription
	,cast(ms.Code as varchar(20)) as StationID	
	,ms.[Name] as StationName
	,dpr.[PlanningScenario] as Scenario
	,dpr.PlanningYear as PlanningYear 
	,month(dpr.[PlanningPeriodFirstDay]) as PlanningPeriod --dpr.PlanningPeriod
	,case when mps.ScenarioRank = 1 then 'Y' else 'N' end as LatestScenarioFlag
	,cast(sum(dpr.[ValueGBP]) as decimal(18,3)) as Revenue


  FROM 
	staging.[MasterStation] ms
	JOIN [staging].[vDistributionGroupCodeStartEnd] se on  ms.DistributionGroup = se.DistributionGroup
	JOIN [staging].[DistributionPlanningRevenue] dpr on  dpr.[AccountCodeEL2] = ms.CodaCustomerCode and dpr.PlanningPeriodFirstDay between se.LicensingStartDate and se.LicensingEndDate
	JOIN [staging].[vMasterRevenueLatestScenario] mps 
	on dpr.[CompanyCode] = mps.[CompanyCode] and dpr.AccountCodeEL2 = mps.AccountCodeEL2 and dpr.PlanningYear = mps.PlanningYear and dpr.PlanningPeriod = mps.PlanningPeriod and dpr.PlanningScenario = mps.PlanningScenario

  WHERE ms.DistributionGroup in (SELECT [Name] FROM [staging].[MasterDistributionGroup] WHERE [HectorInScope] = 'Y')
	--AND dpr.[CompanyCode] = 'PRS'
	--AND dpr.[AccountCodeEL2] = 'CGOLD0023'	
	--AND se.DistributionCode = 'D181'	

  GROUP BY
		 ms.Code
		,ms.[Name] 
		,dpr.[AccountCodeEL2]
		,dpr.[AccountDescrEL2]
		,dpr.[CompanyCode]
		,dpr.[PlanningScenario]  
		,ms.DistributionGroup
		,se.DistributionCode
		,dpr.PlanningYear  
		,dpr.[PlanningPeriodFirstDay] 
		,mps.ScenarioRank