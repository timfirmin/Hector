


CREATE proc [Transform].[spMergeSampleDaysToBroadcast]
as
/*
 * Tim Firmin 2019SEP14 - Update-Merge Delta and Detailed SampleDays - AudioPolicy from REP Warehouse into Transform.Broadcast Table Pkg : Transform.MasterStationData_Details.dtsx
 * Ends up in MasterStationAlertDetails Report and Table via LoadMDS.MasterStationData_PersistChanges.dtsx, Integrated into Senay Messy Logic.
 * We do want to persist Sample Days data so removed NewRecordFlag clause
 * Test: EXEC [Transform].[spMergeSampleDaysToBroadcast] @pLoadId = 321, @pInsertedRowCount = 0
 */ 
 

merge [Transform].[Broadcaster] brd
using [Transform].[v_SampleDaysAudioPolicy] sdy
on (brd.[BroadcasterKey]) = (sdy.[BroadcasterKey]) --and (brd.NewRecordFlag = 'N')

when not matched by target then
-- ************** Insert New Start
INSERT     ([BroadcasterKey]
           ,[BroadcasterCode]
           ,[BroadcasterName]
           --,[DomainName]
           --,[MCPSLicenceTypeCode]
           ,[RightTypeCode]
           --,[TerritoryCode]
           ,[AudioPolicyMain]
           ,[AudioPolicyCommercial]
           ,[MainSampleDays]
           ,[CommercialSampleDays]
		   ,[CustomerAccountNo]
           ,[NewRecordFlag]
           ,[MDS_BroadcasterName]
           --,[MDS_DomainName]
           --,[MDS_MCPSLicenceTypeCode]
           ,[MDS_RightTypeCode]
           --,[MDS_TerritoryCode]
           ,[MDS_AudioPolicyMain]
           ,[MDS_AudioPolicyCommercial]
           ,[MDS_MainSampleDays]
           ,[MDS_CommercialSampleDays]
           ,[LoadId]
           ,[SysStartTime])
VALUES  (sdy.[BroadcasterKey]
		,sdy.[BroadcasterCode]
		,sdy.[BroadcasterName]
		--,sdy.[DomainName]
		--,sdy.[MCPSLicenceTypeCode]
		,sdy.[RightTypeCode]
		--,sdy.[TerritoryCode]
		,sdy.[AudioPolicyMain]
		,sdy.[AudioPolicyCommercial]
		,sdy.[MainSampleDays]
		,sdy.[CommercialSampleDays]
		,sdy.[CustomerAccountNo]
		,'N'
		,sdy.[BroadcasterName] 
		--,sdy.[DomainName] 
		--,sdy.[MCPSLicenceTypeCode] 
		,sdy.[RightTypeCode] 
		--,sdy.[TerritoryCode] 
		,sdy.[MDSAudioPolicyMain]
		,sdy.[MDSAudioPolicyCommercial] 
		,sdy.[MDSMainSampleDays] 
		,sdy.[MDSCommercialSampleDays] 
		,sdy.[LoadId]
		,getdate() 
		)
-- ************** Insert Bit End

when MATCHED  
		 --  AND isnull(brd.[AudioPolicyMain],0)!=isnull(sdy.[AudioPolicyMain],0)
			--OR isnull(brd.[AudioPolicyCommercial],0)!=isnull(sdy.[AudioPolicyCommercial] ,0)

THEN UPDATE
		 SET 
			 [AudioPolicyMain]=sdy.[AudioPolicyMain]
			,[AudioPolicyCommercial]=sdy.[AudioPolicyCommercial]
			,[MainSampleDays]=sdy.[MainSampleDays]
			,[CommercialSampleDays]=sdy.[CommercialSampleDays]
			,[MDS_AudioPolicyMain]=sdy.[MDSAudioPolicyMain] 
			,[MDS_AudioPolicyCommercial]=sdy.[MDSAudioPolicyCommercial] 
			,[MDS_MainSampleDays]=sdy.[MDSMainSampleDays] 
			,[MDS_CommercialSampleDays]=sdy.[MDSCommercialSampleDays] 
			,[LoadId] = sdy.[LoadId]
			,[UpdateTimeStamp] = getdate()
--when not matched by source then delete;
--No Need for Deletes
;
GO

