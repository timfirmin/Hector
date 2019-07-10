﻿
--=============================================
-- TJF 2019JAN20 Created
-- Last Change 2019APR30 - Implement StationID and CODACustomerCode Request Filter
-- Test : Select * from [FPV].[udfPublicReceptionData]  (74937)
-- =============================================

CREATE FUNCTION [FPV].[udfPublicReceptionData] 
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
			,datasource.[masterUpdateComment]
			,datasource.[masterSysStartTime]
			,datasource.[masterSysEndTime]
			,datasource.[masterIsCurrent]
			,datasource.[masterTotalPRAllocation]
			,datasource.[TotalPRAllocation]
			,datasource.[UpdatedBy]
			,datasource.[UpdateComment]
			,datasource.[SysStartTime]
			,datasource.[SysEndTime]
			,datasource.[IsCurrent]
	FROM	[FPV].[vApplicationPublicReceptionView] datasource,[FPV].[vRequestFilters] filters
	WHERE	filters.RequestID=@RequestID
 
	--APPLY Station ID Filter
	AND (	filters.[StationID] IS NULL 
			OR 
			datasource.[StationID] = filters.[StationID])
	--APPLY CODA Customer Code Filter
	AND (	filters.[CodaCustomerCode] IS NULL 
			OR 
			[FPV].[udfGetCodaCustomerCode]  (datasource.[StationID]) = filters.[CodaCustomerCode])
	AND (filters.[DistributionGroupCode] IS NULL OR datasource.[DistributionGroupCode] IS NULL OR datasource.[DistributionGroupCode] = filters.[DistributionGroupCode])
	AND (filters.[DistributionCode] IS NULL OR datasource.[DistributionCode] IS NULL OR datasource.[DistributionCode] = filters.[DistributionCode])
	AND (filters.[Society] IS NULL OR datasource.[Society] IS NULL OR datasource.[Society] = filters.[Society])
	AND (((filters.[TemporalView] IS NULL OR filters.[TemporalView] ='CURRENT') AND datasource.[IsCurrent]=1)
			OR
		(filters.[TemporalView]='HISTORICAL'))
)