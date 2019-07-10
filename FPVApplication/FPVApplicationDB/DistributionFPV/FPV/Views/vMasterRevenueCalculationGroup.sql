 

CREATE VIEW [FPV].[vMasterRevenueCalculationGroup]
as
 --=============================================
-- Last Change By: TJF 2019APR24
-- Calculation Grouped Latest Revenue
-- =============================================
	select   mr.[DistributionGroupCode]
			,mr.[DistributionCode]
			,mr.[Society]

			,mr.[CodaCustomerCode]
			,max(mr.[CodaCustomerDescription]) [CodaCustomerDescription]
			,min(mr.[Scenario]) + replace('-' + max(mr.[Scenario]),'-'+min(mr.[Scenario]),'') as [Scenario]
			,min(case when mr.[PreferenceScenarioFlag] = mr.[ActiveScenarioFlag] then 'Y' else 'N' end) as ScenarioPreferenceMatch
			,sum(mr.[Revenue]) as [Revenue]
			,min(mr.[UpdatedBy]) [UpdatedBy]
			,min(mr.[UpdateComment]) [UpdateComment]
			,min(mr.[SysStartTime]) [SysStartTime]
			,max(mr.[SysEndTime]) [SysEndTime] 
			,1 [IsCurrent]

	from [FPV].[MasterRevenue] mr  
	where mr.[ActiveScenarioFlag] = 'Y'

	group by 
			mr.[DistributionGroupCode]
		,mr.[DistributionCode]
		,mr.[Society]
	,mr.[CodaCustomerCode]