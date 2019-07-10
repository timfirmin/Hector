CREATE FUNCTION [staging].[udfValidateActiveStationsCeased] ()
RETURNS TABLE 
AS
RETURN 
(
SELECT DISTINCT
--[DistributionCode]
	  [StationID]
      ,min([StationName]) as StationName
      ,min([FPVStatus]) as FPVStatus
      ,1 as ActiveFPVStationNowCeased 
      --,[IsCurrent]
  FROM [FPV].[vApplicationStationView]  asv
  where [IsCurrent] = 1 and isnull([IsExcluded],0) <> 1
  and not exists
  (
  SELECT NULL      
  FROM [FPV].[MasterStation] ms
  where (asv.[StationID] = ms.[StationID]  and asv.[DistributionGroupCode] = ms.[DistributionGroupCode]  )  and [IsExcluded]  = 0
  )
  group by [StationID]
)