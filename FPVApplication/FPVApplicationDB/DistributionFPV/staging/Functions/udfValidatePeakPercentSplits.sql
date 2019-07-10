CREATE FUNCTION staging.[udfValidatePeakPercentSplits] ()

RETURNS TABLE 
AS
RETURN 
(
SELECT [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]

	  ,Cast(Cast(([HighPeakPercent])*100 as decimal(18,2)) as varchar(10)) + ' % / '  +
	   Cast(Cast(([LowPeakPercent])*100 as decimal(18,2)) as varchar(10)) + ' % / ' +
	   Cast(Cast(([NonPeakPercent])*100 as decimal(18,2)) as varchar(10)) + ' %' as [OriginalPeakPercent]

	  ,Cast(Cast(([AdjHighPeakPercent])*100 as decimal(18,2)) as varchar(5)) + ' % / '  +
	   Cast(Cast(([AdjLowPeakPercent])*100 as decimal(18,2)) as varchar(5)) + ' % / ' +
	   Cast(Cast(([AdjNonPeakPercent])*100 as decimal(18,2)) as varchar(5)) + ' %' as [AdjustedPeakPercent]

	  ,[PeakAdjustmentRequired]
  FROM [staging].[vDistributionMusicMinutes]
  where [PeakAdjustmentRequired] = 1
)