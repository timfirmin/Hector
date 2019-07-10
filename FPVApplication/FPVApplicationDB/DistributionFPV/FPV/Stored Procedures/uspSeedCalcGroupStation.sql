


 
CREATE PROC [FPV].[uspSeedCalcGroupStation]
 @DistributionGroupCode VARCHAR(20)
,@DistributionCode VARCHAR(20)
,@Society VARCHAR(10)
AS

BEGIN

/*****************************************************************************************************
Procedure to Seed Calc Group Rows from Master based on a CalcGroup Insert
Deletes and Updates not Required as this is a One Time Insert
Tim Firmin 2019FEB22
Test : EXEC [FPV].[uspSeedCalcGroupStation] @RequestID = 54887
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
		,@DistributionCode as DistributionCode
		,@Society as Society
		--Specific Fields
	   ,[StationID]
	  --,[CodaCustomerCode]
      ,[StationName]
      ,[StationStatus]
      ,[AudioPolicyMain]
      ,[AudioPolicyCommercial]
      ,[CommercialSampleDays]
      ,[NonCommercialSampleDays]
      ,[TotalSampleDays]
      ,[GroupAdminRate]
      ,[HedgePercent]
      ,[HedgePercentMCPS]
      ,[PRAdminRate]
      ,[MinimumFee]
      ,[RegionalParentStationFlag]
      ,[RegionalParentStationId]
      ,[RegionalWeightingPRS]
      ,[RegionalWeightingMCPS]
      ,[IsExcluded]

		,system_user as [UpdatedBy]
		,'Initial CalcGroup Seeding' as [UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,[IsCurrent]

  FROM [FPV].vMasterStation
  WHERE  
       [DistributionGroupCode] = @DistributionGroupCode
	   AND IsCurrent=1
      --AND [DistributionCode] = @DistributionCode
      --AND [Society] = @Society
),
MergeTarget AS (
SELECT [Society]  
		,[DistributionCode]
		,[DistributionGroupCode]
		--Specific Fields

		,[StationID]
		--,[CodaCustomerCode]
		,[StationName]
		,[StationStatus]
		,[AudioPolicyMain]
		,[AudioPolicyCommercial]
		,[CommercialSampleDays]
		,[NonCommercialSampleDays]
		,[TotalSampleDays]
		,[GroupAdminRate]
		,[HedgePercent]
		,[HedgePercentMCPS]
		,[PRAdminRate]
		,[MinimumFee]
		,[RegionalParentStationFlag]
		,[RegionalParentStationId]
		,[RegionalWeightingPRS]
		,[RegionalWeightingMCPS]
		,[IsExcluded]

	,[UpdatedBy]
	,[UpdateComment] 
FROM	[FPV].[CalculationGroupStation] s
WHERE S.[DistributionGroupCode]=@DistributionGroupCode
	AND		S.[DistributionCode]=@DistributionCode
	AND		s.[Society]=@Society

)
MERGE MergeTarget T
USING (SELECT	[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				[StationID],
				--,[CodaCustomerCode]
				[StationName],
				[StationStatus],
				[AudioPolicyMain],
				[AudioPolicyCommercial],
				[CommercialSampleDays],
				[NonCommercialSampleDays],
				[TotalSampleDays],
				[GroupAdminRate],
				[HedgePercent],
				[HedgePercentMCPS],
				[PRAdminRate],
				[MinimumFee],
				[RegionalParentStationFlag],
				[RegionalParentStationId],
				[RegionalWeightingPRS],
				[RegionalWeightingMCPS],
				[IsExcluded],

				[UpdatedBy],
				[UpdateComment] 
		FROM SeedingUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								--Specific Fields
								[StationID],
								--,[CodaCustomerCode]
								[StationName],
								[StationStatus],
								[AudioPolicyMain],
								[AudioPolicyCommercial],
								[CommercialSampleDays],
								[NonCommercialSampleDays],
								[TotalSampleDays],
								[GroupAdminRate],
								[HedgePercent],
								[HedgePercentMCPS],
								[PRAdminRate],
								[MinimumFee],
								[RegionalParentStationFlag],
								[RegionalParentStationId],
								[RegionalWeightingPRS],
								[RegionalWeightingMCPS],
								[IsExcluded],

								
								[UpdatedBy],
								[UpdateComment] )
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[StationId]=S.[StationId]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
		[DistributionCode],
		[DistributionGroupCode],
		--Specific Fields
		[StationID],
		--,[CodaCustomerCode]
		[StationName],
		[StationStatus],
		[AudioPolicyMain],
		[AudioPolicyCommercial],
		[CommercialSampleDays],
		[NonCommercialSampleDays],
		[TotalSampleDays],
		[GroupAdminRate],
		[HedgePercent],
		[HedgePercentMCPS],
		[PRAdminRate],
		[MinimumFee],
		[RegionalParentStationFlag],
		[RegionalParentStationId],
		[RegionalWeightingPRS],
		[RegionalWeightingMCPS],
		[IsExcluded],

		[UpdatedBy],
		[UpdateComment] )
VALUES (S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
		--Specific Fields
	S.[StationID],
		--,[CodaCustomerCode]
	S.[StationName],
	S.[StationStatus],
	S.[AudioPolicyMain],
	S.[AudioPolicyCommercial],
	S.[CommercialSampleDays],
	S.[NonCommercialSampleDays],
	S.[TotalSampleDays],
	S.[GroupAdminRate],
	S.[HedgePercent],
	S.[HedgePercentMCPS],
	S.[PRAdminRate],
	S.[MinimumFee],
	S.[RegionalParentStationFlag],
	S.[RegionalParentStationId],
	S.[RegionalWeightingPRS],
	S.[RegionalWeightingMCPS],
	S.[IsExcluded],

	S.[UpdatedBy],
	S.[UpdateComment]);

END