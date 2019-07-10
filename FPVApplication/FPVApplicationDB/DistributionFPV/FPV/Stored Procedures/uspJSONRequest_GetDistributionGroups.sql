
CREATE PROC [FPV].[uspJSONRequest_GetDistributionGroups]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int

SELECT @data = (	SELECT * 
					FROM [FPV].[udfDistributionGroupData](@RequestID)
					FOR JSON PATH, INCLUDE_NULL_VALUES);

SELECT @datarowcount = count(*) from [FPV].[udfDistributionGroupData](@RequestID)

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END