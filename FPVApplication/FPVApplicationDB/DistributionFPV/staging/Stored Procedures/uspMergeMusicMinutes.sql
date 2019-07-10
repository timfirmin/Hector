
/*
 * Tim Firmin 2018JUL06 - Update-Merge MusicMinutes table from staging
 * Test: EXEC [staging].[uspMergeMusicMinutes]  @pLoadId = 321, @pInsertedRowCount = 0
 */ 
CREATE PROC [staging].[uspMergeMusicMinutes]
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
		--,[MusicReportingGroup]
		,[ProgrammeForecast]
		,[NonProgrammeForecast]
		,[CommercialForecast]
		,[TotalInPeriodForecast]
		,[LateDataForecast]
		,[TotalForecast]

		,[AdjHighPeakPercent]
		,[AdjLowPeakPercent]
		,[AdjNonPeakPercent]

		,suser_name() [UpdatedBy]
		,cast([Comment] as varchar(250)) as [UpdateComment] 
		,ROW_NUMBER() OVER (PARTITION BY [StationID],[DistributionGroupCode],[DistributionCode],[Society] ORDER BY [InsertTimeStamp] DESC)[Order]
		,@pLoadId as InsertLoadId --Not Currently In Use
		,cast(getdate() as datetime2(7)) as InsertTimeStamp --Not Currently In Use

 FROM [staging].[vDistributionMusicMinutes]
)
,UPDATES AS (
SELECT upper([StationID])[StationID]
	  ,[DistributionGroupCode]
	  ,[DistributionCode]
	  ,[Society]
	  ,[ProgrammeForecast]
	  ,[NonProgrammeForecast]
	  ,[CommercialForecast]
	  ,[TotalForecast]
	  ,[TotalInPeriodForecast]
	  ,[LateDataForecast]
	,[AdjHighPeakPercent]
	,[AdjLowPeakPercent]
	,[AdjNonPeakPercent]
	,[UpdatedBy]
	,[UpdateComment]

FROM UPDATES_BASE
WHERE	[Order]=1
)
MERGE [FPV].[MasterMusicMinutes] T
USING UPDATES S ON upper(T.[StationID])=upper(S.[StationID])
			and T.[DistributionGroupCode]=S.[DistributionGroupCode] 
			and T.[DistributionCode]=S.[DistributionCode] 
			and T.[Society]=S.[Society] 

WHEN NOT MATCHED THEN 
INSERT ([StationID]
	  ,[DistributionGroupCode]
	  ,[DistributionCode]
	  ,[Society]
	  ,[ProgrammeForecast]
	  ,[NonProgrammeForecast]
	  ,[CommercialForecast]
	  ,[TotalForecast]
	  ,[TotalInPeriodForecast]
	  ,[LateDataForecast]
	,[HighPeakPercent]
	,[LowPeakPercent]
	,[NonPeakPercent]

	, [UpdatedBy]
	, [UpdateComment])
VALUES (UPPER(S.[StationID])
	  ,S.[DistributionGroupCode]
	  ,S.[DistributionCode]
	  ,S.[Society]
	  ,S.[ProgrammeForecast]
	  ,S.[NonProgrammeForecast]
	  ,S.[CommercialForecast]
	  ,S.[TotalForecast]
	,S.[TotalInPeriodForecast]
	,S.[LateDataForecast]
	,S.[AdjHighPeakPercent]
	,S.[AdjLowPeakPercent]
	,S.[AdjNonPeakPercent]

	, S.[UpdatedBy]
	, S.[UpdateComment])

WHEN MATCHED AND  isnull(T.[ProgrammeForecast],0)!=isnull(S.[ProgrammeForecast],0)
				  OR isnull(T.[NonProgrammeForecast],0)!=isnull(S.[NonProgrammeForecast],0)
				  OR isnull(T.[CommercialForecast],0)!=isnull(S.[CommercialForecast],0)
				  OR isnull(T.[TotalForecast],0)!=isnull(S.[TotalForecast],0)
				  OR isnull(T.[TotalInPeriodForecast],0)!=isnull(S.[TotalInPeriodForecast],0)
				  OR isnull(T.[LateDataForecast],0)!=isnull(S.[LateDataForecast],0)
				  OR isnull(T.[HighPeakPercent],0)!=isnull(S.[AdjHighPeakPercent],0)
				  OR isnull(T.[LowPeakPercent],0)!=isnull(S.[AdjLowPeakPercent],0)
				  OR isnull(T.[NonPeakPercent],0)!=isnull(S.[AdjNonPeakPercent],0)

				THEN UPDATE
SET T.[ProgrammeForecast]=S.[ProgrammeForecast]
	,T.[NonProgrammeForecast]=S.[NonProgrammeForecast]
	,T.[CommercialForecast]=S.[CommercialForecast]
	,T.[TotalForecast]=S.[TotalForecast]
	,T.[TotalInPeriodForecast]=S.[TotalInPeriodForecast]
	,T.[LateDataForecast]=S.[LateDataForecast]
	,T.[HighPeakPercent]=S.[AdjHighPeakPercent]
	,T.[LowPeakPercent]=S.[AdjLowPeakPercent]
	,T.[NonPeakPercent]=S.[AdjNonPeakPercent]

	,T.[UpdatedBy]=S.[UpdatedBy]
	,T.[UpdateComment]=S.[UpdateComment]

WHEN not matched BY source THEN DELETE;

/* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT
		
END
