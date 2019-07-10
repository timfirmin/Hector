Create view Transform.v_BroadcasterUDCMapping
as
with cte_DraftMeasures
as
(
SELECT distinct dbro.broadcaster_key,
       --isnull(dug.usage_group_key, 0) usage_group_key,
       dudc.usage_distribution_code_key,
       budc.START_DATE AS broadcaster_udc_start_date,
       --         budc.end_date AS broadcaster_udc_end_date,
       budc.PERFORMANCE_START_DATE AS budc_perf_start_date,
       budc.PERFORMANCE_END_DATE AS budc_perf_end_date,
       ludg.SURR_ID AS latest_udg_surr_id,
       ludg.TARGET_DISTRIBUTION_DATE AS latest_udg_distribution_date,
       ludg.PERFORMANCE_START_DATE AS latest_udg_perf_start_date,
       ludg.PERFORMANCE_END_DATE AS latest_udg_perf_end_date,
       isnull(ludg.ACTUAL_VALUE_PER_POINT, ludg.NOTIONAL_VALUE_PER_POINT)
          AS latest_perf_fixed_point_value,
       isnull(ludg.MECHANICAL_PM_ACTUAL_VALUE,
           ludg.MECHANICAL_PM_NOTIONAL_VALUE)
          AS latest_mech_fixed_point_value
  FROM [Transform].[v_UDCBroadcasters] dbro
       JOIN [Clean].[Broadcaster_UDCS] budc
          ON (budc.BRO_TP_SURR_ID = dbro.broadcaster_third_party_id) -- JOIN not LEFT JOIN because from stations query -- only consider stations that have a current broadcaster udc - this is essential for a broadcaster to have usage loaded for it.
       LEFT JOIN [Transform].[v_UsageDistributionCodes] dudc
          ON (dudc.usage_distribution_code_id = budc.DC_SURR_ID)
       LEFT JOIN Transform.v_Latest_UDC_UDG ludg
          ON (ludg.DC_SURR_ID = dudc.usage_distribution_code_id)
       --LEFT JOIN dim_usage_group dug
       --   ON (dug.usage_group_code = dudc.usage_distribution_code)
 WHERE     dudc.udc_inactive_date = '1980-01-01 00:00:00.000' -- only consider active udcs
       AND budc.END_DATE IS NULL -- only consider active budcs NB there cannot be overlapping budcs so this also means that only one row should be presented per station and udc)
)
--cte_DraftMeasures
 SELECT top 100 percent  
		dbro.broadcaster_domain,
         dbro.broadcaster_third_party_id,
         dbro.broadcaster_station_id,
         dbro.broadcaster,
         dudc.udc_used_for_purpose_code,
         dudc.udc_used_for_purpose_desc,
         dudc.udc_time_band_name,
         dudc.usage_distribution_code_key,
         dudc.usage_distribution_code_id,
         dudc.usage_distribution_code,
         dudc.usage_distribution_code_desc,
         fbudc.broadcaster_udc_start_date,
         fbudc.budc_perf_start_date,
         fbudc.budc_perf_end_date,
         fbudc.latest_udg_surr_id,
         fbudc.latest_udg_distribution_date,
         fbudc.latest_udg_perf_start_date,
         fbudc.latest_udg_perf_end_date,
         fbudc.latest_perf_fixed_point_value AS prsrep_perf_fpv_in_pounds,
         fbudc.latest_mech_fixed_point_value AS prsrep_mech_fpv_in_pounds
    FROM cte_DraftMeasures fbudc
         JOIN [Transform].[v_UDCBroadcasters] dbro
            ON (dbro.broadcaster_key = fbudc.broadcaster_key)
         JOIN [Transform].[v_UsageDistributionCodes] dudc
            ON (dudc.usage_distribution_code_key =
                   fbudc.usage_distribution_code_key)
ORDER BY broadcaster_domain,
         broadcaster,
         broadcaster_station_id,
         udc_used_for_purpose_code,
         udc_used_for_purpose_desc,
         udc_time_band_name,
         usage_distribution_code_desc,
         usage_distribution_code
;