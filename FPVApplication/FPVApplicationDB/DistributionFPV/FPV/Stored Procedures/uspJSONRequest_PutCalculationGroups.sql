

CREATE PROC [FPV].[uspJSONRequest_PutCalculationGroups]
@RequestID INT
AS
BEGIN
DECLARE @json NVARCHAR(MAX)
DECLARE @datarowcount INT
DECLARE @merge_output TABLE
(
	[action] varchar(50)
)
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

;WITH CalculationGroupUpdates AS (
SELECT	[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[CalculationGroupStatus]
		,[CalculationPeriodStart]
		,[CalculationPeriodEnd]
		,[UpdatedBy]
		,[UpdateComment]
FROM OPENJSON(@json)
WITH (
		[DistributionGroupCode] varchar(20) '$.DistributionGroupCode'
		,[DistributionCode] varchar(20) '$.DistributionCode' 
		,[Society] varchar(10) '$.Society' 
		,[CalculationGroupStatus] varchar(20) '$.CalculationGroupStatus'
		,[CalculationPeriodStart] datetime '$.CalculationPeriodStart'
		,[CalculationPeriodEnd] datetime '$.CalculationPeriodEnd'
		,[UpdatedBy] varchar(100) '$.UpdatedBy'
		,[UpdateComment] varchar(255) '$.UpdateComment'
	)
)
MERGE [FPV].[CalculationGroup] T
USING (SELECT	[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[CalculationGroupStatus]
		,[CalculationPeriodStart]
		,[CalculationPeriodEnd]
		,[UpdatedBy]
		,[UpdateComment]
		FROM CalculationGroupUpdates) S ([DistributionGroupCode]
										,[DistributionCode]
										,[Society]
										,[CalculationGroupStatus]
										,[CalculationPeriodStart]
										,[CalculationPeriodEnd]
										,[UpdatedBy]
										,[UpdateComment])
ON T.[DistributionGroupCode]=S.[DistributionGroupCode] AND T.[DistributionCode]=S.[DistributionCode] AND T.[Society]=S.[Society]

WHEN NOT MATCHED BY TARGET THEN
INSERT ([DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[CalculationGroupStatus]
		,[CalculationPeriodStart]
		,[CalculationPeriodEnd]
		,[UpdatedBy]
		,[UpdateComment])
VALUES (S.[DistributionGroupCode]
		,S.[DistributionCode]
		,S.[Society]
		,S.[CalculationGroupStatus]
		,S.[CalculationPeriodStart]
		,S.[CalculationPeriodEnd]
		,S.[UpdatedBy]
		,S.[UpdateComment])

WHEN MATCHED AND	T.[CalculationGroupStatus]!=S.[CalculationGroupStatus]
					OR 
					T.[CalculationPeriodStart]!=S.[CalculationPeriodStart]
					OR 
					T.[CalculationPeriodEnd]!= S.[CalculationPeriodEnd]
					OR 
					T.[UpdatedBy]!= S.[UpdatedBy]
					OR
					T.[UpdateComment]!= S.[UpdateComment]
THEN UPDATE 
SET [CalculationGroupStatus]=S.[CalculationGroupStatus]
		,[CalculationPeriodStart]=S.[CalculationPeriodStart]
		,[CalculationPeriodEnd]=S.[CalculationPeriodEnd]
		,[UpdatedBy]=S.[UpdatedBy]
		,[UpdateComment]=S.[UpdateComment]



OUTPUT $action as [action] INTO @merge_output;
SELECT @datarowcount = COUNT([action]) FROM @merge_output;

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
VALUES (@RequestID,'success','CalculationGroup Updates',@datarowcount)

--Get Calculation Group Inserted as Cannot Derive from JSON Put/Get
DECLARE @WorkingDistributionGroupCode VARCHAR(20)
SET @WorkingDistributionGroupCode = (SELECT TOP 1  [DistributionGroupCode] from [FPV].[CalculationGroup] order by [SysStartTime] desc)
DECLARE @WorkingDistributionCode VARCHAR(20)
SET @WorkingDistributionCode = (SELECT TOP 1  [DistributionCode] from [FPV].[CalculationGroup] order by [SysStartTime] desc)
DECLARE @WorkingSociety VARCHAR(20)
SET @WorkingSociety = (SELECT TOP 1  [Society] from [FPV].[CalculationGroup] order by [SysStartTime] desc)

--Now Seed Master into Working Data
EXEC [FPV].[uspSeedCalcGroupStation] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety	 
EXEC [FPV].[uspSeedCalcGroupRevenueGroup] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
EXEC [FPV].[uspSeedCalcGroupAudienceReach] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
EXEC [FPV].[uspSeedCalcGroupMissingMinutes] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
EXEC [FPV].[uspSeedCalcGroupMusicMinutes] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
EXEC [FPV].[uspSeedCalcGroupPublicReception] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--Do NOT Seed Revenue as Master is at Group Level not Station
--EXEC [FPV].[uspSeedCalcGroupRevenue] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
EXEC [FPV].[uspSeedCalcGroupUDC] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 

END