
--=============================================
-- TJF 2019JAN20 Created
-- Last Change 2019APR30 - Implement StationID and CODACustomerCode Request Filter
-- Test : Select * from [FPV].[udfFPVCalculationData]  (74937)
-- =============================================
CREATE FUNCTION [FPV].[udfFPVCalculationData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	
		[datasource].[DistributionGroupCode]
		,[datasource].[DistributionCode]
		,[datasource].[Society]
		,[datasource].[StationID]
		,[datasource].[EventSysDateTime]
		,[datasource].[EventComment]
		,[datasource].[CalculationDef]
		,[datasource].[CalculationValue]
		,[datasource].[CalculationStatus]
		,[datasource].[SysCalcTime]
		,[datasource].[UpdateComments]
		,[datasource].[UpdatedBy]
		,[datasource].[SysStartTime]
		,[datasource].[SysEndTime]
		,[datasource].[IsCurrent]
	FROM	[FPV].[vApplicationFPVCalculationView] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID

	--APPLY FILTERS
	AND (filters.[DistributionGroupCode] IS NULL OR datasource.[DistributionGroupCode] = filters.[DistributionGroupCode])
	AND (filters.[DistributionCode] IS NULL OR datasource.[DistributionCode] = filters.[DistributionCode])
	AND (filters.[Society] IS NULL OR datasource.[Society] = filters.[Society])
	AND (filters.[StationID] IS NULL OR datasource.[StationID]=filters.[StationID])
	--APPLY CODA Customer Code Filter
	AND (	filters.[CodaCustomerCode] IS NULL 
			OR 
			[FPV].[udfGetCodaCustomerCode]  (datasource.[StationID]) = filters.[CodaCustomerCode])
	AND (((filters.[TemporalView] IS NULL OR filters.[TemporalView] ='CURRENT') AND datasource.[IsCurrent]=1)
			OR
		(filters.[TemporalView]='HISTORICAL'))
)