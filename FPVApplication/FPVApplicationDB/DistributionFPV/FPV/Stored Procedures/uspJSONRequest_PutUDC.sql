



-- =============================================
--Removed Revenue and Scenario write-back (Revenue field can probably be removed in Get too)
--Test : EXEC [FPV].[uspJSONRequest_PutUDC] @RequestID = 65602
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutUDC]
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

;WITH UDCUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,
	[StationID], 
	[UsedForPurposeDesc],
	[TimeBand],
	[UDCCode],
	[UDCDescription],	
	[PeakSplitPercent],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	[StationID] varchar(20)          '$.StationID',
	[UDCCode] varchar(20)          '$.calculationUDCCode', 
	[UsedForPurposeDesc] varchar(50)          '$.UsedForPurposeDesc', 
	[TimeBand] varchar(50)          '$.TimeBand', 
	[UDCDescription] varchar(20)          '$.UDCDescription', 
	[PeakSplitPercent] decimal(12,3) '$.PeakSplitPercent',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
MergeTarget AS (
SELECT [Society],  
	[DistributionCode],
	[DistributionGroupCode],
	[StationID],
	[UsedForPurposeDesc],
	[TimeBand], 
	[UDCCode],
	[UDCDescription],
	[PeakSplitPercent],
	[UpdatedBy],
	[UpdateComment] 
FROM	[FPV].[CalculationGroupUDC] s
WHERE
    [DistributionGroupCode] = @DistributionGroupCode
AND [DistributionCode] = @DistributionCode
AND [Society] = @Society
)
MERGE MergeTarget T
USING (SELECT	[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				[StationID],
				[UsedForPurposeDesc],
				[TimeBand], 			
				[UDCCode],
				[UDCDescription],			
				[PeakSplitPercent],
				[UpdatedBy],
				[UpdateComment] 
		FROM UDCUpdates) S ([Society],  
							[DistributionCode],
							[DistributionGroupCode],
							[StationID],
							[UsedForPurposeDesc],
							[TimeBand], 			
							[UDCCode],
							[UDCDescription],			
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
	T.[TimeBand]=S.[TimeBand]
	AND
	T.[UsedForPurposeDesc]=S.[UsedForPurposeDesc]
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
VALUES (
	S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
	S.[StationID], 
	S.[UDCCode],
	S.[UDCDescription],
	S.[UsedForPurposeDesc],
	S.[TimeBand],
	S.[PeakSplitPercent],
	S.[UpdatedBy],
	S.[UpdateComment])
WHEN MATCHED 
						AND		isnull(T.[UDCCode],'')!=isnull(S.[UDCCode],'')
						OR isnull(T.[PeakSplitPercent],'')!=isnull(S.[PeakSplitPercent],'')
						OR isnull(T.[UDCDescription],'')!=isnull(S.[UDCDescription],'')						
						OR isnull(T.[UpdatedBy],'') != isnull(S.[UpdatedBy],'')
						OR isnull(T.[UpdateComment],'') != isnull(S.[UpdateComment],'')
THEN UPDATE
SET 	[UDCCode]=S.[UDCCode],
	[PeakSplitPercent]=S.[PeakSplitPercent],
	[UDCDescription]=S.[UDCDescription],
	[UpdatedBy]=S.[UpdatedBy],
	[UpdateComment]=S.[UpdateComment]

WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupUDC]
OUTPUT DELETED.StationID INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND [DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','UDC Updates',@datarowcount)
END