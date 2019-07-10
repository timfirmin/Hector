/*
 * Tim Firmin 2019JAN09 - Update-Merge RAJAR Audience Reach table from staging
 * Update : Tim Firmin 2019JAN10 - added in Population Average
 * Test: EXEC [staging].[uspMergeAudienceReachRAJAR] @pLoadId = 321, @pUserName = 'tjf',  @pInsertedRowCount = 0
 */ 

CREATE PROCEDURE [staging].[uspMergeAudienceReachRAJAR]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

MERGE [FPV].[MasterAudienceReach] mar
USING 
		(
		SELECT TOP 1000 [Society]
			  ,[DistributionGroupCode]
			  ,[DistributionCode]
			  ,[StationId]

			  ,cast([PopulationAverage] as decimal(18,3)) as [PopulationAverage]
			  ,cast([AudienceAverage] as decimal(18,3)) as [AudienceAverage]
			  ,cast([HoursPerListenerAvg] as decimal(18,3)) as [HoursPerListenerAvg]
			  ,cast([HoursPerHeadAvg] as decimal(18,3)) as [HoursPerHeadAvg]

		  FROM [staging].[vAudienceReachRAJAR]
		  where [DistributionGroupCode] is not null 
		  )
   stg
ON     mar.[Society] = stg.[Society]
      and mar.[DistributionGroupCode] = stg.[DistributionGroupCode]
      and mar.[DistributionCode] = stg.[DistributionCode]
      and mar.[StationId] = stg.[StationId]

WHEN not matched BY TARGET THEN
INSERT             (
					[DistributionGroupCode]
				   ,[DistributionCode]
				   ,[Society]
				   ,[StationID]
				   ,[PopulationAverage]
				   ,[AudienceAverage]
				   ,[HoursPerListenerAverage]
				   ,[HoursPerHeadAverage]
				   ,[UpdatedBy]
				   )
VALUES 
				   (stg.[DistributionGroupCode]
				   ,stg.[DistributionCode]
				   ,stg.[Society]
				   ,stg.[StationID]
				   ,stg.[PopulationAverage]
				   ,stg.[AudienceAverage]
				   ,stg.[HoursPerListenerAvg]
				   ,stg.[HoursPerHeadAvg]
				   ,(suser_sname()))

WHEN matched and
				isnull(mar.[AudienceAverage],0)!=isnull(stg.[AudienceAverage],0) 
				OR isnull(mar.[PopulationAverage],0)!=isnull(stg.[PopulationAverage],0)
				OR isnull(mar.[HoursPerListenerAverage],0)!=isnull(stg.[HoursPerListenerAvg],0) 
				OR isnull(mar.[HoursPerHeadAverage],0)!=isnull(stg.[HoursPerHeadAvg],0)  


THEN
UPDATE SET   [AudienceAverage]=isnull(stg.[AudienceAverage],0) 
		    ,[PopulationAverage]=isnull(stg.[PopulationAverage],0) 
			,[HoursPerListenerAverage]=isnull(stg.[HoursPerListenerAvg],0) 
			,[HoursPerHeadAverage]=isnull(stg.[HoursPerHeadAvg],0) ;

--WHEN not matched BY source THEN DELETE;

/* Return the Insert row count */
SET @pInsertedRowCount = @@ROWCOUNT
 		
END