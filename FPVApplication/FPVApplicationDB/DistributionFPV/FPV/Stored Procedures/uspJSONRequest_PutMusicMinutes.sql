
--=============================================
--Last Change : TJF 2019APR25 Removed  [Category] [Threshold] [Finalised] [MusicMinutesCategory]
--Last Change : TJF 2019MAY01 Removed  Calc Group Fields from JSON Data String
--Test : EXEC [FPV].[uspJSONRequest_PutMusicMinutes] @RequestID = 76093
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutMusicMinutes]
@RequestID INT
AS

BEGIN
DECLARE @json NVARCHAR(MAX)
DECLARE @withDelete BIT
DECLARE @DistributionGroupCode VARCHAR(20)
DECLARE @DistributionCode VARCHAR(20)
DECLARE @Society VARCHAR(10)
DECLARE @datarowcount INT
DECLARE @merge_output TABLE
(
	[action] VARCHAR(50)
)

/*****************************************************************************************************
GET FILTER VALUES
*****************************************************************************************************/
SELECT @withDelete = isnull([WithDelete],1) 
		,@DistributionGroupCode=[DistributionGroupCode]
		,@DistributionCode=[DistributionCode]
		,@Society=[Society]
FROM [FPV].[vRequestFilters] WHERE [RequestID]=@RequestID

/********************************************************************************************************
GET THE Music MINUTES LISTINGS (REQUEST DATA JSON STRING)
SPECIAL CASE - WHEN NO STATION Music MINUTES RECORDS ARE SUPPLIED IN THE REQUEST DATA 
ACTION: REMOVE ALL Music MINUTES RECORDS FROM CALCULATION GROUP - DUMMY Music MINUTES ROW REQUIRED FOR MERGE UPDATE
*********************************************************************************************************/
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

IF (@json IS NOT NULL)
BEGIN

;WITH MusicMinutesUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,
	[StationID], 
	[ProgrammeForecast],
	[NonProgrammeForecast],
	[CommercialForecast],
	[TotalInPeriodForecast],
	[LateDataForecast],
	[TotalForecast],
	[HighPeakPercent],
	[LowPeakPercent],
	[NonPeakPercent],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	[StationID] varchar(20)          '$.StationID', 
	[ProgrammeForecast] decimal(18,3) '$.ProgrammeForecast',
	[NonProgrammeForecast] decimal(18,3) '$.NonProgrammeForecast',
	[CommercialForecast] decimal(18,3) '$.CommercialForecast',
	[TotalInPeriodForecast] decimal(18,3) '$.TotalInPeriodForecast',
	[LateDataForecast] decimal(18,3) '$.LateDataForecast',
	[TotalForecast] decimal(18,3) '$.TotalForecast',
	[HighPeakPercent]  decimal(12,5) '$.HighPeakPercent',
	[LowPeakPercent]  decimal(12,5) '$.LowPeakPercent',
	[NonPeakPercent]  decimal(12,5) '$.NonPeakPercent',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
MergeTarget AS (
SELECT 
	[Society],  
	[DistributionCode],
	[DistributionGroupCode],
	[StationID], 
	[ProgrammeForecast],
	[NonProgrammeForecast],
	[CommercialForecast],
	[TotalInPeriodForecast],
	[LateDataForecast],
	[TotalForecast],
	[HighPeakPercent],
	[LowPeakPercent],
	[NonPeakPercent],
	[UpdatedBy],
	[UpdateComment] 
FROM	
	[FPV].[CalculationGroupMusicMinutes] s
WHERE
    [DistributionGroupCode] = @DistributionGroupCode
AND [DistributionCode] = @DistributionCode
AND [Society] = @Society
)
MERGE MergeTarget T
USING (SELECT	
				[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				[StationID], 
				[ProgrammeForecast],
				[NonProgrammeForecast],
				[CommercialForecast],
				[TotalInPeriodForecast],
				[LateDataForecast],
				[TotalForecast],
				[HighPeakPercent],
				[LowPeakPercent],
				[NonPeakPercent],
				[UpdatedBy],
				[UpdateComment] 
		FROM MusicMinutesUpdates) S (
								[Society],  
								[DistributionCode],
								[DistributionGroupCode],
								[StationID], 
								[ProgrammeForecast],
								[NonProgrammeForecast],
								[CommercialForecast],
								[TotalInPeriodForecast],
								[LateDataForecast],
								[TotalForecast],
								[HighPeakPercent],
								[LowPeakPercent],
								[NonPeakPercent],
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
		[ProgrammeForecast],
		[NonProgrammeForecast],
		[CommercialForecast],
		[TotalInPeriodForecast],
		[LateDataForecast],
		[TotalForecast],
		[HighPeakPercent],
		[LowPeakPercent],
		[NonPeakPercent],
		[UpdatedBy],
		[UpdateComment] )
VALUES (
	S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
	S.[StationID], 
	S.[ProgrammeForecast],
	S.[NonProgrammeForecast],
	S.[CommercialForecast],
	S.[TotalInPeriodForecast],
	S.[LateDataForecast],
	S.[TotalForecast],
	S.[HighPeakPercent],
	S.[LowPeakPercent],
	S.[NonPeakPercent],
	S.[UpdatedBy],
	S.[UpdateComment])
WHEN MATCHED 
						AND	 isnull(T.[ProgrammeForecast],0)!=isnull(S.[ProgrammeForecast],0)
						OR isnull(T.[NonProgrammeForecast],0)!=isnull(S.[NonProgrammeForecast],0)
						OR isnull(T.[CommercialForecast],0)!=isnull(S.[CommercialForecast],0)
						OR isnull(T.[TotalInPeriodForecast],0)!=isnull(S.[TotalInPeriodForecast],0)
						OR isnull(T.[LateDataForecast],0)!=isnull(S.[LateDataForecast],0)
						OR isnull(T.[TotalForecast],0)!=isnull(S.[TotalForecast],0)
						OR isnull(T.[HighPeakPercent],0)!=isnull(S.[HighPeakPercent],0)
						OR isnull(T.[LowPeakPercent],0)!=isnull(S.[LowPeakPercent],0)
						OR isnull(T.[NonPeakPercent],0)!=isnull(S.[NonPeakPercent],0)
						OR isnull(T.[UpdatedBy],'') != isnull(S.[UpdatedBy],'')
						OR isnull(T.[UpdateComment],'') != isnull(S.[UpdateComment],'')
THEN UPDATE
SET 	
	[ProgrammeForecast]=S.[ProgrammeForecast],
	[NonProgrammeForecast]=S.[NonProgrammeForecast],
	[CommercialForecast]=S.[CommercialForecast],
	[TotalInPeriodForecast]=S.[TotalInPeriodForecast],
	[LateDataForecast]=S.[LateDataForecast],
	[TotalForecast]=S.[TotalForecast],
	[HighPeakPercent]=S.[HighPeakPercent],
	[LowPeakPercent]=S.[LowPeakPercent],
	[NonPeakPercent]=S.[NonPeakPercent],
	[UpdatedBy]=S.[UpdatedBy],
	[UpdateComment]=S.[UpdateComment]

WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupMusicMinutes]
OUTPUT DELETED.StationID INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND [DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','MusicMinutes Updates',@datarowcount)
END