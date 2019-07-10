

--=============================================
--Last Change : TJF 2019APR25
--Removed Revenue and Scenario write-back (Revenue field can probably be removed in Get too)
--Remove Station Name and also CodaCustomerCode no longer part of primary key
--Test : EXEC [FPV].[uspJSONRequest_PutRevenue] @RequestID = 65602
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutRevenue]
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
GET THE REVENUE LISTINGS (REQUEST DATA JSON STRING)
SPECIAL CASE - WHEN NO STATIONJ REVENUE RECORDS ARE SUPPLIED IN THE REQUEST DATA 
ACTION: REMOVE ALL REVENUE RECORDS FROM CALCULATION GROUP - DUMMY REVENUE ROW REQUIRED FOR MERGE UPDATE
*********************************************************************************************************/
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

IF (@json IS NOT NULL)
BEGIN

;WITH RevenueUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,
	[StationID], 
	[CodaCustomerCode],
	[CodaCustomerDescription],
	--[Scenario],
	--[StationName],
	--[Revenue],
	--Added 2019MAR08
	[AnnualMusicMinutes],
	[MusicUsage],
	[MusicConsumption],
	[ConsumptionSplit],
	[RevenueApportionment],
	--[CurrentRevenue],
	[TotalRevenueApportionment],
	PercentageSplit,

	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	--[Society]   varchar(10) '$.Society' ,  
	--[DistributionGroupCode] varchar(20) '$.DistributionGroupCode',  
	--[DistributionCode] varchar(20) '$.DistributionCode',  
	[StationID] varchar(20)          '$.StationID', 
	[CodaCustomerCode] varchar(20) '$.CodaCustomerCode',
	[CodaCustomerDescription] varchar(150) '$.CodaCustomerDescription',
	--[Scenario] varchar(50) '$.Scenario',
	--[StationName] varchar(100) '$.StationName',
	--[Revenue] decimal(18,3) '$.Revenue',
	--Added 2019MAR08
	[AnnualMusicMinutes] decimal(18,3) '$.AnnualMusicMinutes',
	[MusicUsage] decimal(18,3) '$.MusicUsage',
	[MusicConsumption] decimal(18,3) '$.MusicConsumption',
	[ConsumptionSplit] decimal(18,3) '$.ConsumptionSplit',
	[RevenueApportionment] decimal(18,3) '$.RevenueApportionment',
	--[CurrentRevenue] decimal(18,3) '$.CurrentRevenue',
	[TotalRevenueApportionment] decimal(18,3) '$.TotalRevenueApportionment',
	PercentageSplit decimal(18,3) '$.PercentageSplit',

	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
--DistributionGrouping AS (
--	SELECT	DISTINCT	
--			COALESCE(f.[Society],u.[Society])[Society]
--			,COALESCE(f.[DistributionGroupCode],u.[DistributionGroupCode])[DistributionGroupCode]
--			,COALESCE(f.[DistributionCode],u.[DistributionCode])[DistributionCode]
--	FROM	RevenueUpdates u, [FPV].[vRequestFilters] f 
--	WHERE	f.RequestID=@RequestID
--),
MergeTarget AS (
SELECT [Society],  
	[DistributionGroupCode],  
	[DistributionCode],
	[StationID], 
	[CodaCustomerCode],
	[CodaCustomerDescription],
	--[Scenario],
	--[StationName],
	--[Revenue],
	--Added 2019MAR08
	[AnnualMusicMinutes],
	[MusicUsage],
	[MusicConsumption],
	[ConsumptionSplit],
	[RevenueApportionment],
	--[CurrentRevenue],
	[TotalRevenueApportionment],
	PercentageSplit,

	[UpdatedBy],
	[UpdateComment] 
FROM	[FPV].[CalculationGroupRevenue] s
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
				[DistributionGroupCode],  
				[DistributionCode],
				[StationID], 
				[CodaCustomerCode],
				[CodaCustomerDescription],
				--[Scenario],
				--[StationName],
				--[Revenue],
				--Added 2019MAR08
				[AnnualMusicMinutes],
				[MusicUsage],
				[MusicConsumption],
				[ConsumptionSplit],
				[RevenueApportionment],
				--[CurrentRevenue],
				[TotalRevenueApportionment],
				PercentageSplit,

				[UpdatedBy],
				[UpdateComment] 
		FROM RevenueUpdates) S ([Society],  
								[DistributionGroupCode],  
								[DistributionCode],
								[StationID], 
								[CodaCustomerCode],
								[CodaCustomerDescription],
								--[Scenario],
								--[StationName],
								--[Revenue],
								--Added 2019MAR08
								[AnnualMusicMinutes],
								[MusicUsage],
								[MusicConsumption],
								[ConsumptionSplit],
								[RevenueApportionment],
								--[CurrentRevenue],
								[TotalRevenueApportionment],
								[PercentageSplit],
								[UpdatedBy],
								[UpdateComment] )
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[StationID]=S.[StationID]
	--AND
	--T.[CodaCustomerCode]=S.[CodaCustomerCode]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
		[DistributionGroupCode],  
		[DistributionCode],
		[StationID], 
		[CodaCustomerCode],
		[CodaCustomerDescription],
		--[Scenario],
		--[StationName],
		--[Revenue],
		--Added 2019MAR08
		[AnnualMusicMinutes],
		[MusicUsage],
		[MusicConsumption],
		[ConsumptionSplit],
		[RevenueApportionment],
		--[CurrentRevenue],
		[TotalRevenueApportionment],
		PercentageSplit,
		[UpdatedBy],
		[UpdateComment] )
