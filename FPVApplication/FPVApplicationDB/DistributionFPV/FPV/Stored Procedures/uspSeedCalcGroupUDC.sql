


	
CREATE PROC [FPV].[uspSeedCalcGroupUDC]
 @DistributionGroupCode VARCHAR(20)
,@DistributionCode VARCHAR(20)
,@Society VARCHAR(10)
AS

BEGIN

/*****************************************************************************************************
Procedure to Seed Calc Group Rows from Master based on a CalcGroup Insert
Deletes and Updates not Required as this is a One Time Insert
Tim Firmin 2019FEB22
Test : EXEC [FPV].[uspSeedCalcGroupUDC] @RequestID = 52966
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
;WITH UDCUpdates AS (
SELECT DISTINCT 
       [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[UDCCode]
      ,[UDCDescription]
      ,[UsedForPurposeDesc]
      ,[TimeBand]
      ,[PeakSplitPercent]
      ,system_user as [UpdatedBy]
      ,'Initial CalcGroup Seeding' as [UpdateComment]
      ,[SysStartTime]
      ,[SysEndTime]
      ,[IsCurrent]
  FROM [FPV].[vMasterUDC]
  WHERE  
       [DistributionGroupCode] = @DistributionGroupCode
      AND [DistributionCode] = @DistributionCode
      AND [Society] = @Society
	   AND IsCurrent=1
),
MergeTarget AS (
SELECT [Society],  
	[DistributionCode],
	[DistributionGroupCode],
	[StationID], 

	[UDCCode],
	--added 2018DEC04
	[UDCDescription],
	[UsedForPurposeDesc],
	[TimeBand],
	[PeakSplitPercent],

	[UpdatedBy],
	[UpdateComment] 
FROM	[FPV].[CalculationGroupUDC] s
WHERE S.[DistributionGroupCode]=@DistributionGroupCode
	AND		S.[DistributionCode]=@DistributionCode
	AND		s.[Society]=@Society

)
MERGE MergeTarget T
USING (SELECT	[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				[StationID], 				
				[UDCCode],
				[UDCDescription],
				[UsedForPurposeDesc],
				[TimeBand],
				[PeakSplitPercent],
				[UpdatedBy],
				[UpdateComment] 
		FROM UDCUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								[StationID], 
								[UDCCode],
								--added 2018DEC04
								[UDCDescription],
								[UsedForPurposeDesc],
								[TimeBand],
								[PeakSplitPercent],
								[UpdatedBy],
								[UpdateComment] )
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[StationID]=S.[StationID]
	AND
	T.[UDCCode]=S.[UDCCode]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
		[DistributionCode],
		[DistributionGroupCode],
		[StationID], 		
		[UDCCode],
		[UDCDescription],
		[UsedForPurposeDesc],
		[TimeBand],
		[PeakSplitPercent],
		[UpdatedBy],
		[UpdateComment] )
VALUES (S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
	S.[StationID], 
	S.[UDCCode],
	S.[UDCDescription],
	S.[UsedForPurposeDesc],
	S.[TimeBand],
	S.[PeakSplitPercent],
	S.[UpdatedBy],
	S.[UpdateComment]);

END