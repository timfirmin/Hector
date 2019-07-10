
CREATE VIEW [staging].[vDistributionMusicMinutes]
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
		,mm.[TotalInPeriodForecast]
		,mm.[TotalForecast]
		--Added 2018Nov21

		,isnull(mm.[HighPeakPercent],0) as [HighPeakPercent]
		,isnull(mm.[LowPeakPercent],0) as [LowPeakPercent]
		,isnull(mm.[NonPeakPercent],0) as [NonPeakPercent]
		
		,Case isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) 
			when 1 then 0 else 1 end as PeakAdjustmentRequired
		,
		case when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) = 0 then 0.2
		when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) > 1 then 0.2
		when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) <= 1 then isnull(mm.[HighPeakPercent],0)
		end as [AdjHighPeakPercent]
					
		,
		case when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) = 0 
		then 
			Case mm.[DistributionGroupCode]
				when 'ILR' then 0.8 
				else 0.3
			End 
		when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) > 1 
		then 
			Case mm.[DistributionGroupCode]
				when 'ILR' then 0.8 
				else 0.3
			End 
		when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) <= 1 
		then 
			Case mm.[DistributionGroupCode]
				when 'ILR' then 1 - isnull(mm.[HighPeakPercent],0)
				else isnull(mm.[LowPeakPercent],0)
			End 		
		end as [AdjLowPeakPercent]

		,
		case when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) = 0 
		then 
			Case mm.[DistributionGroupCode]
				when 'ILR' then 0
				else 0.5
			End 
		when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) > 1 
		then 
			Case mm.[DistributionGroupCode]
				when 'ILR' then 0
				else 0.5
			End 
		when isnull(mm.[HighPeakPercent],0) + isnull(mm.[LowPeakPercent],0) + isnull(mm.[NonPeakPercent],0) <= 1 
		then 
			Case mm.[DistributionGroupCode]
				when 'ILR' then 0
				else 1 - (isnull(mm.[LowPeakPercent],0) + isnull(mm.[HighPeakPercent],0))
			End 		
		end as [AdjNonPeakPercent]
 
		,mm.[Comment]
		,mm.[InsertLoadId]
		,mm.[InsertTimeStamp]

FROM [staging].[DistributionMusicMinutes] mm