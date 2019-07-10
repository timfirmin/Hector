
CREATE VIEW [Clean].[v_SuppliedStationData]
AS

WITH AllSecondaryData AS

(
-- Add any addional data sources here e.g. Rep, Barb , CRM etc
--CRM REmoved 2019MAR15

-- Add any addional data sources here e.g. Rep, Barb etc 

	SELECT
		RTRIM(LTRIM(bro.station_id )) as 'SuppliedStationId',
		RTRIM(LTRIM(bro.dn_tp_name))  as 'SuppliedStationName',
		'Rep'						  as 'DataSource',
		bro.RejectRow_YN		      as 'RejectRow'
	FROM [Clean].[Broadcasters] bro 
      JOIN [Clean].[Domains] dom on bro.dom_surr_id = dom.surr_id
	  LEFT OUTER JOIN [Clean].[Broadcaster_Right_Types] brt on (brt.bro_tp_surr_id = bro.tp_surr_id and GETDATE() between brt.effective_from_date and ISNULL(brt.effective_to_date,cast('01/01/9999' as datetime))) 
	  LEFT OUTER JOIN [Clean].[Broadcaster_MCPS_Licence_Types] bmlt on (bmlt.bro_tp_surr_id = bro.tp_surr_id  and GETDATE() between bmlt.effective_from_date and ISNULL(bmlt.effective_to_date,cast('01/01/9999' as datetime))) 
	  LEFT OUTER JOIN [Clean].[MCPS_Licence_Types] mlt on (bmlt.mlty_surr_id = mlt.surr_id) 
	  LEFT OUTER JOIN [Clean].[Elementary_Territories] elt on (bro.elt_code = elt.code) 
	WHERE exists (SELECT null 
				  FROM [Clean].broadcaster_udcs budc       
				  JOIN [Clean].usage_distribution_codes udc on (budc.dc_surr_id = udc.surr_id)  
				  WHERE budc.bro_tp_surr_id = bro.tp_surr_id 
				  AND budc.end_date is null 
				  AND udc.inactive_date is null
				  ) 

	UNION
	SELECT 
		CAST(SuppliedStationId AS VARCHAR),
		SuppliedStationName,
		DataSource,
		RejectRow
	FROM 
		[$(AudienceMart)].[AudienceMart].[vwSuppliedStationRAJAR]
	UNION
	SELECT 
		SuppliedStationId,
		SuppliedStationName,
		DataSource,
		RejectRow
	FROM 
		[$(AudienceMart)].[AudienceMart].[vwSuppliedStationBARB]

)

SELECT A.SuppliedStationId
		,A.SuppliedStationName
		,A.DataSource
FROM AllSecondaryData A
INNER JOIN Config.MDSDataSourceConfiguration M ON A.[DataSource] = M.DataSource
WHERE M.DataSourceType = 'S'
AND RejectRow = 'N'