


/*
 * Tim Firmin 2018JUL06 - Update-Merge PublicReception table from staging
 * Test: EXEC [staging].[uspMergePublicReception] @pLoadId = 321, @pInsertedRowCount = 0
 */  
CREATE PROC [staging].[uspMergePublicReception]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

;WITH UPDATES_BASE AS (
SELECT 
		 upper([StationID])[StationID]
		,[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[TotalPRAllocation]
		,cast(suser_name()  as varchar(100)) as [UpdatedBy] 
		,cast([Comment] as varchar(250)) as [UpdateComment] 
		,@pLoadId as InsertLoadId --Not Currently In Use
	    ,ROW_NUMBER() OVER (PARTITION BY [StationID],[DistributionGroupCode],[DistributionCode],[Society] ORDER BY [InsertTimeStamp] DESC)[Order]
 FROM [staging].[DistributionPublicReception] WHERE nullif(StationID,'') is not null
)
,UPDATES AS (
SELECT 
		upper([StationID])[StationID]
		,[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[TotalPRAllocation]
		, [UpdatedBy]
		, [UpdateComment]
FROM UPDATES_BASE
WHERE	[Order]=1
)
MERGE [FPV].[MasterPublicReception] T
USING UPDATES S ON upper(T.[StationID])=upper(S.[StationID])
			and T.[DistributionGroupCode]=S.[DistributionGroupCode] 
			and T.[DistributionCode]=S.[DistributionCode] 
			and T.[Society]=S.[Society] 

WHEN NOT MATCHED THEN 
INSERT ([StationID]
	  ,[DistributionGroupCode]
	  ,[DistributionCode]
	  ,[Society]
		,TotalPRAllocation
	, [UpdatedBy]
	, [UpdateComment])
VALUES (upper(S.[StationID])
	  ,S.[DistributionGroupCode]
	  ,S.[DistributionCode]
	  ,S.[Society]
	  ,S.[TotalPRAllocation]
	 , S.[UpdatedBy]
	 , S.[UpdateComment])

WHEN MATCHED AND     isnull(T.TotalPRAllocation,0)!=isnull(S.TotalPRAllocation,0)
				
				THEN UPDATE
SET T.TotalPRAllocation=S.TotalPRAllocation
	
	,T.[UpdatedBy]=S.[UpdatedBy]
	,T.[UpdateComment]=S.[UpdateComment]

WHEN not matched BY source THEN DELETE;

/* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT
		
END
GO

