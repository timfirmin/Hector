CREATE VIEW FPV.[vDistributionRevenueMonthlyScenario]
AS
SELECT TOP 100 PERCENT
		ms.DistributionGroup
		,cal.DistributionCode
		,ms.Code as StationId
		,dpr.[AccountCodeEL2]
		,dpr.[AccountDescrEL2]
		,dpr.[PlanningYear]
		,cal.CalendarMonth as PlanningPeriodInt
		,dpr.[PlanningPeriod]
		,max(dpr.[PlanningScenario]) as RequiredMonthlyScenario
  FROM [staging].[DistributionPlanningRevenue] dpr
  JOIN	[staging].[MasterStation] ms on dpr.[AccountCodeEL2] = ms.[CodaCustomerCode]
  JOIN (SELECT DISTINCT 
      left([MonthYearName],3) as MonthJoin
	  ,[CalendarYear] as YearJoin
	  ,[DistributionGroup] as DistributionGroupJoin
	   ,CalendarMonth
      ,[DistributionCode] as DistributionCode
  FROM [FPV].[DistributionRevenueCalendar]) cal on dpr.[PlanningPeriod] = cal.MonthJoin and dpr.PlanningYear = cal.YearJoin and ms.DistributionGroup = cal.DistributionGroupJoin
  --WHERE [CompanyCode] = 'PRS'
  --and cal.DistributionCode = 'D171'
  --  and [AccountCodeEL2] in  ('CKISS0003', 'CPIRA0002', 'CVIRG0013', 'CXFMA0000')
	group by
		ms.DistributionGroup
		,cal.DistributionCode
		,cal.CalendarMonth	
		,ms.Code  
		,[AccountCodeEL2]
		,[AccountDescrEL2]
		,[PlanningPeriod]
		,[PlanningYear]	

	  order by 1,2,3,6,7