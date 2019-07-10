

CREATE VIEW [FPV].[vMasterUDC]
AS
--=============================================
-- TJF 2019MAY02 Added in  PeakFactorField / PeakWeightingFactor Logic 
-- Test :  
-- =============================================
 WITH cte_PercentSplits
 as
 (
 SELECT 
      [DistributionGroupCode]      ,[DistributionCode]       ,[Society] , [StationID]       ,'HIGH PEAK' 	as PeakType  ,'HighPeakTimeBandFactor' as PeakFactorField, isnull([HighPeakPercent],0) as PeakSplitPercent
  FROM [FPV].[MasterMusicMinutes]
  UNION SELECT 
      [DistributionGroupCode]       ,[DistributionCode]      ,[Society] , [StationID]       ,'NON PEAK' 	as PeakType   ,'NonPeakTimeBandFactor' as PeakFactorField, isnull([NonPeakPercent],0) as PeakSplitPercent
  FROM [FPV].[MasterMusicMinutes]
    UNION SELECT 
      [DistributionGroupCode]       ,[DistributionCode]       ,[Society] , [StationID]       ,'LOW PEAK' 	as PeakType   ,'LowPeakTimeBandFactor' as PeakFactorField, isnull([LowPeakPercent],0) as PeakSplitPercent
  FROM [FPV].[MasterMusicMinutes]
  )
SELECT 
	  CAST(HashBytes('SHA1',cast(isnull(ms.DistributionGroupCode,'Unknown') as varchar(20))  +cast(Dist.[DistributionCode] as varchar(20)) + cast('PRS' as varchar(20)) +  cast(udc.[StationID] as varchar(20))  +  cast(udc.[UsedForPurposeDesc] as varchar(50))  +  cast(udc.[TimeBand] as varchar(50)) ) AS bigint) CalculationGroupUDCKey
	  ,ms.DistributionGroupCode as DistributionGroupCode
      ,Dist.[DistributionCode]
      ,'PRS' as Society --UDC works at PRS level only
      ,udc.[StationID]
      ,udc.[UDCCode]
      ,udc.[UDCDescription]
      ,udc.[UsedForPurposeDesc]
      ,udc.[TimeBand]
	  ,isnull(cte.PeakSplitPercent,0) as PeakSplitPercent
	  ,isnull(FPV.udfGetDGValue(cte.PeakFactorField, ms.DistributionGroupCode),0) as PeakWeightingFactor
      ,udc.[UpdatedBy]
      ,udc.[UpdateComment]
      ,udc.[SysStartTime]
      ,udc.[SysEndTime]
		,1 [IsCurrent]
  FROM [FPV].[MasterUDC] udc
  CROSS JOIN
(SELECT  [DistributionCode]   
  FROM [FPV].[Distribution]  WHERE [DistributionYear] > year(getdate())-2)  Dist
  LEFT JOIN [FPV].[MasterStation] ms ON udc.[StationID] = ms.StationID
  LEFT JOIN cte_PercentSplits cte on 
					ms.DistributionGroupCode = cte.DistributionGroupCode
					and Dist.[DistributionCode] = cte.DistributionCode
					and 'PRS' = cte.Society
					and udc.StationID = cte.StationID
					and udc.[TimeBand] = cte.PeakType
	WHERE ms.DistributionGroupCode  IN 
	(SELECT  [DistributionGroupCode] FROM [FPV].[DistributionGroup] WHERE [Enabled] = 1)
UNION

  SELECT 
	  CAST(HashBytes('SHA1',cast(isnull(ms.DistributionGroupCode,'Unknown') as varchar(20))  +cast(Dist.[DistributionCode] as varchar(20)) + cast('PRS' as varchar(20)) +  cast(udc.[StationID] as varchar(20))  +  cast(udc.[UsedForPurposeDesc] as varchar(50))  +  cast(udc.[TimeBand] as varchar(50)) ) AS bigint)  CalculationGroupUDCKey
	  ,isnull(ms.DistributionGroupCode,'Unknown') as DistributionGroupCode
      ,Dist.[DistributionCode]
      ,'PRS' as Society --UDC works at PRS level only
      ,udc.[StationID]
      ,udc.[UDCCode]
      ,udc.[UDCDescription]
      ,udc.[UsedForPurposeDesc]
      ,udc.[TimeBand]
	  ,isnull(cte.PeakSplitPercent,0) as PeakSplitPercent
	  ,isnull(FPV.udfGetDGValue(cte.PeakFactorField, ms.DistributionGroupCode),0) as PeakWeightingFactor
      ,udc.[UpdatedBy]
      ,udc.[UpdateComment]
      ,udc.[SysStartTime]
      ,udc.[SysEndTime]
		,0 [IsCurrent]
  FROM [FPV].[MasterUDCHistory] udc
  CROSS JOIN
(SELECT  [DistributionCode]   
  FROM [FPV].[Distribution] WHERE [DistributionYear] > year(getdate()-400)) Dist
  LEFT JOIN [FPV].[MasterStation] ms ON udc.[StationID] = ms.StationID
  LEFT JOIN cte_PercentSplits cte on 
					ms.DistributionGroupCode = cte.DistributionGroupCode
					and Dist.[DistributionCode] = cte.DistributionCode
					and 'PRS' = cte.Society
					and udc.StationID = cte.StationID
					and udc.[TimeBand] = cte.PeakType
	WHERE ms.DistributionGroupCode  IN 
	(SELECT  [DistributionGroupCode] FROM [FPV].[DistributionGroup] WHERE [Enabled] = 1)
GO

