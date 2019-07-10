



CREATE VIEW [staging].[vMasterRevenueByScenario]
AS
--Changed to work for Calendar Planning Year rather than Start/End License Periods
--2018SEP17 Changed to Work with CodaCustomerCode data. AV requires apportionment split. Removed Distribution Type.
--2019JAN20 Added First Day Period
SELECT 
		 dpr.[CompanyCode]
		,dpr.[AccountCodeEL2] 
		,dpr.[PlanningYear]
		,dpr.PlanningPeriod
		,dpr.[PlanningScenario]  
		,dpr.PlanningPeriodFirstDay
		,cast(sum(dpr.[ValueGBP]) as decimal(18,3)) as Revenue

  FROM [staging].[DistributionPlanningRevenue] dpr
    
  GROUP BY
		 dpr.[AccountCodeEL2]
		,dpr.[AccountDescrEL2]
		,dpr.[CompanyCode]
		,dpr.[PlanningScenario]  
	    ,dpr.[PlanningYear]
	    ,dpr.PlanningPeriod 
 		,dpr.PlanningPeriodFirstDay