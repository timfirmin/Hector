create  FUNCTION [staging].[udfValidateStationUDCExists] ()

RETURNS TABLE 
AS
RETURN 
(
SELECT stn.[StationID]
      ,stn.[DistributionGroupCode]
      ,stn.[StationName]
 
	  ,case when udc.[UDCCode] is null then 1 else 0 end as NoStationUDC 
  FROM [staging].[vStation] stn
  LEFT JOIN [staging].[StationUDCMapping] udc	ON stn.[StationID] = udc.MasterStationId
  where udc.[UDCCode] is null
)