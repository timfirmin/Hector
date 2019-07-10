






CREATE View [Clean].[v_MasterStationData]
AS

WITH AllPrimaryData AS

(
-- Add any addional data sources for Stations here e.g. Rep, CRM etc 
-- Large Set of Field Removals 2019MAR27
select 
  CHECKSUM(bro.STATION_ID,bro.DN_TP_NAME,dom.NAME,mlt.NAME,brt.RIGHT_TYPE,'GB') as BroadcasterKey,
  RTRIM(LTRIM(bro.STATION_ID)) as 'BroadcasterCode', -- StationId,   --REP.Broadcaster.STATION_ID
  RTRIM(LTRIM(bro.DN_TP_NAME))  as 'BroadcasterName', --REP.Broadcaster.DN_TP_NAME
  --null							as 'InceptionDate',
  --RTRIM(LTRIM(dom.NAME))        as 'DomainName',   --REP.Elementary_Territories.ABBREV
  --RTRIM(LTRIM(bba.[LicenceGroup]))		as 'LicenceGroup',     --REP_WH.fact_bro_attributes.LicenceGroup
 -- RTRIM(LTRIM(bba.[MusicReportingGroup]))		as 'MusicReportingGroup',  --REP_WH.fact_bro_attributes.MusicReportingGroup
  --RTRIM(LTRIM(bba.[KeyAccountGroup]))		as 'KeyAccountGroup',  --REP_WH.fact_bro_attributes.KeyAccountGroup	
  --RTRIM(LTRIM(mlt.NAME))        as 'MCPSLicenceTypeCode',  --REP.MCPS_Licence_Types.NAME
  null							as 'LicencedStatus',
  --null							as 'StatusEffectiveDate',
  --ISNULL(elt.ABBREV,'GB')       as 'TerritoryCode',  --REP.Elementary_Territories.ABBREV
  RTRIM(LTRIM(brt.RIGHT_TYPE))  as 'RightTypeCode',   --REP.Broadcaster_Right_Types.RIGHT_TYPE
  --null							as 'LowRevenue',
  --null							as 'CurrentLicenceFee',
  tp.finance_code				as 'CustomerAccountNo'
  --bro.ALLUK_CUSTOMER_ACCOUNT_NO  as 'CustomerAccountNo',
  --'REP'							as 'DataSource' 
from  [Clean].[Broadcasters] bro 
      JOIN [Clean].[Domains] dom on bro.DOM_SURR_ID = dom.SURR_ID
	  --Only Load Where there is a Right Type Code - 2019MAR27
	  JOIN [Clean].[Broadcaster_Right_Types] brt on (brt.BRO_TP_SURR_ID = bro.TP_SURR_ID and GETDATE() between brt.EFFECTIVE_FROM_DATE and ISNULL(brt.EFFECTIVE_TO_DATE,cast('01/01/9999' as datetime))) 
	  LEFT OUTER JOIN [Clean].[Broadcaster_MCPS_Licence_Types] bmlt on (bmlt.BRO_TP_SURR_ID = bro.TP_SURR_ID  and GETDATE() between bmlt.EFFECTIVE_FROM_DATE and ISNULL(bmlt.EFFECTIVE_TO_DATE,cast('01/01/9999' as datetime))) 
	  LEFT OUTER JOIN [Clean].[MCPS_Licence_Types] mlt on (bmlt.MLTY_SURR_ID = mlt.SURR_ID) 
	  --LEFT OUTER JOIN [Clean].[Elementary_Territories] elt on (bro.ELT_CODE = elt.CODE) 
	  --LEFT OUTER JOIN [Clean].[v_BroadcasterAttributes] bba on (bro.STATION_ID = bba.[StationId]) 
	  LEFT OUTER JOIN [Clean].[Third_Parties] tp on bro.tp_surr_id = tp.SURR_ID




--This logic removed - attempts to just include only valid, non-ceased, active stations..
--where exists (select null 
--              from [Clean].broadcaster_udcs budc       
--              join [Clean].usage_distribution_codes udc on (budc.dc_surr_id = udc.surr_id)  
--              where budc.bro_tp_surr_id = bro.tp_surr_id 
--                and budc.end_date is null 
--                and udc.inactive_date is null) 
  AND bro.RejectRow_YN = 'N'


)

SELECT 
A.BroadcasterKey,
A.BroadcasterCode,		
UPPER(A.BroadcasterName) as 'BroadcasterName',
--A.InceptionDate,
--A.DomainName,
--UPPER(A.LicenceGroup) as 'LicenceGroup',
--A.MusicReportingGroup as 'MusicReportingGroup', 
--A.MCPSLicenceTypeCode,
A.LicencedStatus,
--cast(A.StatusEffectiveDate as date) as StatusEffectiveDate,
--A.TerritoryCode,
A.RightTypeCode,
--A.LowRevenue,
--A.CurrentLicenceFee,
--A.DataSource,
A.CustomerAccountNo,

'P' as DataSourceType 
FROM AllPrimaryData A
GO

