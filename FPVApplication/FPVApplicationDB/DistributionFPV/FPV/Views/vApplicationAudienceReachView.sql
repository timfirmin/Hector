




CREATE view [FPV].[vApplicationAudienceReachView]
as
with intervaldates as (
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vMasterAudienceReach]
union
select	[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysTime] from [FPV].[vCalculationGroupAudienceReach]
)
,holistic as (
select	i.[DistributionGroupCode]
		,i.[DistributionCode]
		,i.[Society]
		,i.[StationID]



		,m.[WeeklyReach][masterWeeklyReach]
		,m.[WeeklyViewingHours][masterWeeklyViewingHours]
		,m.[TotalWeeklyAudienceHours][masterTotalWeeklyAudienceHours]
		,m.[HoursPerListenerAverage][masterHoursPerListenerAverage]
		,m.[HoursPerHeadAverage][masterHoursPerHeadAverage]

		,m.[UpdateComment][masterUpdateComment]
		,m.[SysStartTime][masterSysStartTime]
		,m.[SysEndTime][masterSysEndTime]
		,m.[IsCurrent][masterIsCurrent]

		,c.[WeeklyReach]
		,c.[WeeklyViewingHours]
		,c.[TotalWeeklyAudienceHours]
		,c.[HoursPerListenerAverage]
		,c.[HoursPerHeadAverage]

		,c.[UpdatedBy]
		,c.[UpdateComment]
		,c.[SysStartTime][calculationSysStartTime]
		,c.[SysEndTime][calculationSysEndTime]
		,c.[IsCurrent][calculationIsCurrent]


		,i.[intervalSysTime][SysStartTime]
		,coalesce(lead(i.[intervalSysTime]) over (partition by i.[DistributionGroupCode],i.[DistributionCode],i.[Society],i.[StationID] order by i.[intervalSysTime]),'31 DEC 9999')[SysEndTime]
from intervaldates i
left join [FPV].[vMasterAudienceReach] m on m.[DistributionGroupCode]=i.[DistributionGroupCode]
										and m.[DistributionCode]=i.[DistributionCode]
										and m.[Society]=i.[Society]
										and m.[StationID]=i.[StationID]
								and i.[intervalSysTime] between m.SysStartTime and m.SysEndTime
left join [FPV].[vCalculationGroupAudienceReach] c on c.[DistributionGroupCode]=i.[DistributionGroupCode]
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

		,[masterWeeklyReach]
		,[masterWeeklyViewingHours]
		,[masterTotalWeeklyAudienceHours]
		,[masterHoursPerListenerAverage]
		,[masterHoursPerHeadAverage]

		,[masterUpdateComment]
		,[masterSysStartTime]
		,[masterSysEndTime]
		,[masterIsCurrent]

		,[WeeklyReach]
		,[WeeklyViewingHours]
		,[TotalWeeklyAudienceHours]
		,[HoursPerListenerAverage]
		,[HoursPerHeadAverage]

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
		
		,[masterUpdateComment]
		,[masterSysStartTime]
		,[masterSysEndTime]
		,[masterIsCurrent]
				
		,[masterWeeklyReach]
		,[masterWeeklyViewingHours]
		,[masterTotalWeeklyAudienceHours]
		,[masterHoursPerListenerAverage]
		,[masterHoursPerHeadAverage]

		,[WeeklyReach]
		,[WeeklyViewingHours]
		,[TotalWeeklyAudienceHours]
		,[HoursPerListenerAverage]
		,[HoursPerHeadAverage]

		,[UpdatedBy]
		,FPV.udfRemoveStringCharacters([UpdateComment])[UpdateComment]
		,[calculationSysStartTime]
		,[calculationSysEndTime]
		,[calculationIsCurrent]
		,[SysStartTime]
		,[SysEndTime]
		,case when [Recency]=1 then [Recency] else 0 end [IsCurrent]
		from recency