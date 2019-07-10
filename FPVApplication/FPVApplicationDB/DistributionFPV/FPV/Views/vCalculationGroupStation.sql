
CREATE VIEW [FPV].[vCalculationGroupStation]
AS
--Abacus Response Improvements Jan 2019 Added CalculationGroupStationKey
WITH Holistic AS (
SELECT 
	  CAST(HashBytes('SHA1', [DistributionGroupCode] + [DistributionCode] + [Society] + [StationID]) AS bigint) CalculationGroupStationKey
	  ,[DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[StationName]
  
	  ,[StationStatus]
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
	  --,[Revenue]
      ,[IsExcluded]
	  --Added 2018AUG03
      --,[Diversity]
      --,[LowRevenue]
	  --Added 2018SEP04
		,[AudioPolicyMain]
		,[AudioPolicyCommercial]
		,[CommercialSampleDays]
		,[NonCommercialSampleDays]
		,[TotalSampleDays]
	--Added 2018SEP19
	,[MinimumFee]
	,[BroadcastHours]
	--Added 2018OCT16
	,[LicenceFeeSplitPercent] 
	  ,[FPVStatus]
	  --Added 2019FEB15
	  ,[RegionalParentStationFlag]
	  ,[RegionalParentStationId]
	  ,[RegionalWeightingPRS]
	  ,[RegionalWeightingMCPS]
      ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,[SysEndTime]
	  ,1 [IsCurrent]
  FROM [FPV].[CalculationGroupStation]
UNION
SELECT 
		  CAST(HashBytes('SHA1', [DistributionGroupCode] + [DistributionCode] + [Society] + [StationID]) AS bigint) CalculationGroupStationKey
		,[DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[StationName]

	  ,[StationStatus]
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
	  --,[Revenue]
      ,[IsExcluded]
 
	  --Added 2018SEP04
		,[AudioPolicyMain]
		,[AudioPolicyCommercial]
		,[CommercialSampleDays]
		,[NonCommercialSampleDays]
		,[TotalSampleDays]
	--Added 2018SEP19
	,[MinimumFee]
	,[BroadcastHours]
	--Added 2018OCT16
	,[LicenceFeeSplitPercent] 
	  ,[FPVStatus]
	--Added 2019FEB15
	  ,[RegionalParentStationFlag]
	  ,[RegionalParentStationId]
	  ,[RegionalWeightingPRS]
	  ,[RegionalWeightingMCPS]
      ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,[SysEndTime]
	  ,0 [IsCurrent]
  FROM [FPV].[CalculationGroupStationHistory]
)
SELECT CalculationGroupStationKey
	  ,[DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]	
      ,[StationName]

	  ,[StationStatus]
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
      ,[IsExcluded]
 
	  --Added 2018SEP04
      ,AudioPolicyMain
      ,AudioPolicyCommercial
      ,CommercialSampleDays
      ,NonCommercialSampleDays
      ,TotalSampleDays
	--Added 2018SEP19
	,[MinimumFee]
	,[BroadcastHours]
	--Added 2018OCT16
	,[LicenceFeeSplitPercent] 
	  ,[FPVStatus]
	--Added 2019FEB15
	  ,[RegionalParentStationFlag]
	  ,[RegionalParentStationId]
	  ,[RegionalWeightingPRS]
	  ,[RegionalWeightingMCPS]

	  ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,dateadd(ms,-1,[SysEndTime])[SysEndTime]
	  ,[IsCurrent]
FROM Holistic
GO

