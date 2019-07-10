CREATE view Transform.v_UDCBroadcasters
as
 

SELECT distinct bro.TP_SURR_ID AS broadcaster_key,
       bro.TP_SURR_ID AS broadcaster_third_party_id,
       bro.STATION_ID AS broadcaster_station_id,
       bro.DN_TP_NAME AS broadcaster,
       dom.SURR_ID AS broadcaster_domain_id,
       dom.NAME AS broadcaster_domain,
       isnull(mlt.NAME, '~Not Supplied') AS bro_mcps_licence_type,
       isnull(mlt.DESCRIPTION, '~Not Supplied') AS bro_mcps_licence_type_desc,
       isnull(brt.RIGHT_TYPE, '~N/S') AS broadcaster_right_type_code,
       CASE
          WHEN brt.RIGHT_TYPE = 'B' THEN 'Both'
          WHEN brt.RIGHT_TYPE = 'P' THEN 'Performing'
          WHEN brt.RIGHT_TYPE = 'M' THEN 'Mechanical'
          ELSE '~Not Supplied'
       END
          AS broadcaster_right_type,
       isnull(elt.CODE, '136') AS broadcaster_territory_code,
       isnull(elt.NAME, 'UNITED KINGDOM') AS broadcaster_territory,
       isnull(elt.ABBREV, 'GB') AS broadcaster_territory_abbrev,
       isnull(elt.TIS_CODE, 826) AS bro_territory_tis_code,
       isnull(tp.FINANCE_CODE, '~Not Supplied') AS broadcaster_finance_code -- doesn't exist on PBIA.prbi_staging table
  FROM Clean.Broadcasters bro
       JOIN Clean.Third_Parties tp ON (tp.SURR_ID = bro.TP_SURR_ID)
       JOIN Clean.[Domains] dom ON (bro.DOM_SURR_ID = dom.SURR_ID)
       LEFT JOIN Clean.Broadcaster_Right_Types brt
          ON (brt.BRO_TP_SURR_ID = bro.TP_SURR_ID)
              AND getdate() BETWEEN brt.EFFECTIVE_FROM_DATE AND isnull(brt.EFFECTIVE_TO_DATE,'31-Dec-2999')
                                     
       LEFT JOIN Clean.Broadcaster_MCPS_Licence_Types bmlt
          ON (bmlt.BRO_TP_SURR_ID = bro.TP_SURR_ID)
              AND getdate() BETWEEN bmlt.EFFECTIVE_FROM_DATE AND isnull(bmlt.EFFECTIVE_TO_DATE,'31-Dec-2999')
       LEFT JOIN Clean.MCPS_Licence_Types mlt
          ON (bmlt.MLTY_SURR_ID = mlt.SURR_ID)
       LEFT JOIN Clean.Elementary_Territories elt
          ON (bro.ELT_CODE = elt.CODE)
 WHERE     dom.NAME IN ('Television', 'Radio') -- Are Agencies and GEOD also included as "Stations"?
       AND EXISTS
              (SELECT NULL -- only consider stations that have a current broadcaster udc - this is essential for a broadcaster to have usage loaded for it.
                 FROM Clean.Broadcaster_UDCS budc
                      JOIN Transform.v_UsageDistributionCodes dudc
                         ON (dudc.usage_distribution_code_id = budc.DC_SURR_ID)
                WHERE     budc.BRO_TP_SURR_ID = bro.TP_SURR_ID
                      AND budc.END_DATE IS NULL
                      ) -- doesn't exist on PBIA.prbi_staging table