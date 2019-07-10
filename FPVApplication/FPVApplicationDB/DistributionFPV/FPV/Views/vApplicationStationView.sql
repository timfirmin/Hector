
 --=============================================
-- Last Change By: TJF 2019APR24 Removed Seed,Prev,Current and 'i' to 'master'
-- Last Change By: TJF 2019APR30 Removed RegionalParentStationFlag
-- =============================================
CREATE VIEW [FPV].[vApplicationStationView]
AS
--Abacus Response Improvements Jan 2019 Added CalculationGroupStationKey
WITH intervals AS (
select	CalculationGroupStationKey,[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysStartTime] from [FPV].[vCalculationGroupMasterStation]
union
select	CalculationGroupStationKey,[DistributionGroupCode],[DistributionCode],[Society],[StationID],[SysStartTime][intervalSysStartTime] from [FPV].[vCalculationGroupStation]
)
,CombinedStations AS (
SELECT m.[DistributionGroupCode][masterDistributionGroupCode]
	  ,m.[DistributionCode][masterDistributionCode]
      ,m.[Society][masterSociety]
      ,m.[StationID][masterStationID]
		--Added 2018NOV23
	  ,m.[CodaCustomerCode][masterCodaCustomerCode]
      ,m.[StationName][masterStationName]
  
	  ,m.[StationStatus][masterStationStatus]

      ,m.[GroupAdminRate][masterGroupAdminRate]
      ,m.[HedgePercent][masterHedgePercent]
      ,m.[HedgePercentMCPS][masterHedgePercentMCPS]
      ,m.[PRAdminRate][masterPRAdminRate]
      ,m.[IsExcluded][masterIsExcluded]

	  --Added 2018SEP04 
      ,m.[AudioPolicyMain][masterAudioPolicyMain]
      ,m.[AudioPolicyCommercial][masterAudioPolicyCommercial]
      ,m.[CommercialSampleDays][masterCommercialSampleDays]
      ,m.[NonCommercialSampleDays][masterNonCommercialSampleDays]
      ,m.[TotalSampleDays][masterTotalSampleDays]

	  --Added 2018SEP19 
	  ,m.[MinimumFee][masterMinimumFee]
      ,m.[BroadcastHours][masterBroadcastHours]

	  --Added 2019FEB15
      --,m.RegionalParentStationFlag[iRegionalParentStationFlag]
      ,m.RegionalParentStationId[iRegionalParentStationId]
      ,m.RegionalWeightingPRS[iRegionalWeightingPRS]
      ,m.RegionalWeightingMCPS[iRegionalWeightingMCPS]

	  	  --Added 2019FEB15
      --,s.RegionalParentStationFlag[RegionalParentStationFlag]
      ,s.RegionalParentStationId[RegionalParentStationId]
      ,s.RegionalWeightingPRS[RegionalWeightingPRS]
      ,s.RegionalWeightingMCPS[RegionalWeightingMCPS]
 
      ,m.[SysStartTime][masterSysStartTime]
      ,m.[SysEndTime][masterSysEndTime]
	  ,m.[MasterStationIsCurrent]
	  ,s.[Society]
	  ,s.[DistributionGroupCode]
	  ,s.[DistributionCode]
	  ,m.[CalculationPeriodStatus]
	  ,m.[CalculationPeriodStart]
	  ,m.[CalculationPeriodEnd]
	  ,m.[CalculationGroupIsCurrent]
      ,s.[StationID]
      ,s.[StationName]
 
	  ,s.[StationStatus]
      ,s.[GroupAdminRate]
      ,s.[HedgePercent]
	  ,s.[HedgePercentMCPS]
      ,s.[PRAdminRate]
      ,s.[IsExcluded]	

	  --Added 2018SEP04
      ,s.[AudioPolicyMain][AudioPolicyMain]
      ,s.[AudioPolicyCommercial][AudioPolicyCommercial]
      ,s.[CommercialSampleDays][CommercialSampleDays]
      ,s.[NonCommercialSampleDays][NonCommercialSampleDays]
      ,s.[TotalSampleDays][TotalSampleDays]
	  --Added 2018SEP19 
	  ,s.[MinimumFee][MinimumFee]
      ,s.[BroadcastHours][BroadcastHours]

	  	  --Added 2019FEB15
      --,s.[RegionalParentStationFlag][masterRegionalParentStationFlag]
      ,s.[RegionalParentStationId][masterRegionalParentStationId]
      ,s.[RegionalWeightingPRS][masterRegionalWeightingPRS]
      ,s.[RegionalWeightingMCPS][masterRegionalWeightingMCPS]
   
	  --Added 2018SEP19 
	  ,s.[LicenceFeeSplitPercent][LicenceFeeSplitPercent]


	  ,s.[FPVStatus]


	  --Added 2018SEP04
      ,s.[UpdatedBy]
      ,s.[UpdateComment]
      ,s.[SysStartTime]
      ,s.[SysEndTime]
	  ,ISNULL(s.[IsCurrent],1)[CalculationGroupStationIsCurrent]
	  ,i.[intervalSysStartTime]
FROM  intervals i 
LEFT JOIN [FPV].[vCalculationGroupMasterStation] m on m.CalculationGroupStationKey=i.CalculationGroupStationKey
--LEFT JOIN [FPV].[vCalculationGroupMasterStation] m on	m.[DistributionGroupCode]=i.[DistributionGroupCode]
--										and
--										m.[DistributionCode]=i.[DistributionCode]
--										and
--										m.[Society]=i.[Society]
--										and
--										m.[StationID] = i.[StationID]
										and
										i.[intervalSysStartTime] between m.[SysStartTime] and m.[SysEndTime]
LEFT JOIN [FPV].[vCalculationGroupStation] s ON i.CalculationGroupStationKey=s.CalculationGroupStationKey
--LEFT JOIN [FPV].[vCalculationGroupStation] s ON i.[DistributionGroupCode]=s.[DistributionGroupCode]
--												and
--												i.[DistributionCode]=s.[DistributionCode]
--												and
--												i.[Society]=s.[Society]
--												and
--												i.[StationID]=s.[StationID]
												and
												i.[intervalSysStartTime] between s.[SysStartTime] and s.[SysEndTime]
)
SELECT [masterSociety][Society]
	  ,[masterCodaCustomerCode]
	  ,[masterDistributionGroupCode][DistributionGroupCode]
	  ,[masterDistributionCode][DistributionCode]
	  ,[CalculationPeriodStatus]
	  ,[CalculationPeriodStart]
	  ,[CalculationPeriodEnd]
	  ,[masterDistributionGroupCode]
      ,[masterStationID]
      ,[masterStationName]
 
	  ,[masterStationStatus]

      ,[masterGroupAdminRate]
      ,[masterHedgePercent]
      ,[masterHedgePercentMCPS]
      ,[masterPRAdminRate]
      ,[masterIsExcluded]
	  --Added 2018SEP04
      ,[masterAudioPolicyMain]
      ,[masterAudioPolicyCommercial]
      ,[masterCommercialSampleDays]
      ,[masterNonCommercialSampleDays]
      ,[masterTotalSampleDays]
	  --Added 2018SEP19 
	  ,[masterMinimumFee]
      ,[masterBroadcastHours]

	  --Added 2019FEB15
     -- ,[masterRegionalParentStationFlag]
      ,[masterRegionalParentStationId]
      ,[masterRegionalWeightingPRS]
      ,[masterRegionalWeightingMCPS]

 
      ,[masterSysStartTime]
      ,[masterSysEndTime]
      
	  ,ISNULL([StationID],[masterStationID]) AS [StationID]
      ,ISNULL([StationName],[masterStationName]) AS [StationName]

	  ,[StationStatus]
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
      ,[IsExcluded]

	  ,[FPVStatus]
	  --Added 2018SEP04
      ,[AudioPolicyMain]
      ,[AudioPolicyCommercial]
      ,[CommercialSampleDays]
      ,[NonCommercialSampleDays]
      ,[TotalSampleDays]
	  --Added 2018SEP19 
	  ,[MinimumFee]
      ,[BroadcastHours]

	  --Added 2019FEB15
     -- ,[RegionalParentStationFlag]
      ,[RegionalParentStationId]
      ,[RegionalWeightingPRS]
      ,[RegionalWeightingMCPS]

	  --Added 2018SEP19 
	  ,[LicenceFeeSplitPercent]
	

      ,[UpdatedBy]
      ,FPV.udfRemoveStringCharacters([UpdateComment])[UpdateComment]
	,[intervalSysStartTime][SysStartTime]
	,coalesce(lead([intervalSysStartTime]) over (partition by [masterDistributionGroupCode],[masterDistributionCode],[masterSociety],[masterStationID] order by [intervalSysStartTime]),'31 DEC 9999')[SysEndTime]
	  ,[CalculationGroupIsCurrent]
	  ,[MasterStationIsCurrent] as [masterIsCurrent]
	  ,[CalculationGroupStationIsCurrent]
	  ,case
		when coalesce(lead([intervalSysStartTime]) over (partition by [masterDistributionGroupCode],[masterDistributionCode],[masterSociety],[masterStationID] order by [intervalSysStartTime]),'31 DEC 9999')='31 DEC 9999' then 1
		else 0
	  end [IsCurrent]
FROM	CombinedStations
GO

