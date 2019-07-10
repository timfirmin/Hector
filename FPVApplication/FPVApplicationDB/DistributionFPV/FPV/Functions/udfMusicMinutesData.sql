

--=============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FPV].[udfMusicMinutesData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	datasource.[DistributionGroupCode]
			,datasource.[DistributionCode]
			,datasource.[Society]
			,datasource.[StationID]
			,datasource.[masterProgrammeForecast]
			,datasource.[masterNonProgrammeForecast]
			,datasource.[masterCommercialForecast]
			,datasource.[masterTotalInPeriodForecast]
			,datasource.[masterLateDataForecast]
			,datasource.[masterTotalForecast]
			,datasource.[masterHighPeakPercent]
			,datasource.[masterLowPeakPercent]
			,datasource.[masterNonPeakPercent]
			,datasource.[masterUpdateComment]
			,datasource.[masterSysStartTime]
			,datasource.[masterSysEndTime]
			,datasource.[masterIsCurrent]
			,datasource.[ProgrammeForecast]
			,datasource.[NonProgrammeForecast]
			,datasource.[CommercialForecast]
			,datasource.[TotalInPeriodForecast]
			,datasource.[LateDataForecast]
			,datasource.[TotalForecast]
			,datasource.[HighPeakPercent]
			,datasource.[LowPeakPercent]
			,datasource.[NonPeakPercent]
			,datasource.[UpdatedBy]
			,datasource.[UpdateComment]
			,datasource.[SysStartTime]
			,datasource.[SysEndTime]
			,datasource.[IsCurrent]
	FROM	[FPV].[vApplicationMusicMinutesView] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID

	--APPLY FILTERS
	AND (	filters.[DistributionGroupCode] IS NULL 
			OR 
			datasource.[DistributionGroupCode] = filters.[DistributionGroupCode])
	AND (	filters.[DistributionCode] IS NULL 
			OR 
			datasource.[DistributionCode] = filters.[DistributionCode])
	AND (	filters.[Society] IS NULL 
			OR 
			datasource.[Society] = filters.[Society])
	AND (((filters.[TemporalView] IS NULL OR filters.[TemporalView] ='CURRENT') AND datasource.[IsCurrent]=1)
			OR
		(filters.[TemporalView]='HISTORICAL'))
)