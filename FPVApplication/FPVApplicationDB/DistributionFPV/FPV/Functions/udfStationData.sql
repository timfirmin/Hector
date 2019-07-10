 --=============================================
-- Last Change By: TJF 2019APR24 Removed Seed,Prev,Current and 'i' to 'master'
-- Last Change By: TJF 2019APR25 Further Field Removal - Calculation fields 
-- Last Change By: TJF 2019APR30 Removed RegionalParentStationFlag
-- Last Change By: TJF 2019APR30 CODACustomerCode Request Filter
-- Test : Select * from [FPV].[udfStationData]  (74937)
-- =============================================
CREATE FUNCTION [FPV].[udfStationData]
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT s.[Society]
      ,s.[DistributionGroupCode]
      ,s.[DistributionCode]
      --,s.[CalculationPeriodStatus]
      --,s.[CalculationPeriodStart]
      --,s.[CalculationPeriodEnd]
      --,s.[masterDistributionGroupCode]
      ,s.[masterStationID]
      ,s.[masterStationName]
	  --Added 2018NOV23
	  ,s.[masterCodaCustomerCode]
 
      ,s.[masterStationStatus]
		--Added 2018SEP04
      ,s.[masterAudioPolicyMain]
      ,s.[masterAudioPolicyCommercial]
      ,s.[masterCommercialSampleDays]
      ,s.[masterNonCommercialSampleDays]
      ,s.[masterTotalSampleDays]
		--Added 2018SEP19
      ,s.[masterMinimumFee]
      ,s.[masterBroadcastHours]

      ,s.[masterGroupAdminRate]
      ,s.[masterHedgePercent]
      ,s.[masterHedgePercentMCPS]
      ,s.[masterPRAdminRate]
      ,s.[masterIsExcluded]

		--Added 2018SEP04
      ,s.[AudioPolicyMain]
      ,s.[AudioPolicyCommercial]
      ,s.[CommercialSampleDays]
      ,s.[NonCommercialSampleDays]
      ,s.[TotalSampleDays]
		--Added 2018SEP19
      ,s.[MinimumFee]
      ,s.[BroadcastHours]

	  	  --Added 2019FEB15
      --,s.[RegionalParentStationFlag]
      ,s.[RegionalParentStationId]
      ,s.[RegionalWeightingPRS]
      ,s.[RegionalWeightingMCPS]

	  ,s.[LicenceFeeSplitPercent]
 
	  ,s.[FPVStatus]
    
		--Added 2019FEB15
	  -- ,s.[masterRegionalParentStationFlag]
      ,s.[masterRegionalParentStationId]
      ,s.[masterRegionalWeightingPRS]
      ,s.[masterRegionalWeightingMCPS]

	,'' as [masterUpdateComment]

      ,s.[masterSysStartTime]
      ,s.[masterSysEndTime]
      ,s.[StationID]
      ,s.[StationName]

 
      ,s.[StationStatus]
      ,s.[GroupAdminRate]
      ,s.[HedgePercent]
      ,s.[HedgePercentMCPS]
      ,s.[PRAdminRate]
      ,s.[IsExcluded]

      ,s.[UpdatedBy]
      ,s.[UpdateComment]
      ,s.[SysStartTime]
      ,s.[SysEndTime]
	  --,s.[CalculationGroupIsCurrent]
	  ,s.[masterIsCurrent]
      --,s.[CalculationGroupStationIsCurrent]
	  ,s.[IsCurrent]
  FROM [FPV].[vApplicationStationView] s,[FPV].[vRequestFilters] r
  WHERE	r.RequestID=@RequestID
		AND
		--apply filters
		(
			--temporal data filter
			(
				(	
					(r.[TemporalView] IS NULL OR r.[TemporalView] ='Current')
					AND 
					(s.[IsCurrent]=1)
				)
				OR
				(
					r.[TemporalView] = 'Historical'
				)
			)
			AND
			(
				(r.[DistributionGroupCode] IS NULL OR s.[DistributionGroupCode] = r.[DistributionGroupCode])
				AND
				(r.[DistributionCode] IS NULL OR s.[DistributionCode]=r.[DistributionCode])
				AND
				(r.[Society] IS NULL OR s.[Society]=r.[Society])
			)
			--APPLY CODA Customer Code Filter
			AND (	r.[CodaCustomerCode] IS NULL 
					OR 
					[FPV].[udfGetCodaCustomerCode]  (s.[StationID]) = r.[CodaCustomerCode])
			AND (s.[masterStationID]=r.[StationID] OR r.[StationID] IS NULL)
			AND (s.[FPVStatus]=r.[FPVStatus] OR r.[FPVStatus] IS NULL)
		)

)
GO

