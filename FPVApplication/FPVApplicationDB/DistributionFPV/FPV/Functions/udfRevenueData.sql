--=============================================
-- TJF 2019JAN20 Created
-- Last Change 2019APR30 - Implement StationID and CODACustomerCode Request Filter
-- Last Change 2019MAY02 - Removed Scenario and Revenue
-- Test : Select * from [FPV].[udfRevenueData]  (74937)
-- =============================================
CREATE FUNCTION [FPV].[udfRevenueData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	
		 datasource.[DistributionGroupCode]
		,datasource.[DistributionCode]
		,datasource.[Society]
		,datasource.[StationID]

		,datasource.[CodaCustomerCode]
		,datasource.[CodaCustomerDescription]
		--,datasource.[Scenario]

		--,datasource.[Revenue]
		--Added 2019APR17
		--,datasource.[StationID][workingStationID]

		--Added 2019MAR08
		,datasource.[AnnualMusicMinutes]
		,datasource.[MusicUsage]
		,datasource.[MusicConsumption]
		,datasource.[ConsumptionSplit]
		,datasource.[RevenueApportionment]
		--,datasource.[CurrentRevenue]
		,datasource.[TotalRevenueApportionment]
		,datasource.PercentageSplit 
		,datasource.[UpdatedBy]
		,datasource.[UpdateComment]
		,datasource.[SysStartTime]
		,datasource.[SysEndTime]
		,datasource.[IsCurrent]
	FROM	[FPV].[vApplicationRevenueView] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID
		--APPLY Station ID Filter
	AND (	filters.[StationID] IS NULL 
			OR 
			datasource.[StationID] = filters.[StationID])
	--APPLY CODA Customer Code Filter
	AND (	filters.[CodaCustomerCode] IS NULL 
			OR 
			[FPV].[udfGetCodaCustomerCode]  (datasource.[StationID]) = filters.[CodaCustomerCode])
	--APPLY FILTERS
	AND (filters.[DistributionGroupCode] IS NULL OR datasource.[DistributionGroupCode] = filters.[DistributionGroupCode])
	AND (filters.[DistributionCode] IS NULL OR datasource.[DistributionCode] = filters.[DistributionCode])
	AND (filters.[Society] IS NULL OR datasource.[Society] = filters.[Society])
	AND (((filters.[TemporalView] IS NULL OR filters.[TemporalView] ='CURRENT') AND datasource.[IsCurrent]=1)
			OR
		(filters.[TemporalView]='HISTORICAL'))
)
GO

