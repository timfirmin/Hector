CREATE  FUNCTION [staging].[udfValidateStationUDCCounts] ()

RETURNS TABLE 
AS
RETURN 
(
with cte_groups as 
(
  SELECT 
	   stn.[StationID]
      ,stn.[StationName]
      ,stn.[DistributionGroupCode] as DistributionGroupCategory
	  ,count([StationUDCCode]) as UDCCount

  FROM [staging].[vStation] stn
  LEFT JOIN (select * from [staging].[StationUDCMapping] where [MappingStatusFlag] = 'Yes') udc	ON stn.[StationID] = udc.MasterStationId
 
	group by
	   stn.[StationID]
      ,stn.[DistributionGroupCode]
      ,stn.[StationName]

),  cte_counts as
(   
  SELECT 
		 [StationID]
		,[StationName]
		,DistributionGroupCategory
		,UDCCount
		,case when DistributionGroupCategory = 'AV Television' and UDCCount in (2,3,4,6) then 1 else 0 end as ValidUDC01
		,case when DistributionGroupCategory = 'BBC Television' and UDCCount in (3,6) then 1 else 0 end as ValidUDC02
		,case when DistributionGroupCategory = 'ILR Radio' and  UDCCount in (2) then 1 else 0 end as ValidUDC03 
		,case when DistributionGroupCategory = 'BBC Radio' and UDCCount in (1) then 1 else 0 end as ValidUDC04
		,0 as ValidUDC05
		,0 as ValidUDC06

	  from
	  cte_groups
)
select 
		 [StationID]
		,[StationName]
		,[DistributionGroupCategory]
		,[UDCCount]
		 from cte_counts 
		 where  ValidUDC01 + ValidUDC02 + ValidUDC03 + ValidUDC04 + ValidUDC05 + ValidUDC06 <> 1
		 and [UDCCount] <> 0
)