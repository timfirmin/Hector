








CREATE VIEW [DDItransform].[vDistributionMusicMinutes]
AS

SELECT 
	   CAST(HashBytes('SHA1', ISNULL(dmm.[DistributionGroupCode], 'Unknown') + ISNULL(dmm.[DistributionCode], 'Unknown') + ISNULL(dmm.[CompanyCode], 'Unknown') + ISNULL(dmm.[StationCode], 'Unknown')) AS bigint) as DistributionMusicMinutesKey
	  ,CAST(ISNULL(dmm.[DistributionGroupCode], 'Unknown')				AS varchar(50))	as [DistributionGroupCode]
	  ,CAST(ISNULL(dmm.[DistributionCode], 'Unknown')				AS varchar(50))	as [DistributionCode]
	  ,CAST(ISNULL(dmm.[CompanyCode], 'Unknown')					AS varchar(50))	as [CompanyCode]
	  ,CAST(ISNULL(dmm.[StationCode], 'Unknown')					AS varchar(50))	as [StationCode]
	  ,CAST(ISNULL(dmm.[StationName], 'Unknown')					AS varchar(100))	as [StationName]	
	 -- ,ms.Code as MasterStationId	    
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([SongsProgrammeForecast],' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([SongsProgrammeForecast],' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as [SongsProgrammeForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([NonSongNonProgrammeForecast],' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([NonSongNonProgrammeForecast],' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as		[NonSongNonProgrammeForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([CommercialForecast],' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([CommercialForecast],' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as [CommercialForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([TotalInPeriodForecast],' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([TotalInPeriodForecast],' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as [TotalInPeriodForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([LateDataForecast],' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([LateDataForecast],' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as [LateDataForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([TotalForecast],' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([TotalForecast],' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as [TotalForecast]
 	 
		,(CASE WHEN	ISNUMERIC(ltrim(rtrim(replace(replace(replace(HighPeakPercent,' ',''),'-','0'),'£','')))) = 1 
		THEN 
		(CASE WHEN charindex('%',HighPeakPercent,1) > 0 then
		CAST(ltrim(rtrim(replace(replace(replace(HighPeakPercent,' ',''),'-','0'),'£','')))/100 as decimal(12,5))
		ELSE
		CAST(ltrim(rtrim(replace(replace(replace(HighPeakPercent,' ',''),'-','0'),'£',''))) as decimal(12,5))
		END 
		)
		ELSE 0 END) as HighPeakPercent

				,(CASE WHEN	ISNUMERIC(ltrim(rtrim(replace(replace(replace(LowPeakPercent,' ',''),'-','0'),'£','')))) = 1 
		THEN 
		(CASE WHEN charindex('%',LowPeakPercent,1) > 0 then
		CAST(ltrim(rtrim(replace(replace(replace(LowPeakPercent,' ',''),'-','0'),'£','')))/100 as decimal(12,5))
		ELSE
		CAST(ltrim(rtrim(replace(replace(replace(LowPeakPercent,' ',''),'-','0'),'£',''))) as decimal(12,5))
		END 
		)
		ELSE 0 END) as LowPeakPercent	

		,(CASE WHEN	ISNUMERIC(ltrim(rtrim(replace(replace(replace(NonPeakPercent,' ',''),'-','0'),'£','')))) = 1 
		THEN 
		(CASE WHEN charindex('%',NonPeakPercent,1) > 0 then
		CAST(ltrim(rtrim(replace(replace(replace(NonPeakPercent,' ',''),'-','0'),'£','')))/100 as decimal(12,5))
		ELSE
		CAST(ltrim(rtrim(replace(replace(replace(NonPeakPercent,' ',''),'-','0'),'£',''))) as decimal(12,5))
		END 
		)
		ELSE 0 END) as NonPeakPercent
		 
	  ,CAST(ISNULL(dmm.[Comment], '')					AS varchar(255))	as [Comment]
      
	  
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([SongsProgrammeForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as [SongsProgrammeForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([NonSongNonProgrammeForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y'  ELSE 'N'  END) as		[NonSongNonProgrammeForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([CommercialForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y'ELSE 'N'  END) as [CommercialForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalInPeriodForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N'  END) as [TotalInPeriodForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([LateDataForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N'  END) as [LateDataForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N'  END) as [TotalForecastValidYN]
	  
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([SongsProgrammeForecast],''),0),' ',''),'-','0'),'£','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([NonSongNonProgrammeForecast],''),0),' ',''),'-','0'),'£','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([CommercialForecast],''),0),' ',''),'-','0'),'£','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalInPeriodForecast],''),0),' ',''),'-','0'),'£','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([LateDataForecast],''),0),' ',''),'-','0'),'£','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalForecast],''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N'  END) as [StagingRowValidFlag]

      ,dmm.[FileLogKey]
	  --,CONVERT(datetime2, ISNULL(el2.adddate, '31/12/2999'), 103)						AS [xxxDate]	
      ,dmm.[InsertTimeStamp]
      ,dmm.[InsertLoadId]
      ,dmm.[InsertBy]
  FROM [DDIstaging].[DistributionMusicMinutes] dmm