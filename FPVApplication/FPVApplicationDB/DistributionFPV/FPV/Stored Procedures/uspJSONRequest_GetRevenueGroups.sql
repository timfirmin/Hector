CREATE PROC [FPV].[uspJSONRequest_GetRevenueGroups]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int

SELECT @data = (	SELECT * 
					FROM [FPV].[udfRevenueGroupData](@RequestID)
					FOR JSON PATH, INCLUDE_NULL_VALUES);
SELECT @datarowcount = COUNT([CodaCustomerCode]) FROM [FPV].[udfRevenueGroupData](@RequestID)
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END
GO

