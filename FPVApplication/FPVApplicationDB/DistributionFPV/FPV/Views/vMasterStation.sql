

 --=============================================
-- Last Change By: TJF 2019APR24 Removed Seed,Prev,Current and 'i' to 'master'
-- Last Change By: TJF 2019APR29 Added [RightTypeCompany]
-- =============================================
CREATE VIEW [FPV].[vMasterStation]
AS
WITH Holistic AS (
SELECT [StationID]
	  --Added 2018NOV23
	  ,CodaCustomerCode
      ,[DistributionGroupCode]
      ,[StationName]
  
      ,[StationStatus]
	--Added 2018SEP04
	,AudioPolicyMain
	,AudioPolicyCommercial
	,CommercialSampleDays
	,NonCommercialSampleDays
	,TotalSampleDays
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
	  --Added 2018SEP18
	  ,MinimumFee

      ,[IsExcluded]
	  --Added 2019FEB15
      ,[RegionalParentStationFlag]
      ,[RegionalParentStationId]
      ,[RegionalWeightingPRS]
      ,[RegionalWeightingMCPS]

      ,[SysStartTime]
      ,[SysEndTime]
	  ,[RightTypeCompany]
	  ,1 [IsCurrent]
FROM [FPV].[MasterStation]
UNION
SELECT [StationID]
	  --Added 2018NOV23
	  ,CodaCustomerCode
      ,[DistributionGroupCode]
      ,[StationName]

      ,[StationStatus]
--Added 2018SEP04
	,AudioPolicyMain
	,AudioPolicyCommercial
	,CommercialSampleDays
	,NonCommercialSampleDays
	,TotalSampleDays
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
	  --Added 2018SEP18
	  ,MinimumFee

      ,[IsExcluded]
	  --Added 2019FEB15
      ,[RegionalParentStationFlag]
      ,[RegionalParentStationId]
      ,[RegionalWeightingPRS]
      ,[RegionalWeightingMCPS]

      ,[SysStartTime]
      ,[SysEndTime]
	  ,[RightTypeCompany]
	  ,0 [IsCurrent]
FROM [FPV].[MasterStationHistory]
)

SELECT [StationID]
	  --Added 2018NOV23
	  ,CodaCustomerCode
      ,[DistributionGroupCode]
      ,[StationName]
 
      ,[StationStatus]
--Added 2018SEP04
	,AudioPolicyMain
	,AudioPolicyCommercial
	,CommercialSampleDays
	,NonCommercialSampleDays
	,TotalSampleDays
 
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
		--Added 2018SEP18
	  ,MinimumFee 

	  --Added 2019FEB15
      ,[RegionalParentStationFlag]
      ,[RegionalParentStationId]
      ,[RegionalWeightingPRS]
      ,[RegionalWeightingMCPS]

      ,[IsExcluded]


      ,[SysStartTime]
      ,dateadd(millisecond,-1,[SysEndTime])[SysEndTime]
	  ,[RightTypeCompany]
	  ,[IsCurrent]
FROM [Holistic]
GO

