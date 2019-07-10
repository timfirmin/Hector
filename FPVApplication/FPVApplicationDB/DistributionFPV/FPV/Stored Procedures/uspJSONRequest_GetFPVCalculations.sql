﻿



CREATE PROC [FPV].[uspJSONRequest_GetFPVCalculations]
@RequestID INT
AS
BEGIN
DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int

SELECT @data = (SELECT * FROM [FPV].[udfFPVCalculationData](@RequestID) FOR JSON PATH, INCLUDE_NULL_VALUES);
SELECT @datarowcount = COUNT(*) from [FPV].[udfFPVCalculationData](@RequestID)

INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
VALUES (@RequestID,'success',@data,@datarowcount)
END