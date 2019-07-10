
-- =============================================
--Removed Revenue and Scenario write-back (Revenue field can probably be removed in Get too)
--Test : EXEC [FPV].[uspJSONRequest_PutStations] @RequestID = 65630
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutStations]
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
GET THE STATION LISTINGS (REQUEST DATA JSON STRING)
SPECIAL CASE - WHEN NO STATIONS ARE SUPPLIED IN THE REQUEST DATA 
ACTION: REMOVE ALL STATIONS FROM CALCULATION GROUP - DUMMY STATION ROW REQUIRED FOR MERGE UPDATE
*********************************************************************************************************/
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

IF (@json IS NOT NULL)
BEGIN

;WITH StationUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,
	[StationID], 
	[StationName],

	[StationStatus],
	[GroupAdminRate],
	[HedgePercent],
	[HedgePercentMCPS],
	[PRAdminRate],
	[IsExcluded],

	--Added 2018SEP04
	AudioPolicyMain,
	AudioPolicyCommercial,
	CommercialSampleDays,
	NonCommercialSampleDays,
	TotalSampleDays,
	--Added 2018SEP19
	[MinimumFee],
	[BroadcastHours],
	--Added 2018OCT16
	[LicenceFeeSplitPercent],
	--Added 2019FEB18
      [RegionalParentStationFlag],
      [RegionalParentStationId],
      [RegionalWeightingPRS],
      [RegionalWeightingMCPS],
	[FPVStatus],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	--[Society]   varchar(10) '$.Society' ,  
	--[DistributionGroupCode] varchar(20) '$.DistributionGroupCode',  
	--[DistributionCode] varchar(20) '$.DistributionCode',  
	[StationID] varchar(20)          '$.StationID', 
	[StationName] varchar(100) '$.StationName',

	[StationStatus] varchar(100) '$.StationStatus',
	[GroupAdminRate] decimal(18,3) '$.GroupAdminRate',
	[HedgePercent] decimal(18,3) '$.HedgePercent',
	[HedgePercentMCPS] decimal(18,3) '$.HedgePercentMCPS',
	[PRAdminRate] decimal(18,3) '$.PRAdminRate',
	[IsExcluded] bit '$.IsExcluded',

	--Added 2018SEP04
	[AudioPolicyMain] varchar(100) '$.AudioPolicyMain',
	[AudioPolicyCommercial] varchar(100) '$.AudioPolicyCommercial',
	[CommercialSampleDays] decimal(18,3) '$.CommercialSampleDays',
	[NonCommercialSampleDays] decimal(18,3) '$.NonCommercialSampleDays',
	[TotalSampleDays] decimal(18,3) '$.TotalSampleDays',
	--Added 2018SEP19
	[MinimumFee] decimal(18,3) '$.MinimumFee',
	[BroadcastHours] decimal(18,3) '$.BroadcastHours',
	--Added 2018OCT16
	[LicenceFeeSplitPercent] decimal(12,4) '$.LicenceFeeSplitPercent',
	--Added 2019FEB18
      [RegionalParentStationFlag] varchar(100) '$.RegionalParentStationFlag',
      [RegionalParentStationId] varchar(100) '$.RegionalParentStationId',
      [RegionalWeightingPRS] decimal(12,4) '$.RegionalWeightingPRS',
      [RegionalWeightingMCPS] decimal(12,4) '$.RegionalWeightingMCPS',

	[FPVStatus] varchar(20) '$.FPVStatus',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
