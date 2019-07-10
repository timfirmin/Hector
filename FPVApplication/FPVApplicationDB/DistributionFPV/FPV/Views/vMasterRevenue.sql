







CREATE  view [FPV].[vMasterRevenue]
as
 --=============================================
-- Last Change By: TJF 2019APR24
-- View Not to be Used. Revenue to be Kept at Revenue Group level - see vMasterRevenueCalculationGroup
-- =============================================
select   mr.[DistributionGroupCode]
		,mr.[DistributionCode]
		,mr.[Society]
		,ms.[StationID]
		,ms.[StationName]
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
JOIN [FPV].[MasterStation] ms on mr.CodaCustomerCode = ms.CodaCustomerCode and mr.DistributionGroupCode = ms.DistributionGroupCode
where mr.[ActiveScenarioFlag] = 'Y'

group by 
		mr.[DistributionGroupCode]
	,mr.[DistributionCode]
	,mr.[Society]
	,ms.[StationID]
	,ms.[StationName]
	,mr.[CodaCustomerCode]
 

union

select   mrh.[DistributionGroupCode]
		,mrh.[DistributionCode]
		,mrh.[Society]
		,ms.[StationID]
		,ms.[StationName]
		,mrh.[CodaCustomerCode]
		,max(mrh.CodaCustomerDescription) [CodaCustomerDescription]
		,min(mrh.[Scenario]) + replace('-' + max(mrh.[Scenario]),'-'+min(mrh.[Scenario]),'') as [Scenario]
		,min(case when mrh.[PreferenceScenarioFlag] = mrh.[ActiveScenarioFlag] then 'Y' else 'N' end) as ScenarioPreferenceMatch
		,sum(mrh.[Revenue]) as [Revenue]
		,min(mrh.[UpdatedBy]) [UpdatedBy]
		,min(mrh.[UpdateComment]) [UpdateComment]
		,min(mrh.[SysStartTime]) [SysStartTime]
		,dateadd(ms,-1,max(mrh.[SysEndTime]))[SysEndTime]
		,0 [IsCurrent]

from [FPV].[MasterRevenueHistory] mrh
JOIN [FPV].[MasterStation] ms on mrh.CodaCustomerCode = ms.CodaCustomerCode and mrh.DistributionGroupCode = ms.DistributionGroupCode
where mrh.[ActiveScenarioFlag] = 'Y'
group by 
		 mrh.[DistributionGroupCode]
		,mrh.[DistributionCode]
		,mrh.[Society]
		,ms.[StationID]
		,ms.[StationName]
		,mrh.[CodaCustomerCode]