


--/****** Object:  View [FPV].[vApplicationPublicReceptionView]    Script Date: 03/08/2018 10:10:17 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

CREATE view [FPV].[vApplicationPublicReceptionView]
as
with intervaldates as (
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vMasterPublicReception]
union
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vCalculationGroupPublicReception]
)
,holistic as (
select	 i.[DistributionGroupCode]
		,i.[DistributionCode]
		,i.[Society]
		,i.[StationID]
		,m.[TotalPRAllocation][masterTotalPRAllocation]
		,m.[UpdateComment][masterUpdateComment]
		,m.[SysStartTime][masterSysStartTime]
		,m.[SysEndTime][masterSysEndTime]
		,m.[IsCurrent][masterIsCurrent]
		,c.[TotalPRAllocation]
		,c.[UpdatedBy]
		,c.[UpdateComment]
		,c.[SysStartTime][calculationSysStartTime]
		,c.[SysEndTime][calculationSysEndTime]
		,c.[IsCurrent][calculationIsCurrent]
		,i.[intervalSysTime][SysStartTime]
		,coalesce(lead(i.[intervalSysTime]) over (partition by i.[DistributionGroupCode],i.[DistributionCode],i.[Society],i.[StationID] order by i.[intervalSysTime]),'31 DEC 9999')[SysEndTime]
from intervaldates i
left join [FPV].[vMasterPublicReception] m on m.[DistributionGroupCode]=i.[DistributionGroupCode]
										and m.[DistributionCode]=i.[DistributionCode]
										and m.[Society]=i.[Society]
										and m.[StationID]=i.[StationID]
										and i.[intervalSysTime] between m.SysStartTime and m.SysEndTime
left join [FPV].[vCalculationGroupPublicReception] c on c.[DistributionGroupCode]=i.[DistributionGroupCode]
										and c.[DistributionCode]=i.[DistributionCode]
										and c.[Society]=i.[Society]
										and c.[StationID]=i.[StationID]
										and i.[intervalSysTime] between c.SysStartTime and c.SysEndTime
)
,recency as (
select	[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[masterTotalPRAllocation]
		,[masterUpdateComment]
		,[masterSysStartTime]
		,[masterSysEndTime]
		,[masterIsCurrent]
		,[TotalPRAllocation]
		,[UpdatedBy]
		,[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		,[SysStartTime]
		,[SysEndTime]
		,row_number() over (partition by [DistributionGroupCode],[DistributionCode],[Society],[StationID] order by [SysEndTime] desc)[Recency]
		from holistic
)
select	[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[masterTotalPRAllocation]
		,FPV.udfRemoveStringCharacters([masterUpdateComment])[masterUpdateComment]
		,[masterSysStartTime]
		,[masterSysEndTime]
		,[masterIsCurrent]
		,[TotalPRAllocation]
		,[UpdatedBy]
		,FPV.udfRemoveStringCharacters([UpdateComment])[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		,[SysStartTime]
		,[SysEndTime]
		,case when [Recency]=1 then [Recency] else 0 end [IsCurrent]
		from recency