CREATE FUNCTION [staging].[udfValidateCODACustomerCode] ()

RETURNS TABLE 
AS
RETURN 
(
SELECT 
	   ms.[StationID]
      ,ms.[DistributionGroupCode]
      ,ms.[StationName]
      ,ms.[CodaCustomerCode]
	  ,1 as [ValidationResult]

  FROM [FPV].[MasterStation] ms
  where [CodaCustomerCode] in
  (
	  SELECT [CodaCustomerCode]
	  FROM [FPV].[MasterStation]
	  WHERE DistributionGroupCode = 'ILR' and [CodaCustomerCode] <> 'Unknown'
	  GROUP BY [CodaCustomerCode]
	  HAVING count([StationID]) > 1
  )
)