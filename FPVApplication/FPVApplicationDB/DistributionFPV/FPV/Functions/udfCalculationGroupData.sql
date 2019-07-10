
--=============================================
-- Author:		tim firmin
-- Create date: 2018AUG10
-- Description:	Added Status Summary Counts
-- =============================================
CREATE FUNCTION [FPV].[udfCalculationGroupData] 
(	
	-- Add the parameters for the function here
	@RequestID int
--   select * from [FPV].[udfCalculationGroupData](33877)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	
	     datasource.[DistributionGroupCode]
		,datasource.[DistributionCode]
		,datasource.[Society]
		,datasource.[CalculationGroupStatus]
		,datasource.[CalculationPeriodStart]
		,datasource.[CalculationPeriodEnd]
		,datasource.[UpdatedBy]
		,datasource.[UpdateComment]
		,datasource.[SysStartTime]
		,datasource.[SysEndTime]
		,1 as [IsCurrent]
	FROM	[FPV].[CalculationGroup] datasource,[FPV].[vRequestFilters] filters

	WHERE	filters.RequestID=@RequestID
	--APPLY FILTERS
	AND (filters.[DistributionGroupCode] IS NULL OR datasource.[DistributionGroupCode] = filters.[DistributionGroupCode])
	AND (filters.[DistributionCode] IS NULL OR datasource.[DistributionCode] = filters.[DistributionCode])
	AND (filters.[Society] IS NULL OR datasource.[Society] = filters.[Society])
	AND (filters.[CalculationGroupStatus] IS NULL OR datasource.[CalculationGroupStatus] = filters.[CalculationGroupStatus])
)