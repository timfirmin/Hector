 
--=============================================
--Last Change : TJF 2019MAY01 Removed  Calc Group Fields from JSON Data String
--Test : EXEC [FPV].[uspJSONRequest_PutMissingMinutes] @RequestID = 65602
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutMissingMinutes]
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
GET THE MISSING MINUTES LISTINGS (REQUEST DATA JSON STRING)
SPECIAL CASE - WHEN NO STATION MISSING MINUTES RECORDS ARE SUPPLIED IN THE REQUEST DATA 
ACTION: REMOVE ALL MISSING MINUTES RECORDS FROM CALCULATION GROUP - DUMMY MISSING MINUTES ROW REQUIRED FOR MERGE UPDATE
*********************************************************************************************************/
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

IF (@json IS NOT NULL)
BEGIN

;WITH MissingMinutesUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,
	[StationID], 
	[MissingMinutes],
	[CarryForwardsMinutes],
	[TotalMinutesToHold],
	[MissingRevenue],
	[CarryForwardsRevenue],
	[TotalRevenueToHold],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	--[Society]   varchar(10) '$.Society' ,  
	--[DistributionCode] varchar(20) '$.DistributionCode',  
	--[DistributionGroupCode] varchar(20) '$.DistributionGroupCode',  
	[StationID] varchar(20)          '$.StationID', 
	[MissingMinutes] decimal(18,3) '$.MissingMinutes',
	[CarryForwardsMinutes] decimal(18,3) '$.CarryForwardsMinutes',
	[TotalMinutesToHold] decimal(18,3) '$.TotalMinutesToHold',
	[MissingRevenue] decimal(18,3) '$.MissingRevenue',
	[CarryForwardsRevenue] decimal(18,3) '$.CarryForwardsRevenue',
	[TotalRevenueToHold] decimal(18,3) '$.TotalRevenueToHold',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
--DistributionGrouping AS (
--	SELECT	DISTINCT	
--			COALESCE(f.[Society],u.[Society])[Society]
--			,COALESCE(f.[DistributionCode],u.[DistributionCode])[DistributionCode]
--			,COALESCE(f.[DistributionGroupCode],u.[DistributionGroupCode])[DistributionGroupCode]
--	FROM	MissingMinutesUpdates u, [FPV].[vRequestFilters] f 
--	WHERE	f.RequestID=@RequestID
--),
MergeTarget AS (
SELECT [Society],  
	[DistributionCode],
	[DistributionGroupCode],
	[StationID], 
	[MissingMinutes],
	[CarryForwardsMinutes],
	[TotalMinutesToHold],
	[MissingRevenue],
	[CarryForwardsRevenue],
	[TotalRevenueToHold],
	[UpdatedBy],
	[UpdateComment] 
FROM	[FPV].[CalculationGroupMissingMinutes] s
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
				[MissingMinutes],
				[CarryForwardsMinutes],
				[TotalMinutesToHold],
				[MissingRevenue],
				[CarryForwardsRevenue],
				[TotalRevenueToHold],
				[UpdatedBy],
				[UpdateComment] 
		FROM MissingMinutesUpdates) S ([Society],  
								[DistributionCode],
								[DistributionGroupCode],
								[StationID], 
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
		[MissingMinutes],
		[CarryForwardsMinutes],
		[TotalMinutesToHold],
		[MissingRevenue],
		[CarryForwardsRevenue],
		[TotalRevenueToHold],
		[UpdatedBy],
		[UpdateComment] )
VALUES (
		S.[Society],  
		S.[DistributionCode], 
		S.[DistributionGroupCode], 
		S.[StationID], 
		S.[MissingMinutes],
		S.[CarryForwardsMinutes],
		S.[TotalMinutesToHold],
		S.[MissingRevenue],
		S.[CarryForwardsRevenue],
		S.[TotalRevenueToHold],
		S.[UpdatedBy],
		S.[UpdateComment])
WHEN MATCHED AND	isnull(T.[MissingMinutes],0)!=isnull(S.[MissingMinutes],0)
					OR isnull(T.[CarryForwardsMinutes],0)!=isnull(S.[CarryForwardsMinutes],0)
					OR isnull(T.[TotalMinutesToHold],0)!=isnull(S.[TotalMinutesToHold],0)
					OR isnull(T.[MissingRevenue],0)!=isnull(S.[MissingRevenue],0)
					OR isnull(T.[CarryForwardsRevenue],0)!=isnull(S.[CarryForwardsRevenue],0)
					OR isnull(T.[TotalRevenueToHold],0)!=isnull(S.[TotalRevenueToHold],0)
						OR isnull(T.[UpdatedBy],'') != isnull(S.[UpdatedBy],'')
						OR isnull(T.[UpdateComment],'') != isnull(S.[UpdateComment],'')

THEN UPDATE
SET [MissingMinutes]=S.[MissingMinutes],
	[CarryForwardsMinutes]=S.[CarryForwardsMinutes],
	[TotalMinutesToHold]=S.[TotalMinutesToHold],
	[MissingRevenue]=S.[MissingRevenue],
	[CarryForwardsRevenue]=S.[CarryForwardsRevenue],
	[TotalRevenueToHold]=S.[TotalRevenueToHold],
	[UpdatedBy]=S.[UpdatedBy],
	[UpdateComment]=S.[UpdateComment]

WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupMissingMinutes]
OUTPUT DELETED.StationID INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND [DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','MissingMinutes Updates',@datarowcount)
END