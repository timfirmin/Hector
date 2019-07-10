




create view [FPV].[vMasterAudienceReach]
as

select 		[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]

      ,[WeeklyReach]
      ,[WeeklyViewingHours]
      ,[TotalWeeklyAudienceHours]

      ,[HoursPerListenerAverage]
      ,[HoursPerHeadAverage]

		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,1 [IsCurrent]
from [FPV].[MasterAudienceReach]
union
select 		[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		     ,[WeeklyReach]
      ,[WeeklyViewingHours]
      ,[TotalWeeklyAudienceHours]

      ,[HoursPerListenerAverage]
      ,[HoursPerHeadAverage]
		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,dateadd(ms,-1,[SysEndTime])[SysEndTime]
		,0 [IsCurrent]
from [FPV].[MasterAudienceReachHistory]