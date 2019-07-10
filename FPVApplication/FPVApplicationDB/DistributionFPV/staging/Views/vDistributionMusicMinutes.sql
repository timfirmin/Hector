CREATE VIEW staging.vDistributionMusicMinutes
AS
SELECT 
		 mm.[DistributionGroupCode]
		,mm.[DistributionCode]
		,mm.[Society]
		,mm.[StationID]
		,mm.[MasterStationId]
		,mm.[ProgrammeForecast]
		,mm.[NonProgrammeForecast]
		,mm.[CommercialForecast]
		,mm.[LateDataForecast]
		,mm.[TotalForecast]
		,isnull(sd.[SongsProgrammeSampleDates],0) as [SongsProgrammeSampleDates]
		,isnull(sd.[NonSongProgrammeSampleDates],0) as [NonSongProgrammeSampleDates]
		,isnull(sd.[CommercialSampleDates],0) as [CommercialSampleDates]
		,isnull(sd.[CommercialForecastPercentage],0) as [CommercialForecastPercentage]
		,mm.[InsertLoadId]
		,mm.[InsertTimeStamp]
FROM [staging].[DistributionMusicMinutes] mm
LEFT JOIN [staging].[DistributionSampleDates] sd
ON  mm.[DistributionGroupCode]   = sd.[DistributionGroupCode]
and mm.[DistributionCode]   = sd.[DistributionCode]
and mm.[Society]   = sd.[Society]
and mm.[StationID]   = sd.[StationID]