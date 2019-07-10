
CREATE FUNCTION [FPV].[udfDistributionData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	DISTINCT datasource.[DistributionCode]
			,datasource.[DistributionStartDate]
			,datasource.[DistributionEndDate]
	FROM	[FPV].[Distribution] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID

	--FILTER ON A SPECIFIED DISTRIBUTION GROUP
	AND (
		filters.[DistributionCode] IS NULL 
		OR 
		datasource.[DistributionCode] = filters.[DistributionCode]
		)
)