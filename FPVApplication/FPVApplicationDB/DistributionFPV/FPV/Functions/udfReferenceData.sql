

 --=============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FPV].[udfReferenceData] 
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	datasource.[UsageType]
			,datasource.[RefDataCategory]
			,datasource.[RefDataGroup]
			,datasource.[RefDataName]
			,datasource.[RefDataType]
			,datasource.[RefDataValue]
			,datasource.[SysStartTime]
			,datasource.[SysEndTime]
			,datasource.[IsCurrent]
	FROM	[FPV].[vReferenceData] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID

	--system versioned table so default to only return current data unless historical data is specifically requested
	AND ( 
			((filters.[TemporalView] IS NULL OR filters.[TemporalView]='Current') AND datasource.[IsCurrent]=1) 
			OR 
			(filters.[TemporalView]='Historical')
		)
	AND (filters.[UsageType] IS NULL OR datasource.[UsageType] = filters.[UsageType])
	AND (filters.[RefDataCategory] IS NULL OR datasource.[RefDataCategory] = filters.[RefDataCategory])
	AND (filters.[RefDataGroup] IS NULL OR datasource.[RefDataGroup] = filters.[RefDataGroup])
	AND (filters.[RefDataName] IS NULL OR datasource.[RefDataName] = filters.[RefDataName])

)