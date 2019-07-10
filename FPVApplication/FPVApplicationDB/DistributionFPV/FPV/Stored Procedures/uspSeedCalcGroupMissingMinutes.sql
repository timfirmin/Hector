


 
CREATE PROC [FPV].[uspSeedCalcGroupMissingMinutes]
 @DistributionGroupCode VARCHAR(20)
,@DistributionCode VARCHAR(20)
,@Society VARCHAR(10)
AS

BEGIN

/*****************************************************************************************************
Procedure to Seed Calc Group Rows from Master based on a CalcGroup Insert
Deletes and Updates not Required as this is a One Time Insert
Tim Firmin 2019FEB22
Test : EXEC [FPV].[uspSeedCalcGroupMissingMinutes] @RequestID = 52966
*****************************************************************************************************/

--DECLARE @DistributionGroupCode VARCHAR(20)
--DECLARE @DistributionCode VARCHAR(20)
--DECLARE @Society VARCHAR(10)

/*****************************************************************************************************
GET FILTER VALUES
*****************************************************************************************************/
--SELECT   @DistributionGroupCode=[DistributionGroupCode]
--		,@DistributionCode=[DistributionCode]
--		,@Society=[Society]
--FROM [FPV].[vResponseCalcGroupFilters] WHERE [RequestID]=@RequestID

/********************************************************************************************************
INSERT SEED / EMPTY RECORDSET AFTER CALC GROUP INSERT
*********************************************************************************************************/
;WITH SeedingUpdates AS (
SELECT DISTINCT 
		 [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		--Specific Fields
      ,[MissingMinutes]
      ,[CarryForwardsMinutes]
      ,[TotalMinutesToHold]
      ,[MissingRevenue]
      ,[CarryForwardsRevenue]
      ,[TotalRevenueToHold]

		,system_user as [UpdatedBy]
		,'Initial CalcGroup Seeding' as [UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,[IsCurrent]

  FROM [FPV].vMasterMissingMinutes
  WHERE  
       [DistributionGroupCode] = @DistributionGroupCode
      AND [DistributionCode] = @DistributionCode
      AND [Society] = @Society
	  AND IsCurrent=1
),
MergeTarget AS (
SELECT [Society]  
		,[DistributionCode]
		,[DistributionGroupCode]
		,[StationID]
		--Specific Fields
      ,[MissingMinutes]
      ,[CarryForwardsMinutes]
      ,[TotalMinutesToHold]
      ,[MissingRevenue]
      ,[CarryForwardsRevenue]
      ,[TotalRevenueToHold]

	,[UpdatedBy]
	,[UpdateComment] 
FROM	[FPV].[CalculationGroupMissingMinutes] s
WHERE S.[DistributionGroupCode]=@DistributionGroupCode
	AND		S.[DistributionCode]=@DistributionCode
	AND		s.[Society]=@Society

)
MERGE MergeTarget T
USING (SELECT	[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				[StationID], 				
				--Specific Fields
			  [MissingMinutes],
			  [CarryForwardsMinutes],
			  [TotalMinutesToHold],
			  [MissingRevenue],
			  [CarryForwardsRevenue],
			  [TotalRevenueToHold],
				[UpdatedBy],
				[UpdateComment] 
		FROM SeedingUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								[StationID], 
								--Specific Fields
								[MissingMinutes],
								[CarryForwardsMinutes],
								[TotalMinutesToHold],
								[MissingRevenue],
								[CarryForwardsRevenue],
								[TotalRevenueToHold],
								
								[UpdatedBy],
								[UpdateComment] )
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[StationID]=S.[StationID]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
		[DistributionCode],
		[DistributionGroupCode],
		[StationID], 		
		--Specific Fields
		[MissingMinutes],
		[CarryForwardsMinutes],
		[TotalMinutesToHold],
		[MissingRevenue],
		[CarryForwardsRevenue],
		[TotalRevenueToHold],

		[UpdatedBy],
		[UpdateComment] )
VALUES (S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
	S.[StationID], 
		--Specific Fields
	S.[MissingMinutes],
	S.[CarryForwardsMinutes],
	S.[TotalMinutesToHold],
	S.[MissingRevenue],
	S.[CarryForwardsRevenue],
	S.[TotalRevenueToHold],
	S.[UpdatedBy],
	S.[UpdateComment]);

END