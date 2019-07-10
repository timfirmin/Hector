 
--=============================================
-- TJF 2019APR30 Return   First Station ID from a CodaCustomerCode
-- Test : SELECT  [CodaCustomerCode] , [FPV].[udfGetStationID] ([CodaCustomerCode]) as SID FROM [staging].[MasterStation]
-- SELECT TOP(1) [StationID] FROM [FPV].[MasterStation] WHERE [CodaCustomerCode] = 'CCHAN0004'
-- =============================================
CREATE FUNCTION [FPV].[udfGetStationID] 
(
	-- Add the parameters for the function here
	@CodaCustomerCode nvarchar(10) 
)
RETURNS nvarchar(10) 
AS
BEGIN
 
	DECLARE @StationID  nvarchar(10) 
    SELECT TOP(1) @StationID =  [StationID] FROM [FPV].[MasterStation] WHERE [CodaCustomerCode] = @CodaCustomerCode
	
	RETURN @StationID

END