CREATE  FUNCTION [staging].[udfValidateCeasedStationUDCs] ()

RETURNS TABLE 
AS
RETURN 
(
SELECT stn.[StationID]
      ,stn.[DistributionGroupCode]
      ,stn.[StationName]
	  ,udc.UDCCode
      ,udc.UDCDescription
	  , 1 as CeasedStationUDC 
  FROM [staging].[vStation] stn
  JOIN [staging].[StationUDCMapping] udc	ON stn.[StationID] = udc.MasterStationId
  where udc.UDCDescription like '%Ceased%' or stn.[StationName]   like '%Ceased%' 
 )