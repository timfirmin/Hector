
--=============================================
-- TJF 2019MAR13 Join moved to HashKey from 5 column Text Join 
-- TJF 2019MAY02 Added in  PeakFactorField / PeakWeightingFactor Logic 
-- TJF 2019MAY09 Issue Found with compound hash key so join reverted to full field joins 
-- Test :  
-- =============================================
CREATE view [FPV].[vApplicationUDCView]
as

with intervaldates as (
	select	CalculationGroupUDCKey, [DistributionGroupCode],[DistributionCode],[Society],[StationID],[UsedForPurposeDesc],[TimeBand],[SysStartTime][intervalSysTime] from [FPV].[vMasterUDC]
	union
	select	CalculationGroupUDCKey, [DistributionGroupCode],[DistributionCode],[Society],[StationID],[UsedForPurposeDesc],[TimeBand],[SysStartTime][intervalSysTime] from [FPV].[vCalculationGroupUDC]
)
,holistic as (
select	 i.[DistributionGroupCode]
		,i.[DistributionCode]
		,i.[Society]
		,i.[StationID]
		,i.[TimeBand]
		,i.[UsedForPurposeDesc]

		/*
		master values
		*/
		,m.[UDCCode][masterUDCCode]
		,FPV.udfRemoveStringCharacters(m.[UDCDescription])[masterUDCDescription]
		--,case rtrim(left(m.[TimeBand],4)) when 'HIGH' then 2 when 'LOW' then 1.5 else 1 end as masterWeightingFactor
		,m.PeakWeightingFactor[masterWeightingFactor]
		,m.[PeakSplitPercent][masterPeakSplitPercent]
			  
		--Added 2019 APR17
 		,m.[UpdateComment][masterUpdateComment]
		,m.[SysStartTime][masterSysStartTime]
		,m.[SysEndTime][masterSysEndTime]
		,m.[IsCurrent][masterIsCurrent]

		/*
		calculation values
		*/
		,FPV.udfRemoveStringCharacters(c.[UDCDescription])[UDCDescription]
		,c.[PeakSplitPercent]
		,c.[UDCCode][calculationUDCCode]
			 
		,c.[UpdatedBy]
		,c.[UpdateComment]
		,c.[SysStartTime][calculationSysStartTime]
		,c.[SysEndTime][calculationSysEndTime]
		,c.[IsCurrent][calculationIsCurrent]

		,i.[intervalSysTime][SysStartTime]
		,coalesce(lead(i.[intervalSysTime]) over (partition by i.[DistributionGroupCode],i.[DistributionCode],i.[Society],i.[StationID],i.[TimeBand],i.[UsedForPurposeDesc]	 order by i.[intervalSysTime]),'31 DEC 9999')[SysEndTime]
from intervaldates i
left join [FPV].[vMasterUDC] m on 
									--m.CalculationGroupUDCKey = i.CalculationGroupUDCKey --these keys do not match due to case type issues
										m.[DistributionGroupCode]=i.[DistributionGroupCode]
										and m.[DistributionCode]=i.[DistributionCode]
										and m.[Society]=i.[Society]
										and m.[StationID]=i.[StationID]
										and m.[TimeBand]=i.[TimeBand]
										and m.[UsedForPurposeDesc]=i.[UsedForPurposeDesc]
								    and i.[intervalSysTime] between m.SysStartTime and m.SysEndTime
left join [FPV].[vCalculationGroupUDC] c on 
										--c.CalculationGroupUDCKey = i.CalculationGroupUDCKey
										c.[DistributionGroupCode]=i.[DistributionGroupCode]
										and c.[DistributionCode]=i.[DistributionCode]
										and c.[Society]=i.[Society]
										and c.[StationID]=i.[StationID]
										and c.[TimeBand]=i.[TimeBand]
										and c.[UsedForPurposeDesc]=i.[UsedForPurposeDesc]
										and i.[intervalSysTime] between c.SysStartTime and c.SysEndTime
)
,recency as (
select	 [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[UsedForPurposeDesc]
		,[TimeBand]
				
		,[masterUDCCode]
		,[masterUDCDescription]	 
		,[masterPeakSplitPercent]
		,[masterWeightingFactor] 

				--Added 2019 APR17
 		,[masterUpdateComment]
		,[masterSysStartTime]
		,[masterSysEndTime]
		,[masterIsCurrent]

		,[calculationUDCCode]
		,[UDCDescription]
		,[PeakSplitPercent]

		,[UpdatedBy]
		,[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		,[SysStartTime]
		,[SysEndTime]
		,row_number() over (partition by [DistributionGroupCode],[DistributionCode],[Society],[StationID],[TimeBand],[UsedForPurposeDesc]	  order by [SysEndTime] desc)[Recency]
		from holistic
)
select	[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[TimeBand]
		,[UsedForPurposeDesc]
				
		,[masterUDCCode]	  
		,[masterUDCDescription]
		,[masterPeakSplitPercent]
		,[masterWeightingFactor]

 		,[masterUpdateComment]
		,[masterSysStartTime]
		,[masterSysEndTime]
		,[masterIsCurrent]

		
		,[calculationUDCCode]
		,[UDCDescription]
		,[PeakSplitPercent]

		,[UpdatedBy]
		,FPV.udfRemoveStringCharacters([UpdateComment])[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		,[SysStartTime]
		,[SysEndTime]
		,case when [Recency]=1 then [Recency] else 0 end [IsCurrent]
		from recency


