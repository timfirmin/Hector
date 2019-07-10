 
--=============================================
-- TJF 2019APR30 Return CodaCustomerCode fom a Station ID
-- Test : SELECT  [Code] , [FPV].[udfGetCodaCustomerCode]  ([Code]) as CCC FROM [staging].[MasterStation]
-- =============================================
CREATE FUNCTION [FPV].[udfGetCodaCustomerCode] 
(
	-- Add the parameters for the function here
	@StationID nvarchar(10) 
)
RETURNS nvarchar(10) 
AS
BEGIN
 
	DECLARE @CodaCustomerCode  nvarchar(10) 
    SELECT @CodaCustomerCode = [CodaCustomerCode] FROM [FPV].[MasterStation] WHERE [StationID] = @StationID
	
	RETURN @CodaCustomerCode

END