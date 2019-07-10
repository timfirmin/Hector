
 --=============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FPV].[udfSocietyData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	datasource.[Society]
			,datasource.[Enabled]
	FROM	[FPV].[Society] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID

	--FILTER ON A SPECIFIED DISTRIBUTION GROUP
	AND (filters.[Society] IS NULL OR datasource.[Society] = filters.[Society])
	--FILTER ON ENABLED STATUS
	AND (filters.[Enabled] IS NULL OR datasource.[Enabled] = filters.[Enabled])

)