--DistributionGrouping AS (
--	SELECT	DISTINCT	
--			COALESCE(f.[Society],u.[Society])[Society]
--			,COALESCE(f.[DistributionGroupCode],u.[DistributionGroupCode])[DistributionGroupCode]
--			,COALESCE(f.[DistributionCode],u.[DistributionCode])[DistributionCode]
--	FROM	StationUpdates u, [FPV].[vRequestFilters] f 
--	WHERE	f.RequestID=@RequestID
--),
MergeTarget AS (
SELECT 
		 [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[StationName]

		,[StationStatus]
		,[GroupAdminRate]
		,[HedgePercent]
		,[HedgePercentMCPS]
		,[PRAdminRate]
		,[IsExcluded]

		--Added 2018SEP04
		,[AudioPolicyMain]
		,[AudioPolicyCommercial]
		,[CommercialSampleDays]
		,[NonCommercialSampleDays]
		,[TotalSampleDays]
		--Added 2018SEP19
		,[MinimumFee]
		,[BroadcastHours] 
		--Added 2018OCT16
		,[LicenceFeeSplitPercent]
		--Added 2019FEB18
		,[RegionalParentStationFlag]
		,[RegionalParentStationId]
		,[RegionalWeightingPRS]
		,[RegionalWeightingMCPS]
		,[FPVStatus]
		,[UpdatedBy]
		,[UpdateComment]
FROM	[FPV].[CalculationGroupStation] s
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
USING (SELECT			[Society] ,  
						[DistributionGroupCode],  
						[DistributionCode],  
						[StationID], 
						[StationName],
				
						[StationStatus],
						[GroupAdminRate],
						[HedgePercent],
						[HedgePercentMCPS],
						[PRAdminRate],
						[IsExcluded],

						--Added 2018SEP04
						[AudioPolicyMain],
						[AudioPolicyCommercial],
						[CommercialSampleDays],
						[NonCommercialSampleDays],
						[TotalSampleDays],
						--Added 2018SEP19
						[MinimumFee],
						[BroadcastHours],
							--Added 2018OCT16
						[LicenceFeeSplitPercent],
					--Added 2019FEB18
					  [RegionalParentStationFlag],	
					  [RegionalParentStationId],
					  [RegionalWeightingPRS],
					  [RegionalWeightingMCPS],
						[FPVStatus],
						[UpdatedBy],
						[UpdateComment]
		FROM StationUpdates) S ([Society] ,  
						[DistributionGroupCode],  
						[DistributionCode],  
						[StationID], 
						[StationName],
						
						[StationStatus],
						[GroupAdminRate],
						[HedgePercent],
						[HedgePercentMCPS],
						[PRAdminRate],
						[IsExcluded],
	
						--Added 2018SEP04
						[AudioPolicyMain],
						[AudioPolicyCommercial],
						[CommercialSampleDays],
						[NonCommercialSampleDays],
						[TotalSampleDays],
						--Added 2018SEP19
						[MinimumFee],
						[BroadcastHours],
						--Added 2018OCT16
						[LicenceFeeSplitPercent],
					--Added 2019FEB18
					  [RegionalParentStationFlag],	
					  [RegionalParentStationId],
					  [RegionalWeightingPRS],
					  [RegionalWeightingMCPS],
						[FPVStatus],
						[UpdatedBy],
						[UpdateComment])
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[StationID]=S.[StationID]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
	[DistributionGroupCode],  
	[DistributionCode],  
	[StationID], 
	[StationName],

	[StationStatus],
	[GroupAdminRate],
	[HedgePercent],
	[HedgePercentMCPS],
	[PRAdminRate],
	[IsExcluded],

	--Added 2018SEP04
	[AudioPolicyMain],
	[AudioPolicyCommercial],
	[CommercialSampleDays],
	[NonCommercialSampleDays],
	[TotalSampleDays],
	--Added 2018SEP19
	[MinimumFee],
	[BroadcastHours],
		--Added 2018OCT16
	[LicenceFeeSplitPercent],
--Added 2019FEB18
	[RegionalParentStationFlag],	
	[RegionalParentStationId],
	[RegionalWeightingPRS],
	[RegionalWeightingMCPS],
	[FPVStatus],
	[UpdatedBy],
	[UpdateComment])
VALUES (
	S.[Society],  
	S.[DistributionGroupCode], 
	S.[DistributionCode], 
	S.[StationID], 
	S.[StationName],

	S.[StationStatus],
	S.[GroupAdminRate],
	S.[HedgePercent],
	S.[HedgePercentMCPS],
	S.[PRAdminRate],
	S.[IsExcluded],

	--Added 2018SEP04
	S.[AudioPolicyMain],
	S.[AudioPolicyCommercial],
	S.[CommercialSampleDays],
	S.[NonCommercialSampleDays],
	S.[TotalSampleDays],
	--Added 2018SEP19
	S.[MinimumFee],
	S.[BroadcastHours],
	--Added 2018OCT16
	S.[LicenceFeeSplitPercent],
--Added 2019FEB18
	S.[RegionalParentStationFlag],	
	S.[RegionalParentStationId],
	S.[RegionalWeightingPRS],
	S.[RegionalWeightingMCPS],
	S.[FPVStatus],
	S.[UpdatedBy],
	S.[UpdateComment])
WHEN MATCHED AND	   isnull(T.[GroupAdminRate],0)!=isnull(S.[GroupAdminRate],0)
					OR isnull(T.[HedgePercent],0)!=isnull(S.[HedgePercent],0)
					OR isnull(T.[HedgePercentMCPS],0)!=isnull(S.[HedgePercentMCPS],0)
					OR isnull(T.[PRAdminRate],0)!=isnull(S.[PRAdminRate],0)
					OR isnull(T.[IsExcluded],0)!=isnull(S.[IsExcluded],0)

					OR isnull(T.[FPVStatus],'') != isnull(S.[FPVStatus],'')
--Added 2018AUG22
			
					OR isnull(T.[StationStatus],'')!=isnull(S.[StationStatus],'')
	--Added 2018SEP04
					OR isnull(T.[AudioPolicyMain],'')!=isnull(S.[AudioPolicyMain],'')
					OR isnull(T.[AudioPolicyCommercial],'')!=isnull(S.[AudioPolicyCommercial],'')
					OR isnull(T.[CommercialSampleDays],0)!=isnull(S.[CommercialSampleDays],0)
					OR isnull(T.[NonCommercialSampleDays],0)!=isnull(S.[NonCommercialSampleDays],0)
					OR isnull(T.[TotalSampleDays],0)!=isnull(S.[TotalSampleDays],0)
	--Added 2018SEP19
					OR isnull(T.[MinimumFee],0)!=isnull(S.[MinimumFee],0)
					OR isnull(T.[BroadcastHours],0)!=isnull(S.[BroadcastHours],0)
	--Added 2018OCT16
					OR isnull(T.LicenceFeeSplitPercent,0)!=isnull(S.LicenceFeeSplitPercent,0)
	--Added 2019FEB18
					OR isnull(T.RegionalParentStationFlag,'')!=isnull(S.RegionalParentStationFlag,'')
					OR isnull(T.RegionalParentStationId,'')!=isnull(S.RegionalParentStationId,'')
					OR isnull(T.RegionalWeightingPRS,0)!=isnull(S.RegionalWeightingPRS,0)
					OR isnull(T.RegionalWeightingMCPS,0)!=isnull(S.RegionalWeightingMCPS,0)
						OR isnull(T.[UpdatedBy],'') != isnull(S.[UpdatedBy],'')
						OR isnull(T.[UpdateComment],'') != isnull(S.[UpdateComment],'')
THEN UPDATE
SET [GroupAdminRate]=S.[GroupAdminRate],
	[HedgePercent]=S.[HedgePercent],
	[HedgePercentMCPS]=S.[HedgePercentMCPS],
	[PRAdminRate]=S.[PRAdminRate],
	[IsExcluded]=S.[IsExcluded],

	[FPVStatus]=S.[FPVStatus],
	--Added 2018AUG22

	[StationStatus]=S.[StationStatus],
	--Added 2018SEP04
	[AudioPolicyMain]=S.[AudioPolicyMain],
	[AudioPolicyCommercial]=S.[AudioPolicyCommercial],
	[CommercialSampleDays]=S.[CommercialSampleDays],
	[NonCommercialSampleDays]=S.[NonCommercialSampleDays],
	[TotalSampleDays]=S.[TotalSampleDays],
	--Added 2018SEP19
	[MinimumFee]=S.[MinimumFee],
	[BroadcastHours]=S.[BroadcastHours],
	--Added 2018OCT16
	LicenceFeeSplitPercent=S.LicenceFeeSplitPercent,
	--Added 2019FEB18
	RegionalParentStationFlag=S.[RegionalParentStationFlag],	
	RegionalParentStationId=S.[RegionalParentStationId],
	RegionalWeightingPRS=S.[RegionalWeightingPRS],
	RegionalWeightingMCPS=S.[RegionalWeightingMCPS],

	[UpdatedBy]=S.[UpdatedBy],
	[UpdateComment]=S.[UpdateComment]

WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupStation]
OUTPUT DELETED.StationID INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND	[DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','Station Updates',@datarowcount)
END
GO

