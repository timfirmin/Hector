

CREATE view [FPV].[vApplicationRevenueView]
as
--=============================================
--Last Change : TJF 2019APR24 Removed Station-Level Master Revenue
--Last Change : TJF 2019MAY02 Removed 4 Fields (Revenue CurrentRevenue StationName Scenario)
--Last Change : TJF 2019MAY02 Rework with New Primary Key
--Last Change : TJF 2019MAY02 Re-introduced Master Revenue as Revenue Management Grid requires this for a fresh Calc Group
--=============================================
with intervaldates as (
select DISTINCT 	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vMasterRevenue]
union
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vCalculationGroupRevenue]
)
,holistic as (
select	
		--Master Value Fields
		 i.[DistributionGroupCode]
		,i.[DistributionCode]
		,i.[Society]
		,i.[StationID]
		--,i.[CodaCustomerCode]
		--,i.[Scenario]

		--Added 2019APR17
		--,m.[StationID][masterStationID]
		--,m.[CodaCustomerCode][masterCodaCustomerCode]
		--,m.[CodaCustomerDescription][masterCodaCustomerDescription]

		--,c.[StationID][StationID]
		,isnull(c.[CodaCustomerCode],m.[CodaCustomerCode])[CodaCustomerCode]
		,isnull(c.[CodaCustomerDescription],m.[CodaCustomerDescription])[CodaCustomerDescription]

		--,m.[CodaCustomerDescription]
		--,m.[Revenue][masterRevenue]
		--,m.StationName
		--,m.[UpdatedBy][masterUpdatedBy]
		--,m.[UpdateComment][masterUpdateComment]
		--,m.[SysStartTime][masterSysStartTime]
		--,m.[SysEndTime][masterSysEndTime]
		--,m.[IsCurrent][masterIsCurrent]
		--,c.[Revenue]
		,c.[UpdatedBy]
		,c.[UpdateComment]
		,c.[SysStartTime][calculationSysStartTime]
		,c.[SysEndTime][calculationSysEndTime]
		,c.[IsCurrent][calculationIsCurrent]

		--Added 2019MAR08
		,c.[AnnualMusicMinutes]
		,c.[MusicUsage]
		,c.[MusicConsumption]
		,c.[ConsumptionSplit]
		,c.[RevenueApportionment]
		--,c.[CurrentRevenue]
		,c.[TotalRevenueApportionment]
		,c.PercentageSplit
		,i.[intervalSysTime][SysStartTime]
		,coalesce(lead(i.[intervalSysTime]) over (partition by i.[DistributionGroupCode],i.[DistributionCode],i.[Society],i.[StationID] order by i.[intervalSysTime]),'31 DEC 9999')[SysEndTime]
from intervaldates i
left join [FPV].[vMasterRevenue] m on m.[DistributionGroupCode]=i.[DistributionGroupCode]
								and m.[DistributionCode]=i.[DistributionCode]
								and m.[Society]=i.[Society]
								and m.[StationID]=i.[StationID]
								and i.[intervalSysTime] between m.SysStartTime and m.SysEndTime
left join [FPV].[vCalculationGroupRevenue] c on c.[DistributionGroupCode]=i.[DistributionGroupCode]
										and c.[DistributionCode]=i.[DistributionCode]
										and c.[Society]=i.[Society]
										and c.[StationID]=i.[StationID]
										--and c.[CodaCustomerCode]=i.[CodaCustomerCode]
										--and c.[Scenario]=i.[Scenario]
										and i.[intervalSysTime] between c.SysStartTime and c.SysEndTime
)
,recency as (
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[CodaCustomerCode]
		,[CodaCustomerDescription]
		--,[Scenario]

		 
		--,[masterStationID]
		--,[masterCodaCustomerCode]
		-- ,[masterCodaCustomerDescription]
		--,[workingStationID]
		--,[workingCodaCustomerCode]
		--,[workingCodaCustomerDescription]

		--,[masterRevenue]
		--,[StationName]
		--,[masterUpdatedBy]
		--,[masterUpdateComment]
		--,[masterSysStartTime]
		--,[masterSysEndTime]
		--,[masterIsCurrent]
		--,[Revenue]
		,[UpdatedBy]
		,[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		--Added 2019MAR08
		,[AnnualMusicMinutes]
		,[MusicUsage]
		,[MusicConsumption]
		,[ConsumptionSplit]
		,[RevenueApportionment]
		--,[CurrentRevenue]
		,[TotalRevenueApportionment]
		,PercentageSplit
		,[SysStartTime]
		,[SysEndTime]
		--,row_number() over (partition by [DistributionGroupCode],[DistributionCode],[Society],[CodaCustomerCode],[Scenario],[StationID] order by [SysEndTime] desc)[Recency]
		,row_number() over (partition by [DistributionGroupCode],[DistributionCode],[Society],[StationID] order by [SysStartTime] desc)[Recency]
from holistic
)
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		--,[StationName]
		,[CodaCustomerCode]
		,[CodaCustomerDescription]
		--,[Scenario]

		----Added 2019APR17
		--,[masterStationID]
		--,[masterCodaCustomerCode]
		--,[masterCodaCustomerDescription]
		--,[masterRevenue]

		--,[masterUpdatedBy]
		--,FPV.udfRemoveStringCharacters([masterUpdateComment])[masterUpdateComment]
		--,[masterSysStartTime]
		--,[masterSysEndTime]
		--,[masterIsCurrent]
		--,[workingStationID]
		--,[workingCodaCustomerCode]
		--,[workingCodaCustomerDescription]
		--,[Revenue]
		,[UpdatedBy]
		,FPV.udfRemoveStringCharacters([UpdateComment])[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		--Added 2019MAR08
		,[AnnualMusicMinutes]
		,[MusicUsage]
		,[MusicConsumption]
		,[ConsumptionSplit]
		,[RevenueApportionment]
		--,[CurrentRevenue]
		,[TotalRevenueApportionment]
		,PercentageSplit
		,[SysStartTime]
		,[SysEndTime]
		,case when [Recency]=1 then [Recency] else 0 end [IsCurrent]
from recency
GO

