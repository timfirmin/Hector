

CREATE VIEW [staging].[vAudienceReachRAJAR]
as

/****** 

       [PopulationAvg]  = Mean(Population 000s)
	   [Reach1000sAvg] = Mean(Reach 000s)
       [HoursPerListenerAvg] = Total Hours 000s / Reach 000s 
       [HoursPerHeadAvg] = Total Hours 000s / Population 000s 
       [TotalHours1000sAvg] = Mean(Total Hours) 

 ******/
 
 with cte_Fulfill4Quarters as 
 (
 SELECT DISTINCT   
dates.[DistributionCode]
,COUNT(DISTINCT dates.[CalendarYearQuarter]) QuartersWithinDistribution
,4/COUNT(DISTINCT dates.[CalendarYearQuarter]) QuartersMissingFactor
  FROM [staging].[AudienceReachRAJAR] rjr 
  JOIN [FPV].[DistributionRevenueCalendar] dates 
  ON rjr.[YearQuarter]  = dates.[CalendarYearQuarter]
GROUP BY dates.[DistributionCode]
)
SELECT 
	    'PRS' as Society
	  ,stn.DistributionGroup as [DistributionGroupCode]
		 ,datemap.DistributionCode
		, arr.[StationGroup]
		, arr.[StationId]
      --,[YearQuarter]
	  ,avg([Population000s]) as [PopulationAverage]
      ,avg([Reach000s]) as [AudienceAverage]
      ,(sum([TotalHours000s]*cte.QuartersMissingFactor) / avg([Reach000s])) * 1000 as [HoursPerListenerAvg]
      ,(sum([TotalHours000s]*cte.QuartersMissingFactor) / avg([Population000s])) * 1000 as [HoursPerHeadAvg]

  FROM [staging].[AudienceReachRAJAR] arr 
  JOIN (SELECT DISTINCT [CalendarYearQuarter],[DistributionCode] FROM [FPV].[DistributionRevenueCalendar]) datemap 
			on arr.[YearQuarter]  = datemap.CalendarYearQuarter
  JOIN cte_Fulfill4Quarters cte on datemap.DistributionCode = cte.[DistributionCode]
  JOIN [staging].[MasterStation] stn on arr.[StationId] = stn.Code
  group by 
	datemap.DistributionCode
	, arr.[StationGroup]
	, arr.[StationId]
	,stn.DistributionGroup