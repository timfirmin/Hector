CREATE view [Transform].[v_SampleDaysAudioPolicy]
as
--Added Updates Rows for 'New' Master Stations
SELECT distinct
	   msd.*
      ,sdap.[MainSampleDays]
      ,sdap.[MDSMainSampleDays]
      ,sdap.[CommercialSampleDays]
      ,sdap.[MDSCommercialSampleDays]
      ,sdap.[AudioPolicyMain]
      ,sdap.[MDSAudioPolicyMain]
      ,sdap.[AudioPolicyCommercial]
      ,sdap.[MDSAudioPolicyCommercial]
	  ,'Deltas' as RecordType
	  ,sdap.LoadId
  FROM [Transform].[SampleDaysAudioPolicy] sdap 
  join [Clean].[v_MasterStationData] msd on sdap.[StationId]  = msd.[BroadcasterCode]
  WHERE [DeltaFlag] = 'Y'

UNION 

SELECT 
	   msd.*
      ,sdap.[MainSampleDays]
      ,sdap.[MDSMainSampleDays]
      ,sdap.[CommercialSampleDays]
      ,sdap.[MDSCommercialSampleDays]
      ,sdap.[AudioPolicyMain]
      ,sdap.[MDSAudioPolicyMain]
      ,sdap.[AudioPolicyCommercial]
      ,sdap.[MDSAudioPolicyCommercial]
	  ,'UpdateExisting' as RecordType
	  ,sdap.LoadId
  FROM [Transform].[SampleDaysAudioPolicy] sdap 
  join [Clean].[v_MasterStationData] msd on sdap.[StationId]  = msd.[BroadcasterCode]
  join (SELECT [BroadcasterCode] FROM [Transform].[Broadcaster] WHERE [NewRecordFlag] = 'N') Exist on sdap.StationId = Exist.[BroadcasterCode]
  WHERE [DeltaFlag] = 'N'

UNION 

SELECT 
	   msd.*
      ,sdap.[MainSampleDays]
      ,sdap.[MDSMainSampleDays]
      ,sdap.[CommercialSampleDays]
      ,sdap.[MDSCommercialSampleDays]
      ,sdap.[AudioPolicyMain]
      ,sdap.[MDSAudioPolicyMain]
      ,sdap.[AudioPolicyCommercial]
      ,sdap.[MDSAudioPolicyCommercial]
	  ,'UpdateNew' as RecordType
	  ,sdap.LoadId
  FROM [Transform].[SampleDaysAudioPolicy] sdap 
  join [Clean].[v_MasterStationData] msd on sdap.[StationId]  = msd.[BroadcasterCode]
  join (SELECT [BroadcasterCode] FROM [Transform].[Broadcaster] WHERE [NewRecordFlag] = 'Y') Exist on sdap.StationId = Exist.[BroadcasterCode]
  WHERE [DeltaFlag] = 'N'
GO

