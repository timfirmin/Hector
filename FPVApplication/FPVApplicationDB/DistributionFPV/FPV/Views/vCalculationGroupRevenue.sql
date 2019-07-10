--=============================================
-- Last Change : TJF 2019MAY02 Removed 4 Fields 
--=============================================
CREATE  view [FPV].[vCalculationGroupRevenue]
as
select   mr.[DistributionGroupCode]
		,mr.[DistributionCode]
		,mr.[Society]
		,mr.[StationID]
		--,ms.[StationName]
		,mr.[CodaCustomerCode]
		,mr.[CodaCustomerDescription]
		--,mr.[Scenario]
		--,mr.[Revenue]
		--Added 2019MAR08
		,mr.[AnnualMusicMinutes]
		,mr.[MusicUsage]
		,mr.[MusicConsumption]
		,mr.[ConsumptionSplit]
		,mr.[RevenueApportionment]
		--,mr.[CurrentRevenue]
		,mr.[TotalRevenueApportionment]
		,mr.PercentageSplit 

		,mr.[UpdatedBy]
		,mr.[UpdateComment]
		,mr.[SysStartTime]
		,mr.[SysEndTime]
		,1 [IsCurrent]
from [FPV].[CalculationGroupRevenue] mr
JOIN [FPV].[Distribution] dist on mr.DistributionCode = dist.DistributionCode	
--and (mr.Scenario = dist.DistributionLatestScenario or mr.Scenario = 'Apportionment') 
JOIN [FPV].[MasterStation] ms on mr.StationID = ms.StationID

union

select   mrh.[DistributionGroupCode]
		,mrh.[DistributionCode]
		,mrh.[Society]
		,mrh.[StationID]
		--,ms.[StationName]
		,mrh.[CodaCustomerCode]
		,mrh.[CodaCustomerDescription]
		--,mrh.[Scenario]
		--,mrh.[Revenue]
		--Added 2019MAR08
		,mrh.[AnnualMusicMinutes]
		,mrh.[MusicUsage]
		,mrh.[MusicConsumption]
		,mrh.[ConsumptionSplit]
		,mrh.[RevenueApportionment]
		--,mrh.[CurrentRevenue]
		,mrh.[TotalRevenueApportionment]
		,mrh.PercentageSplit 
		,mrh.[UpdatedBy]
		,mrh.[UpdateComment]
		,mrh.[SysStartTime]
		,dateadd(ms,-1,mrh.[SysEndTime])[SysEndTime]
		,0 [IsCurrent]
from [FPV].[CalculationGroupRevenueHistory] mrh
JOIN [FPV].[Distribution] dist on mrh.DistributionCode = dist.DistributionCode 
--and (mrh.Scenario = dist.DistributionLatestScenario or mrh.Scenario = 'Apportionment') --this must match the input from Abacus Revenue Apportionment
JOIN [FPV].[MasterStation] ms on mrh.StationID = ms.StationID
GO

