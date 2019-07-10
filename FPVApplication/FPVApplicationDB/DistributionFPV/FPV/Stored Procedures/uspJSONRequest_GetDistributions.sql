
CREATE PROC [FPV].[uspJSONRequest_GetDistributions]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int
SELECT @data = (	SELECT * 
					FROM [FPV].[udfDistributionData](@RequestID)
					FOR JSON PATH, INCLUDE_NULL_VALUES);
SELECT @datarowcount = COUNT(*) FROM [FPV].[udfDistributionData](@RequestID)
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END