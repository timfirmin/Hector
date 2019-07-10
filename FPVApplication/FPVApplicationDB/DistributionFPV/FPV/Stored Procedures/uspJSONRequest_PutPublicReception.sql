
--=============================================
--Last Change : TJF 2019MAY01 Removed  Calc Group Fields from JSON Data String
--Test : EXEC [FPV].[uspJSONRequest_PutPublicReception] @RequestID = 65602
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutPublicReception]
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

;WITH PublicReceptionUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,
	[StationID], 
	[TotalPRAllocation],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	--[Society]   varchar(10) '$.Society' ,  
	--[DistributionCode] varchar(20) '$.DistributionCode', 
	--[DistributionGroupCode] varchar(20) '$.DistributionGroupCode',
	[StationID] varchar(20)          '$.StationID', 
	[TotalPRAllocation] decimal(18,3) '$.TotalPRAllocation',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
--DistributionGrouping AS (
--	SELECT	DISTINCT	
--			COALESCE(f.[Society],u.[Society])[Society]
--			,COALESCE(f.[DistributionCode],u.[DistributionCode])[DistributionCode]
--			,COALESCE(f.[DistributionGroupCode],u.[DistributionGroupCode])[DistributionGroupCode]
--	FROM	PublicReceptionUpdates u, [FPV].[vRequestFilters] f 
--	WHERE	f.RequestID=@RequestID
--),
MergeTarget AS (
SELECT [Society],  
	[DistributionCode],
	[DistributionGroupCode],
	[StationID], 
	[TotalPRAllocation],
	[UpdatedBy],
	[UpdateComment] 
FROM	[FPV].[CalculationGroupPublicReception] s
WHERE
    [DistributionGroupCode] = @DistributionGroupCode
AND [DistributionCode] = @DistributionCode
AND [Society] = @Society
--EXISTS (	SELECT *	
--				FROM DistributionGrouping g
--				WHERE	S.[DistributionGroupCode]=g.[DistributionGroupCode]
--				AND		S.[DistributionCode]=g.[DistributionCode]
--				AND		s.[Society]=g.[Society])
)
MERGE MergeTarget T
USING (SELECT	[Society],  
				[DistributionCode],
				[DistributionGroupCode],
				[StationID], 
				[TotalPRAllocation],
				[UpdatedBy],
				[UpdateComment] 
		FROM PublicReceptionUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								[StationID], 
								[TotalPRAllocation],
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
		[TotalPRAllocation],
		[UpdatedBy],
		[UpdateComment] )
VALUES (
	S.[Society],  
	S.[DistributionCode], 
	S.[DistributionGroupCode], 
	S.[StationID], 
	S.[TotalPRAllocation],
	S.[UpdatedBy],
	S.[UpdateComment])
WHEN MATCHED AND		isnull(T.[TotalPRAllocation],0)!=isnull(S.[TotalPRAllocation],0)
						 

THEN UPDATE
SET 	[TotalPRAllocation]=S.[TotalPRAllocation]


WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupPublicReception]
OUTPUT DELETED.StationID INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND [DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','PublicReception Updates',@datarowcount)
END