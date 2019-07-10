


 
CREATE PROC [FPV].[uspSeedCalcGroupRevenueGroup]
 @DistributionGroupCode VARCHAR(20)
,@DistributionCode VARCHAR(20)
,@Society VARCHAR(10)
AS

BEGIN

/*****************************************************************************************************
Procedure to Seed Calc Group Rows from Master based on a CalcGroup Insert
Deletes and Updates not Required as this is a One Time Insert
Tim Firmin 2019FEB22
Test : EXEC [FPV].[uspSeedCalcGroupRevenueGroup] @RequestID = 52966
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

	   ,[RevenueGroupCode]
       ,[RevenueGroupName]
       ,[SocietySplitPercent]
       ,[HedgedRate] as HedgePercent
       --,[EstimatedRevenue]
       --,[EstimatedPoints]
       --,[HedgedRevenue]
       --,[SocietyRevenue]
       --,[FPVStatus]
       --,[RingFenceValue]
       ,[RevenueApportionmentMethodPRS]
       ,[RevenueApportionmentMethodMCPS]
       ,[IsExcluded]



		,system_user as [UpdatedBy]
		,'Initial CalcGroup Seeding' as [UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,[IsCurrent]

  FROM [FPV].vMasterRevenueGroup
  WHERE  
       [DistributionGroupCode] = @DistributionGroupCode
      --AND [DistributionCode] = @DistributionCode
      --AND [Society] = @Society
	  AND IsCurrent=1
),
MergeTarget AS (
SELECT [Society]  
		,[DistributionCode]
		,[DistributionGroupCode]
		--Specific Fields

	   ,[RevenueGroupCode]
       ,[RevenueGroupName]
       ,[SocietySplitPercent]
       ,HedgePercent
       --,[EstimatedRevenue]
       --,[EstimatedPoints]
       --,[HedgedRevenue]
       --,[SocietyRevenue]
       --,[FPVStatus]
       --,[RingFenceValue]
       ,[RevenueApportionmentMethodPRS]
       ,[RevenueApportionmentMethodMCPS]
       ,[IsExcluded]

	,[UpdatedBy]
	,[UpdateComment] 
FROM	[FPV].[CalculationGroupRevenueGroup] s
WHERE S.[DistributionGroupCode]=@DistributionGroupCode
	AND		S.[DistributionCode]=@DistributionCode
	AND		s.[Society]=@Society

)
MERGE MergeTarget T
USING (SELECT	[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				--Specific Fields
			   [RevenueGroupCode],
			   [RevenueGroupName],
			   [SocietySplitPercent],
			   HedgePercent,
			   --,[EstimatedRevenue]
			   --,[EstimatedPoints]
			   --,[HedgedRevenue]
			   --,[SocietyRevenue]
			   --,[FPVStatus]
			   --,[RingFenceValue]
			   [RevenueApportionmentMethodPRS],
			   [RevenueApportionmentMethodMCPS],
			   [IsExcluded],

				[UpdatedBy],
				[UpdateComment] 
		FROM SeedingUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								--Specific Fields
							   [RevenueGroupCode],
							   [RevenueGroupName],
							   [SocietySplitPercent],
							   HedgePercent,
							   --,[EstimatedRevenue]
							   --,[EstimatedPoints]
							   --,[HedgedRevenue]
							   --,[SocietyRevenue]
							   --,[FPVStatus]
							   --,[RingFenceValue]
							   [RevenueApportionmentMethodPRS],
							   [RevenueApportionmentMethodMCPS],
							   [IsExcluded],
								
								[UpdatedBy],
								[UpdateComment] )
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[RevenueGroupCode]=S.[RevenueGroupCode]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
		[DistributionCode],
		[DistributionGroupCode],
		[RevenueGroupCode],
		[RevenueGroupName],
		[SocietySplitPercent],
		HedgePercent,
		--,[EstimatedRevenue]
		--,[EstimatedPoints]
		--,[HedgedRevenue]
		--,[SocietyRevenue]
		--,[FPVStatus]
		--,[RingFenceValue]
		[RevenueApportionmentMethodPRS],
		[RevenueApportionmentMethodMCPS],
		[IsExcluded],

		[UpdatedBy],
		[UpdateComment] )
VALUES (S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
		--Specific Fields
	S.[RevenueGroupCode],
	S.[RevenueGroupName],
	S.[SocietySplitPercent],
	S.HedgePercent,
							   --,[EstimatedRevenue]
							   --,[EstimatedPoints]
							   --,[HedgedRevenue]
							   --,[SocietyRevenue]
							   --,[FPVStatus]
							   --,[RingFenceValue]
	S.[RevenueApportionmentMethodPRS],
	S.[RevenueApportionmentMethodMCPS],
	S.[IsExcluded],
	S.[UpdatedBy],
	S.[UpdateComment]);

END