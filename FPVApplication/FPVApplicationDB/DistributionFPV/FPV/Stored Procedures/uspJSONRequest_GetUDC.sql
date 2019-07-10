



create PROC [FPV].[uspJSONRequest_GetUDC]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int

SELECT @data = (SELECT * FROM [FPV].[udfUDCData](@RequestID) FOR JSON PATH, INCLUDE_NULL_VALUES);
SELECT @datarowcount = COUNT(*) from [FPV].[udfUDCData](@RequestID)

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END