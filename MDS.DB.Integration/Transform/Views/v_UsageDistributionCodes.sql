--dim_usage_distribution_code 
CREATE VIEW Transform.[v_UsageDistributionCodes]
AS
SELECT DISTINCT
       udc.SURR_ID AS usage_distribution_code_key,
       udc.SURR_ID AS usage_distribution_code_id,
       udc.CODE AS usage_distribution_code,
       isnull(udc.DESCRIPTION, '~Not Supplied') AS usage_distribution_code_desc, -- Yes - there are some UDCs without Descriptions
       isnull(udc.INACTIVE_DATE, '1-Jan-1980')
          AS udc_inactive_date,    -- doesn't exist on PBIA.prbi_staging table
       budc.USED_FOR_PURPOSE AS udc_used_for_purpose_code,
       isnull(cgu.RV_MEANING, '~Not Supplied') AS udc_used_for_purpose_desc,
       isnull(budc.BND_SURR_ID, 0) AS udc_time_band_id,
       isnull(bnd.NAME, '~Not Supplied') AS udc_time_band_name
  FROM Staging.Usage_Distribution_Codes udc
       LEFT JOIN Staging.Broadcaster_UDCS budc
          ON (budc.DC_SURR_ID = udc.SURR_ID)
       LEFT JOIN Staging.CG_Ref_Codes cgu
          ON (    cgu.RV_DOMAIN = 'USED_FOR_PURPOSE'
              AND cgu.RV_LOW_VALUE = budc.USED_FOR_PURPOSE)
       LEFT JOIN Staging.Peak_Bands bnd ON (bnd.SURR_ID = budc.BND_SURR_ID)
 WHERE     udc.USAGE_TYPE IN ('A', 'AV')
       AND udc.CODE NOT IN ('CS065', 'CS066', 'D1376') -- udcs used for more than one purpose, see UDC Profiling
       AND udc.CODE NOT IN ('C0477', 'GE47')