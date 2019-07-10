CREATE PROCEDURE Reporting.ObtainChagingStationDetails
  @LoadId bigint,
  @MDSDomainName varchar(50),
  @ChangeType varchar(50),
  @SourceSystem varchar(20)
AS
SELECT 
  ParentLoadId,
  SourceSystem,
  SysStartTime,
  action,
  --MDS_InitialDataSource,
  BroadcasterKey,
  BroadcasterCode,
  BroadcasterName,
  --DomainName,
  --MCPSLicenceTypeCode,
  RightTypeCode,
  --TerritoryCode,
  --InceptionDate = CAST(InceptionDate AS DATE),
  --LicenceGroup,
  LicencedStatus,
  --StatusEffectiveDate,
  --CurrentLicenceFee,
  AudioPolicyMain,
  AudioPolicyCommercial,
  MainSampleDays,
  CommercialSampleDays,
  MDS_BroadcasterName,
  --MDS_DomainName,
  --MDS_MCPSLicenceTypeCode,
  MDS_RightTypeCode,
  --MDS_TerritoryCode,
  --MDS_InceptionDate = CAST(MDS_InceptionDate AS DATE),
  --MDS_LicenceGroup,
  MDS_LicencedStatus,
  --MDS_StatusEffectiveDate,
  --MDS_CurrentLicenceFee,
  MDS_AudioPolicyMain,
  MDS_AudioPolicyCommercial,
  MDS_MainSampleDays,
  MDS_CommercialSampleDays
FROM 
  Transform.MasterStationAlerts
WHERE
  ParentLoadId = @LoadId AND
--(MDS_DomainName = @MDSDomainName OR @MDSDomainName = '<All>') AND
  (action = @ChangeType OR @ChangeType = '<All>') 
  ;
  --(MDS_InitialDataSource = @SourceSystem OR @SourceSystem  = '<All>')
