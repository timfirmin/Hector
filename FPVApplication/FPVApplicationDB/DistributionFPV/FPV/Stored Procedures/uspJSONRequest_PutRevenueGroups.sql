
 --=============================================
-- Last Change By: TJF 2019APR25 Remove FPVStatus EstimatedPoints  SocietyRevenue
--Removed Revenue and Scenario write-back (Revenue field can probably be removed in Get too)
--Test : EXEC [FPV].[uspJSONRequest_PutRevenueGroups] @RequestID = 65602
--=============================================
CREATE PROC [FPV].[uspJSONRequest_PutRevenueGroups]
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
GET THE LICENCE GROUP LISTINGS (REQUEST DATA JSON STRING)
ACTION: REMOVE ALL LICENCE GROUP FROM CALCULATION GROUP - DUMMY STATION ROW REQUIRED FOR MERGE UPDATE
*********************************************************************************************************/
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

IF (@json IS NOT NULL)
BEGIN

;WITH RevenueGroupUpdates AS (
SELECT 
	@Society as Society,  
	@DistributionCode as DistributionCode,
	@DistributionGroupCode as DistributionGroupCode,

      [CodaCustomerCode],
      [RevenueGroupName],
      [SocietySplitPercent],
      ----[HedgePercent],
      [EstimatedRevenue],
      --[EstimatedPoints],
      ----[HedgedRevenue],
      --[SocietyRevenue],

	  [RingFenceValue],
      [IsExcluded],

	  [RevenueApportionmentMethodPRS],
	  [RevenueApportionmentMethodMCPS],

	--[FPVStatus],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	--[Society]   varchar(10) '$.Society' ,  
	--[DistributionGroupCode] varchar(20) '$.DistributionGroupCode',  
	--[DistributionCode] varchar(20) '$.DistributionCode',  
	
	[CodaCustomerCode] varchar(20)          '$.CodaCustomerCode', 
	[RevenueGroupName] varchar(100) '$.RevenueGroupName',
	[SocietySplitPercent] decimal(18,3) '$.SocietySplitPercent',
	--[HedgePercent] decimal(18,3) '$.HedgePercent',
	[EstimatedRevenue] decimal(18,3) '$.EstimatedRevenue',
	--[EstimatedPoints] decimal(18,3) '$.EstimatedPoints',
	--[HedgedRevenue] decimal(18,3) '$.HedgedRevenue',
	--[SocietyRevenue] decimal(18,3) '$.SocietyRevenue',
	[RingFenceValue] decimal(18,3) '$.RingFenceValue',
	[IsExcluded] bit '$.IsExcluded',

	[RevenueApportionmentMethodPRS] varchar(20)          '$.RevenueApportionmentMethodPRS', 
	[RevenueApportionmentMethodMCPS] varchar(20)          '$.RevenueApportionmentMethodMCPS', 

	--[FPVStatus] varchar(20) '$.FPVStatus',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
),
--DistributionGrouping AS (
--	SELECT	DISTINCT	
--			COALESCE(f.[Society],u.[Society])[Society]
--			,COALESCE(f.[DistributionGroupCode],u.[DistributionGroupCode])[DistributionGroupCode]
--			,COALESCE(f.[DistributionCode],u.[DistributionCode])[DistributionCode]
--	FROM	RevenueGroupUpdates u, [FPV].[vRequestFilters] f 
--	WHERE	f.RequestID=@RequestID
--),
MergeTarget AS (
SELECT   [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
	
      ,[RevenueGroupCode]
      ,[RevenueGroupName]
      ,[SocietySplitPercent]
      --[HedgePercent]
      ,[EstimatedRevenue]
     -- ,[EstimatedPoints]
      --[HedgedRevenue]
      --,[SocietyRevenue]
     -- ,[FPVStatus]
	  ,[RingFenceValue]
      ,[IsExcluded]
 
 	  ,[RevenueApportionmentMethodPRS]
	  ,[RevenueApportionmentMethodMCPS]

		,[UpdatedBy]
		,[UpdateComment]

FROM	[FPV].[CalculationGroupRevenueGroup] s
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
USING (SELECT	[Society] ,  
				[DistributionGroupCode],  
				[DistributionCode],  

				[CodaCustomerCode],
				[RevenueGroupName],
				[SocietySplitPercent],
				--[HedgePercent],
				[EstimatedRevenue],
				--[EstimatedPoints],
				--[HedgedRevenue],
				--[SocietyRevenue],
				[RingFenceValue],
				[IsExcluded],

 	 [RevenueApportionmentMethodPRS],
	 [RevenueApportionmentMethodMCPS],

				--[FPVStatus],
				[UpdatedBy],
				[UpdateComment]

		FROM RevenueGroupUpdates) S ([Society] ,  
						[DistributionGroupCode],  
						[DistributionCode],  

				[CodaCustomerCode],
				[RevenueGroupName],
				[SocietySplitPercent],
				--[HedgePercent],
				[EstimatedRevenue],
				--[EstimatedPoints],
				--[HedgedRevenue],
				--[SocietyRevenue],
				[RingFenceValue],
				[IsExcluded],

 	 [RevenueApportionmentMethodPRS],
	 [RevenueApportionmentMethodMCPS],

						--[FPVStatus],
						[UpdatedBy],
						[UpdateComment])
ON	T.[DistributionGroupCode]=S.[DistributionGroupCode]
	AND
	T.[DistributionCode]=S.[DistributionCode]
	AND
	T.[Society]=S.[Society]
	AND
	T.[RevenueGroupCode]=S.[CodaCustomerCode]

WHEN NOT MATCHED BY TARGET THEN
INSERT ([Society],  
	[DistributionGroupCode],  
	[DistributionCode],  

	[RevenueGroupCode],
	[RevenueGroupName],
	[SocietySplitPercent],
	--[HedgePercent],
	[EstimatedRevenue],
	--[EstimatedPoints],
	--[HedgedRevenue],
	--[SocietyRevenue],
	[RingFenceValue],
	[IsExcluded],

 	 [RevenueApportionmentMethodPRS],
	 [RevenueApportionmentMethodMCPS],

	--[FPVStatus],
	[UpdatedBy],
	[UpdateComment])

VALUES (
	S.[Society],  
	S.[DistributionGroupCode], 
	S.[DistributionCode], 


	S.[CodaCustomerCode],
	S.[RevenueGroupName],
	S.[SocietySplitPercent],
	--[HedgePercent],
	S.[EstimatedRevenue],
	--S.[EstimatedPoints],
	--[HedgedRevenue],
	--S.[SocietyRevenue],
	S.[RingFenceValue],
	S.[IsExcluded],

	S.[RevenueApportionmentMethodPRS],
	S.[RevenueApportionmentMethodMCPS],

	--S.[FPVStatus],
	S.[UpdatedBy],
	S.[UpdateComment])

WHEN MATCHED AND	
					isnull(T.[RevenueGroupName],0)!=isnull(S.[RevenueGroupName],0)
					OR isnull(T.[SocietySplitPercent],0)!=isnull(S.[SocietySplitPercent],0)
					--OR isnull(T.--[HedgePercent],0)!=isnull(S.--[HedgePercent],0)
					OR isnull(T.[EstimatedRevenue],0)!=isnull(S.[EstimatedRevenue],0)
					--OR isnull(T.[EstimatedPoints],0)!=isnull(S.[EstimatedPoints],0)
					--OR isnull(T.--[HedgedRevenue],0)!=isnull(S.--[HedgedRevenue],0)
					--OR isnull(T.[SocietyRevenue],0)!=isnull(S.[SocietyRevenue],0)
					--OR isnull(T.[FPVStatus],'') != isnull(S.[FPVStatus],'')
					OR isnull(T.[RingFenceValue],0) != isnull(S.[RingFenceValue],0)
					OR isnull(T.[IsExcluded],'') != isnull(S.[IsExcluded],'')

					OR isnull(T.[RevenueApportionmentMethodPRS],'') != isnull(S.[RevenueApportionmentMethodPRS],'')
					OR isnull(T.[RevenueApportionmentMethodMCPS],'') != isnull(S.[RevenueApportionmentMethodMCPS],'')

					OR isnull(T.[UpdatedBy],'') != isnull(S.[UpdatedBy],'')
					OR isnull(T.[UpdateComment],'') != isnull(S.[UpdateComment],'')


THEN UPDATE
SET [RevenueGroupName]=S.[RevenueGroupName],
	[SocietySplitPercent]=S.[SocietySplitPercent],
	--[HedgePercent]=S.--[HedgePercent],
	[EstimatedRevenue]=S.[EstimatedRevenue],
	--[EstimatedPoints]=S.[EstimatedPoints],
	--[HedgedRevenue]=S.--[HedgedRevenue],
	--[SocietyRevenue]=S.[SocietyRevenue],
	[RingFenceValue]=S.[RingFenceValue],
	[IsExcluded]=S.[IsExcluded],

	[RevenueApportionmentMethodPRS]=S.[RevenueApportionmentMethodPRS],
	[RevenueApportionmentMethodMCPS]=S.[RevenueApportionmentMethodMCPS],

	--[FPVStatus]=S.[FPVStatus],
	[UpdatedBy]=S.[UpdatedBy],
	[UpdateComment]=S.[UpdateComment]

WHEN NOT MATCHED BY SOURCE AND @withDelete= 1 THEN DELETE

OUTPUT $action INTO @merge_output;

END
ELSE
BEGIN
DELETE [FPV].[CalculationGroupRevenueGroup]
OUTPUT DELETED.[RevenueGroupCode] INTO @merge_output
WHERE [DistributionGroupCode]=@DistributionGroupCode
AND	[DistributionCode]=@DistributionCode
AND [Society]=@Society;
END 

SELECT @datarowcount=count([action]) FROM @merge_output;
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','RevenueGroup Updates',@datarowcount)
END
GO

