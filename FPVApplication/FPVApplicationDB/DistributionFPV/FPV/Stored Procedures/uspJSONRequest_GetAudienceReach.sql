




CREATE PROC [FPV].[uspJSONRequest_GetAudienceReach]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int

SELECT @data = (SELECT * FROM [FPV].[udfAudienceReachData](@RequestID) FOR JSON PATH, INCLUDE_NULL_VALUES);
SELECT @datarowcount = COUNT(*) from [FPV].[udfAudienceReachData](@RequestID)

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END