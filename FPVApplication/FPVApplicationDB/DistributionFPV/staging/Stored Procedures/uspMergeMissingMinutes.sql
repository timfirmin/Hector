

/*
 * Tim Firmin 2018JUL06 - Update-Merge MissingMinutes table from staging
 * Test: EXEC [staging].[uspMergeMissingMinutes] @pLoadId = 321, @pInsertedRowCount = 0
 */ 
CREATE PROC [staging].[uspMergeMissingMinutes]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

;WITH UPDATES_BASE AS (
SELECT 
		 upper([StationId])[StationID]
		,[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[MinutesMissingData]
		,[MinutesCarryForwards]
		,[MinutesTotal]
		,[RevenueMissingData]
		,[RevenueCarryForwards]
		,[RevenueTotal]
		,cast(suser_name()  as varchar(100)) as [UpdatedBy] 
		,cast([Comment] as varchar(250)) as [UpdateComment] 
		,@pLoadId as InsertLoadId --Not Currently In Use
		,cast(getdate() as datetime2(7)) as InsertTimeStamp --Not Currently In Use

	, ROW_NUMBER() OVER (PARTITION BY [StationID],[DistributionGroupCode],[DistributionCode],[Society] ORDER BY [InsertTimeStamp] DESC)[Order]
 FROM [staging].[DistributionMissingMinutes] WHERE nullif(StationID,'') is not null
)
,UPDATES AS (
SELECT 
		 upper([StationID])[StationID]
		,[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[MinutesMissingData]
		,[MinutesCarryForwards]
		,[MinutesTotal]
		,[RevenueMissingData]
		,[RevenueCarryForwards]
		,[RevenueTotal]
		,[UpdatedBy]
		,[UpdateComment]
FROM UPDATES_BASE
WHERE	[Order]=1
)
MERGE [FPV].[MasterMissingMinutes] T
USING UPDATES S ON upper(T.[StationID])=upper(S.[StationID]) 
			and T.[DistributionGroupCode]=S.[DistributionGroupCode] 
			and T.[DistributionCode]=S.[DistributionCode] 
			and T.[Society]=S.[Society] 

WHEN NOT MATCHED THEN 
INSERT ([StationID]
	  ,[DistributionGroupCode]
	  ,[DistributionCode]
	  ,[Society]
		,MissingMinutes   --[MinutesMissingData]  --MissingMinutes
		,CarryForwardsMinutes  --[MinutesCarryForwards] --CarryForwardsMinutes
		,TotalMinutesToHold   --[MinutesTotal] --TotalMinutesToHold
		,MissingRevenue   --[RevenueMissingData] --MissingRevenue
		,CarryForwardsRevenue   --[RevenueCarryForwards] --CarryForwardsRevenue
		,TotalRevenueToHold   --[RevenueTotal] --TotalRevenueToHold
	, [UpdatedBy]
	, [UpdateComment])
VALUES (upper(S.[StationID])
	  ,S.[DistributionGroupCode]
	  ,S.[DistributionCode]
	  ,S.[Society]
	  ,S.[MinutesMissingData]
	  ,S.[MinutesCarryForwards]
	  ,S.[MinutesTotal]
	  ,S.[RevenueMissingData]
	  ,S.[RevenueCarryForwards]
	  ,S.[RevenueTotal]
	 , S.[UpdatedBy]
	 , S.[UpdateComment])

WHEN MATCHED AND     isnull(T.MissingMinutes,0)!=isnull(S.[MinutesMissingData],0)
				  OR isnull(T.CarryForwardsMinutes,0)!=isnull(S.[MinutesCarryForwards],0)
				  OR isnull(T.TotalMinutesToHold,0)!=isnull(S.[MinutesTotal],0)
				  OR isnull(T.MissingRevenue,0)!=isnull(S.[RevenueMissingData],0)
				  OR isnull(T.CarryForwardsRevenue,0)!=isnull(S.[RevenueCarryForwards],0)
				  OR isnull(T.TotalRevenueToHold,0)!=isnull(S.[RevenueTotal],0)
				THEN UPDATE
SET T.MissingMinutes=S.[MinutesMissingData]
	,T.CarryForwardsMinutes=S.[MinutesCarryForwards]
	,T.TotalMinutesToHold=S.[MinutesTotal]
	,T.MissingRevenue=S.[RevenueMissingData]
	,T.CarryForwardsRevenue=S.[RevenueCarryForwards]
	,T.TotalRevenueToHold=S.[RevenueTotal]
	,T.[UpdatedBy]=S.[UpdatedBy]
	,T.[UpdateComment]=S.[UpdateComment]

WHEN not matched BY source THEN DELETE;

/* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT
		
END