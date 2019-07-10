

CREATE PROC [FPV].[uspJSONRequest_PutDistributionGroups]
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

;WITH DistributionGroupCodeUpdates AS (
SELECT	[DistributionGroupCode]
		,[Comment]
FROM OPENJSON(@json)
WITH (	[DistributionGroupCode] varchar(20) '$.DistributionGroupCode'
		,[Comment] varchar(255) '$.Comment'
	)
)
MERGE [FPV].[DistributionGroup] T
USING (SELECT [DistributionGroupCode],[Comment] FROM [DistributionGroupCodeUpdates]) S ([DistributionGroupCode],[Comment])
ON T.[DistributionGroupCode]=S.[DistributionGroupCode]

WHEN NOT MATCHED BY TARGET THEN
INSERT ([DistributionGroupCode],[Comment])
VALUES (S.[DistributionGroupCode],S.[Comment])

WHEN MATCHED AND	T.[Comment]!=S.[Comment]
THEN UPDATE SET [Comment]=S.[Comment]

OUTPUT $action INTO @merge_output;
SELECT @datarowcount=count([action]) FROM @merge_output

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
VALUES (@RequestID,'success','DistributionGroup Updates',@datarowcount)
END