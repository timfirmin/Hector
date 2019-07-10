 
--=============================================
-- TJF 2019APR30 Return nAME FROM  Station ID
-- Test : SELECT  [StationID] , [FPV].[udfGetStationName] ([StationID]) as SName FROM [FPV].[MasterStation]
-- SELECT  [StationName] FROM [FPV].[MasterStation] WHERE [StationID] = 'CFIVE'
-- =============================================
CREATE FUNCTION [FPV].[udfGetStationName] 
(
	-- Add the parameters for the function here
	@StationId nvarchar(10) 
)
RETURNS nvarchar(10) 
AS
BEGIN
 
	DECLARE @GetStationName  nvarchar(10) 
    SELECT TOP(1) @GetStationName =  [StationName] FROM [FPV].[MasterStation] WHERE [StationID] = @StationId
	
	RETURN @GetStationName

END