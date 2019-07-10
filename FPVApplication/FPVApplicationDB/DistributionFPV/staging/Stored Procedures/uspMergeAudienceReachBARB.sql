/*
 * Tim Firmin 2019JAN02 - Update-Merge BARB Audience Reach table from staging
 * Update : Tim Firmin 2019JAN04 - Renamed Column @ [WeeklyReachTotal]
 * Test: EXEC [staging].[uspMergeAudienceReachBARB] @pLoadId = 321, @pUserName = 'tjf',  @pInsertedRowCount = 0
 */ 


CREATE PROCEDURE [staging].[uspMergeAudienceReachBARB]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

MERGE [FPV].[MasterAudienceReach] mar
USING 
		(SELECT [Society]
			  ,[DistributionGroupCode]
			  ,[DistributionCode]
			  ,[StationId]
			  ,cast([WeeklyReachTotal52Weeks] as decimal(18,3)) as [WeeklyReachTotal52Weeks]
			  ,cast([WeeklyViewingHoursTotal52Weeks] as decimal(18,3)) as [WeeklyViewingHoursTotal52Weeks]
			  ,cast([WeeklyReachTotal] as decimal(18,3)) as [WeeklyReach]
			  ,cast([WeeklyViewingHours] as decimal(18,3)) as [WeeklyViewingHours]
			  ,cast([TotalWeeklyAudienceHours] as decimal(18,3)) as [TotalWeeklyAudienceHours]
		  FROM [staging].[vAudienceReachBARB]
		  WHERE [DistributionGroupCode] is not null)
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
				   ,[WeeklyReachTotal52Weeks]
				   ,[WeeklyViewingHoursTotal52Weeks]
				   ,[WeeklyReach]
				   ,[WeeklyViewingHours]
				   ,[TotalWeeklyAudienceHours]
				   ,[UpdatedBy]
				   )
VALUES 
				   (stg.[DistributionGroupCode]
				   ,stg.[DistributionCode]
				   ,stg.[Society]
				   ,stg.[StationID]
				   ,stg.[WeeklyReachTotal52Weeks]
				   ,stg.[WeeklyViewingHoursTotal52Weeks]
				   ,stg.[WeeklyReach]
				   ,stg.[WeeklyViewingHours]
				   ,stg.[TotalWeeklyAudienceHours]
				   ,(suser_sname()))


WHEN matched and
				isnull(mar.[WeeklyReachTotal52Weeks],0)!=isnull(stg.[WeeklyReachTotal52Weeks],0) 
				OR isnull(mar.[WeeklyViewingHoursTotal52Weeks],0)!=isnull(stg.[WeeklyViewingHoursTotal52Weeks],0) 
				OR isnull(mar.[WeeklyReach],0)!=isnull(stg.[WeeklyReach],0) 
				OR isnull(mar.[WeeklyViewingHours],0)!=isnull(stg.[WeeklyViewingHours],0) 
				OR isnull(mar.[TotalWeeklyAudienceHours],0)!=isnull(stg.[TotalWeeklyAudienceHours],0) 


THEN

UPDATE SET   [WeeklyReachTotal52Weeks]=isnull(stg.[WeeklyReachTotal52Weeks],0) 
			,[WeeklyViewingHoursTotal52Weeks]=isnull(stg.[WeeklyViewingHoursTotal52Weeks],0) 
			,[WeeklyReach]=isnull(stg.[WeeklyReach],0) 
			,[WeeklyViewingHours]=isnull(stg.[WeeklyViewingHours],0) 
			,[TotalWeeklyAudienceHours]=isnull(stg.[TotalWeeklyAudienceHours],0) ;

--WHEN not matched BY source THEN DELETE;

/* Return the Insert row count */
SET @pInsertedRowCount = @@ROWCOUNT
 		
END