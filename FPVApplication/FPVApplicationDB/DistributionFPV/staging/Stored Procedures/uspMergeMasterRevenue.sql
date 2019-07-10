/*
 * Tim Firmin 2019JUN11 - Update-Merge MasterRevenue table from staging
 * Update 2018SEP17 Bring in CodaCustomerCode for Revenue Apportionment
 * Update 2019FEB23 added logic for [PreferenceScenarioFlag]  [ActiveScenarioFlag]
 * Test: EXEC [staging].[uspMergeMasterRevenue] @pLoadId = 321, @pUserName = 'tjf',  @pInsertedRowCount = 0
 */ 
CREATE PROCEDURE [staging].[uspMergeMasterRevenue]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

WITH cte_RevenueAggregate
as
(
--Changed to work for Calendar Planning Year rather than Start/End License Periods
--Changed to Derive Most Recent Scenario for Company-Station-Year-Month
--Removed Station ID
--Currently For Analysis Purposes Only
SELECT 
	 cast(ms.DistributionGroup as varchar(20)) as DistributionGroupCode
	,cast(gcse.DistributionCode as varchar(20)) as DistributionCode
	,cast(dpr.[CompanyCode] as varchar(10)) as Society
	,cast(dpr.[AccountCodeEL2] as varchar(20)) as CodaCustomerCode
	,cast(replace(replace(dpr.[AccountDescrEL2],dpr.[AccountCodeEL2],''),' - ','') as varchar(150)) as CodaCustomerDescription
	,dpr.[PlanningScenario] as Scenario
	,cast(@pUserName as varchar(100)) as UpdatedBy
	,cast('Planning Unapportioned Revenue' as varchar(255)) as UpdateComment
	,dpr.PlanningYear as PlanningYear 
	,month(dpr.[PlanningPeriodFirstDay]) as PlanningPeriod --dpr.PlanningPeriod

	,isnull(mps.[LatestScenario],'N') as LatestScenarioFlag
	,isnull(mps.[PreferenceScenario],'N') as PreferenceScenarioFlag
	,case when isnull(mps.[PreferredScenarioRank],99) = 1 then 'Y' else 'N' end as ActiveScenarioFlag

	,cast(sum(dpr.[ValueGBP]) as decimal(18,3)) as Revenue
	,@pLoadId as InsertLoadId
	,cast(getdate() as datetime2(7)) as InsertTimeStamp
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
)
MERGE [FPV].[MasterRevenue] t
USING cte_RevenueAggregate s
ON 
	    t.[DistributionGroupCode]  = s.[DistributionGroupCode]
	and t.[DistributionCode]  = s.[DistributionCode]
	and t.[Society]  = s.[Society]
	--and upper(t.[StationID])  = upper(s.[StationID])
	and t.[Scenario] = s.[Scenario]
	and t.CodaCustomerCode = s.CodaCustomerCode
	--and t.CodaCustomerDescription = s.CodaCustomerDescription
	--and t.PlanningYear = s.PlanningYear
	and t.PlanningPeriod = s.PlanningPeriod
	--and t.LatestScenarioFlag = s.LatestScenarioFlag

WHEN not matched BY TARGET THEN
INSERT ([DistributionGroupCode] ,[DistributionCode] ,[Society]  ,CodaCustomerCode ,CodaCustomerDescription, [Revenue] ,[UpdatedBy] ,[UpdateComment], [Scenario],[PlanningYear], [PlanningPeriod], [LatestScenarioFlag], [PreferenceScenarioFlag],  [ActiveScenarioFlag])
VALUES (s.[DistributionGroupCode] ,s.[DistributionCode] ,s.[Society]  ,s.CodaCustomerCode ,s.CodaCustomerDescription, s.[Revenue] ,s.[UpdatedBy] ,s.[UpdateComment], s.[Scenario],s.[PlanningYear], s.[PlanningPeriod], s.[LatestScenarioFlag], s.[PreferenceScenarioFlag],  s.[ActiveScenarioFlag])

WHEN matched and	
isnull(t.[Revenue],0)!=isnull(s.[Revenue],0) 
OR isnull(t.[LatestScenarioFlag],'X')!=isnull(s.[LatestScenarioFlag],'N') 
OR isnull(t.[PreferenceScenarioFlag],'X')!=isnull(s.[PreferenceScenarioFlag],'N') 
OR isnull(t.[ActiveScenarioFlag],'X')!=isnull(s.[ActiveScenarioFlag],'N') 
  
THEN
UPDATE SET   [Revenue]=s.[Revenue] 
			,[LatestScenarioFlag]=isnull(s.[LatestScenarioFlag],'N') 
			,[PreferenceScenarioFlag]=isnull(s.[PreferenceScenarioFlag],'N') 		
			,[ActiveScenarioFlag]=isnull(s.[ActiveScenarioFlag],'N') 			
			--,[LatestScenarioFlag]=s.[LatestScenarioFlag]
			--,[PreferenceScenarioFlag]=s.[PreferenceScenarioFlag]
			--,[ActiveScenarioFlag]=s.[ActiveScenarioFlag]
			,[UpdatedBy]=s.[UpdatedBy] 
			,[UpdateComment]=s.[UpdateComment] 

WHEN not matched BY source THEN DELETE;

/* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT
		
END