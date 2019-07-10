






CREATE PROC [FPV].[uspJSONRequest_GetStations]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int

SELECT @data = (	SELECT * 
					FROM [FPV].[udfStationData](@RequestID)
					FOR JSON PATH, INCLUDE_NULL_VALUES);
SELECT @datarowcount = COUNT([StationID]) FROM [FPV].[udfStationData](@RequestID)
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[DataRowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END