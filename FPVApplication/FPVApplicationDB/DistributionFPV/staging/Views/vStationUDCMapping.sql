
CREATE VIEW [staging].[vStationUDCMapping]
AS
SELECT
       udc.[MasterStationId] as [StationID]
	   ,udc.[UsedForPurpose]
	   ,tbm.[MappedTimeBand]
      ,udc.[UDCCode]
      ,udc.[UDCDescription]
	  ,stn.[DistributionGroupCode] as ActiveDistributionGroupCode
	  ,udc.[TimeBand][SuppliedTimeBand]      
	  ,case when udc.[MappingStatusFlag]='Yes' then 1 else 0 end [StationUDCMappingIsValid]
	  ,case when tbm.[ValidFlag]='Y' then 1 else 0 end [MappedTimeBandIsValid]
	  , case when udc.[UsedForPurpose] in ('Main','Commercial') then 1 else 0 end [UsedForPurposeIsValid]
	  ,count(udc.[UDCCode]) over (partition by udc.[MasterStationId],udc.[UsedForPurpose],tbm.[MappedTimeBand])[UDCUniqueCount]
FROM [staging].[StationUDCMapping] udc	
LEFT JOIN [staging].[BroadcasterTimeBandMap] tbm on udc.[TimeBand] = tbm.[REPTimeBand]
LEFT JOIN [staging].[vStation] stn on udc.[MasterStationID] = stn.[StationID]
GO


