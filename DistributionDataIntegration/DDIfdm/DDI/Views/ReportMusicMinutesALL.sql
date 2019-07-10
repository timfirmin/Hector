
create view DDI.ReportMusicMinutesALL
as


SELECT 
	   dmm.[DistributionGroupCode]
      ,dmm.[DistributionCode]
	  ,dc.[DistributionYear]
	  ,dc.[SortOrder] DistributionOrder
      ,dmm.[CompanyCode]
      ,dmm.[StationCode]
      ,dmm.[StationName]
      ,dmm.[MasterStationId]
      ,dmm.[SongsProgrammeForecast]
      ,dmm.[NonSongNonProgrammeForecast]
      ,dmm.[CommercialForecast]
      ,dmm.[LateDataForecast]
      ,dmm.[TotalForecast]

  FROM [FinanceDataMart].[DDI].DistributionMusicMinutes dmm
  JOIN [DDI].[DistributionCodes] dc on dmm.[DistributionCode] = dc.[DistributionCode]