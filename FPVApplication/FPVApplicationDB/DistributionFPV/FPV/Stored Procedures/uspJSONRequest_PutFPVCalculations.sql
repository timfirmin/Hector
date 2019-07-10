







CREATE PROC [FPV].[uspJSONRequest_PutFPVCalculations]
@RequestID INT
AS
BEGIN
DECLARE @json NVARCHAR(MAX)
DECLARE @DistributionGroupCode VARCHAR(20)
DECLARE @DistributionCode VARCHAR(20)
DECLARE @Society VARCHAR(10)
DECLARE @UpdateComment VARCHAR(255)
DECLARE @UpdatedBy VARCHAR(100)
DECLARE @datarowcount INT=0
DECLARE @eventID INT

/*****************************************************************************************************
INSERT NEW EVENT
*****************************************************************************************************/
SELECT @DistributionGroupCode=[DistributionGroupCode]
		,@DistributionCode=[DistributionCode]
		,@Society=[Society]
		,@UpdateComment=[UpdateComment]
		,@UpdatedBy=[UpdatedBy]
FROM [FPV].[vRequestFilters] WHERE [RequestID]=@RequestID

INSERT [FPV].[FPVCalculationEvent]([DistributionGroupCode],[DistributionCode],[Society],[SysDateTime],[Comment],[UpdatedBy])
VALUES (@DistributionGroupCode,@DistributionCode,@Society,GETDATE(),@UpdateComment,@UpdatedBy)
SELECT @eventID = SCOPE_IDENTITY();
/****************************************************************************************************/

/*****************************************************************************************************
INSERT FPV CALCULATIONS
*****************************************************************************************************/
SELECT @json = [RequestData] FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID

IF (@json IS NOT NULL)
BEGIN

;WITH CalculationUpdates AS (
SELECT [StationID], 
	[CalculationValue],
	[CalculationStatus],
	[CalculationDef],
	[UpdatedBy],
	[UpdateComment] 
FROM OPENJSON ( @json )  
WITH (   
	[StationID] varchar(20)          '$.StationID', 
	[CalculationValue] decimal(18,3) '$.CalculationValue',
	[CalculationStatus] varchar(20)  '$.CalculationStatus',
	[CalculationDef] varchar (100) '$.CalculationDef',
	[UpdatedBy] varchar(100) '$.UpdatedBy',
	[UpdateComment] varchar(255) '$.UpdateComment'
 ) 
)

INSERT [FPV].[FPVCalculation]([FPVCalculationEventID],[StationID],[FPVCalculationDefID],[CalculationValue],[CalculationStatus],[SysCalcTime],[UpdateComments],[UpdatedBy])
SELECT @eventID
		,c.[StationID]
		,d.[FPVCalculationDefID]
		,c.[CalculationValue]
		,c.[CalculationStatus]
		,GETDATE()
		,c.[UpdateComment]
		,c.[UpdatedBy]
FROM CalculationUpdates c
JOIN [FPV].[FPVCalculationDef] d on d.CalculationName=c.[CalculationDef]
SELECT @datarowcount=@@ROWCOUNT
END 

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success','Revenue Updates',@datarowcount)
END