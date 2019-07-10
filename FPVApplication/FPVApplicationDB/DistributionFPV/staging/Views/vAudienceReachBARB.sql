


CREATE VIEW [staging].[vAudienceReachBARB]
as
WITH cte_barbweeks as 
(
SELECT distinct   
 barb.[DateKey]
,dates.[DistributionCode]
  FROM [staging].[AudienceReachBARB] barb join [FPV].[DistributionRevenueCalendar] dates on barb.[DateKey]  = dates.[DateKey]
),
cte_barbmetadata as 
(
select [DistributionCode], max(DateKey) as WorkingWeekDate, count([DateKey]) as WeeksInDistribution, cast(52 as decimal(10,3))/count([DateKey]) as WeekMultiple from cte_barbweeks group by [DistributionCode]
)

SELECT 
	  'PRS' as [Society]
	  ,stn.DistributionGroup as [DistributionGroupCode]
	  ,cte.[DistributionCode]
	  ,src.[StationId]

	  ,sum(src.[WeeklyReach]) * cte.WeekMultiple as  [WeeklyReachTotal52Weeks]
	  ,sum(src.[WeeklyViewingHours]) * cte.WeekMultiple as [WeeklyViewingHoursTotal52Weeks]

      --,sum(case when src.DateKey = cte.WorkingWeekDate then src.[WeeklyReach] else 0 end) as [WeeklyReachLastWeek]
      --,sum(case when src.DateKey = cte.WorkingWeekDate then src.[WeeklyViewingHours] else 0 end) as [WeeklyViewingHoursLastWeek]
      --,sum(case when src.DateKey = cte.WorkingWeekDate then src.[[WeeklyViewingHours]] else 0 end) as [TotalWeeklyAudienceHoursLastWeek]
	  
	  --Change in Logic Following Business Confirmation
	  ,(sum(src.[WeeklyReach]) * cte.WeekMultiple)/52 as [WeeklyReachTotal]
	  ,(sum(src.[WeeklyViewingHours]) * cte.WeekMultiple)/52 as [WeeklyViewingHours]
	  ,((sum(src.[WeeklyReach]) * cte.WeekMultiple)/52) * ((sum(src.[WeeklyViewingHours]) * cte.WeekMultiple)/52) * 1000 as [TotalWeeklyAudienceHours]

  FROM [staging].[AudienceReachBARB] src join cte_barbmetadata cte on src.[DateKey]    = cte.WorkingWeekDate
  join [staging].[MasterStation] stn on src.[StationId] = stn.Code

  group by 
  	   stn.DistributionGroup 
	  ,cte.[DistributionCode]
	  ,src.[StationId]
	  ,cte.WeekMultiple