VALUES (
	S.[Society],  
	S.[DistributionGroupCode], 
	S.[DistributionCode], 

	S.[StationID], 
	S.[CodaCustomerCode],
	S.[CodaCustomerDescription],
	--S.[Scenario],
	--S.[StationName],
	--S.[Revenue],
	--Added 2019MAR08
	S.[AnnualMusicMinutes],
	S.[MusicUsage],
	S.[MusicConsumption],
	S.[ConsumptionSplit],
	S.[RevenueApportionment],
	--S.[CurrentRevenue],
	S.[TotalRevenueApportionment],
	S.[PercentageSplit],
	S.[UpdatedBy],
	S.[UpdateComment])
WHEN MATCHED AND	
		--isnull(T.[Revenue],0)!=isnull(S.[Revenue],0) OR 
					isnull(T.[AnnualMusicMinutes],0)!=isnull(S.[AnnualMusicMinutes],0)
					OR isnull(T.[MusicUsage],0)!=isnull(S.[MusicUsage],0)
					OR isnull(T.[MusicConsumption],0)!=isnull(S.[MusicConsumption],0)
					OR isnull(T.[ConsumptionSplit],0)!=isnull(S.[ConsumptionSplit],0)
					OR isnull(T.[RevenueApportionment],0)!=isnull(S.[RevenueApportionment],0)
					--OR isnull(T.[CurrentRevenue],0)!=isnull(S.[CurrentRevenue],0)
					OR isnull(T.[TotalRevenueApportionment],0)!=isnull(S.[TotalRevenueApportionment],0)
					OR isnull(T.[PercentageSplit],0)!=isnull(S.[PercentageSplit],0)
					OR isnull(T.[UpdatedBy],'') != isnull(S.[UpdatedBy],'')
					OR isnull(T.[UpdateComment],'') != isnull(S.[UpdateComment],'')
THEN UPDATE
SET --[Revenue]=S.[Revenue],
		[AnnualMusicMinutes]=S.[AnnualMusicMinutes],
		[MusicUsage]=S.[MusicUsage],
		[MusicConsumption]=S.[MusicConsumption],
		[ConsumptionSplit]=S.[ConsumptionSplit],
		[RevenueApportionment]=S.[RevenueApportionment],
		--[CurrentRevenue]=S.[CurrentRevenue],
		[TotalRevenueApportionment]=S.[TotalRevenueApportionment],
		[PercentageSplit]=S.[PercentageSplit],
		[UpdatedBy]=S.[UpdatedBy],
		[UpdateComment]=S.[UpdateComment]

WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupRevenue]
OUTPUT DELETED.StationID INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND	[DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','Revenue Updates',@datarowcount)
END
GO

