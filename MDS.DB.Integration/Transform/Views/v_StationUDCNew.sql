



CREATE VIEW [Transform].[v_StationUDCNew]
AS


SELECT distinct
	   [BroadcasterUDCCode] as StationUDCCode
	  ,[BroadcasterUDCCode] as StationUDCName
	  ,[UDCCode] as [UDCCode]
      ,[StationID] as [MasterStationId]
      ,isnull([UDCUsedForPurposeDescription],[MDSUsedForPurposeDescription]) as UsedForPurpose
      ,isnull([UDCTimeBand],[MDSTimeBand]) as TimeBand
	  ,'Yes' as MappingStatus
      ,[LoadId]
      
  FROM [Transform].[BroadcasterUDCAlerts]
  WHERE [DeltaAction] = 'Insert' and  [MDSSyncActionedLoadId] is null

  UNION

  SELECT distinct
  	   [BroadcasterUDCCode] as StationUDCCode
	  ,[BroadcasterUDCCode] as StationUDCName
	  ,[UDCCode] as [UDCCode]
      ,[StationID] as [MasterStationId]
      ,isnull(bua.[UDCUsedForPurposeDescription],bua.[MDSUsedForPurposeDescription]) as UsedForPurposeDesc
      ,isnull(bua.[UDCTimeBand],bua.[MDSTimeBand]) as TimeBand
	  ,'No' as MappingStatus
      ,bua.[LoadId]
      
  FROM [Transform].[BroadcasterUDCAlerts] bua
		JOIN [Transform].[v_UDCInvalidDate] dt on bua.[UDCCode]  = dt.[usage_distribution_code]
  WHERE [DeltaAction] = 'Delete' and  [MDSSyncActionedLoadId] is null