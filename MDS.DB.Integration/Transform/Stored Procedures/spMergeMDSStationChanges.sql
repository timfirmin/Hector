CREATE PROCEDURE [Transform].[spMergeMDSStationChanges]
AS

With  DataList AS (
        Select
		   [LoadId]
           ,[Code]
           ,[Name]
           --,[LicenceGroup]
           ,[AudioPolicy]
		   --Added 2018SEP07
		   ,[AudioPolicyCommercial]
		   ,[CommercialSampleDays]
		   ,[NonCommercialSampleDays]
		   ,[TotalSampleDays]
           ,cast([EnterDateTime] as Smalldatetime) AS [EnterDateTime] 
           ,CAST([LastChgDateTime] as smalldatetime)  AS [LastChgDateTime]  FROM  [Staging].[MDS_MasterStation]
		   Where  LastChgDateTime > DateAdd(day,-1, getdate())
           and cast(EnterDateTime as smalldatetime) <> cast(LastChgDateTime as smalldatetime)
   )


MERGE [Transform].[MDS_MasterStation] AS TARGET
USING DataList AS SOURCE 
ON          TARGET.LoadId = SOURCE.LoadId And
            TARGET.Code = SOURCE.Code And
		    TARGET.AudioPolicy= SOURCE.[AudioPolicy] AND
		   --Added 2018SEP07
		    TARGET.[AudioPolicyCommercial]= SOURCE.[AudioPolicyCommercial] AND
		    TARGET.[CommercialSampleDays] =  SOURCE.[CommercialSampleDays] AND
		    TARGET.[NonCommercialSampleDays] = SOURCE.[NonCommercialSampleDays] AND
		    TARGET.[TotalSampleDays] = SOURCE.[TotalSampleDays] 
			--AND TARGET.[LicenceGroup] = SOURCE.[LicenceGroup]  


WHEN MATCHED THEN
        UPDATE SET TARGET.Code = SOURCE.Code 

WHEN NOT MATCHED BY TARGET THEN  
 INSERT 
           (
		    [LoadId]
           ,[Code]
		   ,[Name]
           --,[LicenceGroup]
           ,[AudioPolicy]
		   --Added 2018SEP07
		   ,[AudioPolicyCommercial]
		   ,[CommercialSampleDays]
		   ,[NonCommercialSampleDays]
		   ,[TotalSampleDays]
           ,[EnterDateTime]
           ,[LastChgDateTime]
		   )
VALUES    (  SOURCE.[LoadId]
            ,SOURCE.[Code]
			,SOURCE.[Name]
            --,SOURCE.[LicenceGroup]
            ,SOURCE.[AudioPolicy]
		   --Added 2018SEP07
            ,SOURCE.[AudioPolicyCommercial]
            ,SOURCE.[CommercialSampleDays]
            ,SOURCE.[NonCommercialSampleDays]
            ,SOURCE.[TotalSampleDays]
            ,SOURCE.[EnterDateTime]
            ,SOURCE.[LastChgDateTime] )
;