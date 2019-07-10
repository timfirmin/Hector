create view hctr.BaselineOrphans
as

SELECT bs.[StationUDCKey]
      ,bs.[BroadcasterDomain]
      ,bs.[KeyAccountGroup]
      ,bs.[MusicReportingGroup]
      ,bs.[LicenceGroup]
      ,bs.[StationId]
      ,bs.[Broadcaster]
      ,bs.[RightType]
      ,bs.[MCPSLicenceType]
      ,bs.[UsedForPurposeDesc]
      ,bs.[TimeBand]
      ,bs.[UsageDistributionCode]
      ,bs.[UsageDistributionCodeDesc]
 
  FROM [Hector2].[hctr].[StationUDCBaseline] bs LEFT JOIN
   [hctr].[DistributionMappingCore] dmc
   ON    bs.[StationId] = dmc.StationCode AND   bs.UsageDistributionCode = dmc.UDC
   WHERE dmc.UDC is null	

