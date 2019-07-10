


CREATE view [FPV].[vApplicationMissingMinutesView]
as
with intervaldates as (
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vMasterMissingMinutes]
union
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vCalculationGroupMissingMinutes]
)
select	i.[DistributionGroupCode]
		,i.[DistributionCode]
		,i.[Society]
		,i.[StationID]
		,m.[MissingMinutes][masterMissingMinutes]
		,m.[CarryForwardsMinutes][masterCarryForwardsMinutes]
		,m.[TotalMinutesToHold][masterTotalMinutesToHold]
		,m.[MissingRevenue][masterMissingRevenue]
		,m.[CarryForwardsRevenue][masterCarryForwardsRevenue]
		,m.[TotalRevenueToHold][masterTotalRevenueToHold]
		,m.[UpdatedBy][masterUpdatedBy]
		,FPV.udfRemoveStringCharacters(m.[UpdateComment])[masterUpdateComment]
		,m.[SysStartTime][masterSysStartTime]
		,m.[SysEndTime][masterSysEndTime]
		,m.[IsCurrent][masterIsCurrent]
		,c.[MissingMinutes]
		,c.[CarryForwardsMinutes][CarryForwardsMinutes]
		,c.[TotalMinutesToHold][TotalMinutesToHold]
		,c.[MissingRevenue][MissingRevenue]
		,c.[CarryForwardsRevenue][CarryForwardsRevenue]
		,c.[TotalRevenueToHold][TotalRevenueToHold]
		,c.[UpdatedBy]
		,FPV.udfRemoveStringCharacters(c.[UpdateComment])[UpdateComment]
		,c.[SysStartTime][calculationSysStartTime]
		,c.[SysEndTime][calculationSysEndTime]
		,c.[IsCurrent][calculationIsCurrent]
		,i.[intervalSysTime][SysStartTime]
		,coalesce(lead(i.[intervalSysTime]) over (partition by i.[DistributionGroupCode],i.[DistributionCode],i.[Society],i.[StationID] order by i.[intervalSysTime]),'31 DEC 9999')[SysEndTime]
		,case
			when coalesce(lead([intervalSysTime]) over (partition by i.[DistributionGroupCode],i.[DistributionCode],i.[Society],i.[StationID] order by i.[intervalSysTime]),'31 DEC 9999')='31 DEC 9999' then 1
			else 0
		end [IsCurrent]
from intervaldates i
left join [FPV].[vMasterMissingMinutes] m on m.[StationID]=i.[StationID]
										and m.[DistributionCode]=i.[DistributionCode]
										and m.[Society]=i.[Society]
										and m.[StationID]=i.[StationID]
										and i.[intervalSysTime] between m.SysStartTime and m.SysEndTime
left join [FPV].[vCalculationGroupMissingMinutes] c on c.[DistributionGroupCode]=i.[DistributionGroupCode]
										and c.[DistributionCode]=i.[DistributionCode]
										and c.[Society]=i.[Society]
										and c.[StationID]=i.[StationID]
										and i.[intervalSysTime] between c.SysStartTime and c.SysEndTime