


 
CREATE PROC [FPV].[uspSeedCalcGroupMusicMinutes]
 @DistributionGroupCode VARCHAR(20)
,@DistributionCode VARCHAR(20)
,@Society VARCHAR(10)
AS

BEGIN

/*****************************************************************************************************
Procedure to Seed Calc Group Rows from Master based on a CalcGroup Insert
Deletes and Updates not Required as this is a One Time Insert
Tim Firmin 2019FEB22
Test : EXEC [FPV].[uspSeedCalcGroupMusicMinutes] @RequestID = 54887
*****************************************************************************************************/

--DECLARE @DistributionGroupCode VARCHAR(20)
--DECLARE @DistributionCode VARCHAR(20)
--DECLARE @Society VARCHAR(10)

/*****************************************************************************************************
GET FILTER VALUES
*****************************************************************************************************/
--SELECT   @DistributionGroupCode=[DistributionGroupCode]
--	,@DistributionCode=[DistributionCode]
--	,@Society=[Society]
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

      ,[ProgrammeForecast]
      ,[NonProgrammeForecast]
      ,[CommercialForecast]
      ,[TotalInPeriodForecast]
      ,[LateDataForecast]
      ,[TotalForecast]

		,system_user as [UpdatedBy]
		,'Initial CalcGroup Seeding' as [UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,[IsCurrent]

  FROM [FPV].vMasterMusicMinutes
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

      ,[ProgrammeForecast]
      ,[NonProgrammeForecast]
      ,[CommercialForecast]
      ,[TotalInPeriodForecast]
      ,[LateDataForecast]
      ,[TotalForecast]

	,[UpdatedBy]
	,[UpdateComment] 
FROM	[FPV].[CalculationGroupMusicMinutes] s
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

			  [ProgrammeForecast],
			  [NonProgrammeForecast],
			  [CommercialForecast],
			  [TotalInPeriodForecast],
			  [LateDataForecast],
			  [TotalForecast],
				[UpdatedBy],
				[UpdateComment] 
		FROM SeedingUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								[StationID], 
								--Specific Fields

								  [ProgrammeForecast],
								  [NonProgrammeForecast],
								  [CommercialForecast],
								  [TotalInPeriodForecast],
								  [LateDataForecast],
								  [TotalForecast],
								
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

      [ProgrammeForecast],
      [NonProgrammeForecast],
      [CommercialForecast],
      [TotalInPeriodForecast],
      [LateDataForecast],
      [TotalForecast],

		[UpdatedBy],
		[UpdateComment] )
VALUES (S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
	S.[StationID], 
		--Specific Fields

	S.[ProgrammeForecast],
	S.[NonProgrammeForecast],
	S.[CommercialForecast],
	S.[TotalInPeriodForecast],
	S.[LateDataForecast],
	S.[TotalForecast],
	S.[UpdatedBy],
	S.[UpdateComment]);

END