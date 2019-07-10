-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FPV].[udfDistributionGroupData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(

	SELECT	d.[DistributionGroupCode]
			,d.[Enabled]
			,d.[HighPeakTimeBandFactor]
			,d.[LowPeakTimeBandFactor]
			,d.[NonPeakTimeBandFactor]	
	FROM	[FPV].[DistributionGroup] d,[FPV].[ApplicationRequest] r
	WHERE	r.RequestID=@RequestID

	--FILTER ON A SPECIFIED DISTRIBUTION GROUP
	AND (
		json_value(r.RequestFilters,'$.DistributionGroupCode') IS NULL 
		OR 
		d.[DistributionGroupCode] = json_value(r.RequestFilters,'$.DistributionGroupCode')
		)

	--FILTER ON ENABLED STATUS
	AND (
		json_value(r.RequestFilters,'$.Enabled') IS NULL 
		OR 
		d.[Enabled] = json_value(r.RequestFilters,'$.Enabled')
		)

)