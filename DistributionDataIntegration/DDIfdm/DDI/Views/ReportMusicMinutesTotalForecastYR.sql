 

create view DDI.ReportMusicMinutesTotalForecastYR
as
SELECT 
[DistributionGroupCode]
,[CompanyCode]
,[StationCode]
,[StationName]
,'AverageTotalForecast' as [AverageMinutesTotal], 
[2017],[2018],[2019],[2020],[2021]
FROM	  
(SELECT 
	   dmm.[DistributionGroupCode]
	  ,dc.[DistributionYear]
      ,dmm.[CompanyCode]
      ,dmm.[StationCode]
      ,dmm.[StationName]
      ,dmm.[TotalForecast]
  FROM [FinanceDataMart].[DDI].DistributionMusicMinutes dmm
  JOIN [DDI].[DistributionCodes] dc on dmm.[DistributionCode] = dc.[DistributionCode]) src
  PIVOT
  (
  AVG([TotalForecast])
  FOR 
[DistributionYear]
	IN
	([2017],[2018],[2019],[2020],[2021])
  ) as PivotTable;