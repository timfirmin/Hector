
create view Transform.v_UDCInvalidDate
as
SELECT DISTINCT
       udc.CODE AS usage_distribution_code,
       isnull(udc.DESCRIPTION, '~Not Supplied') AS usage_distribution_code_desc, -- Yes - there are some UDCs without Descriptions
       isnull(udc.INACTIVE_DATE, '1-Jan-1980') AS udc_inactive_date
  FROM Staging.Usage_Distribution_Codes udc
  WHERE isnull(udc.INACTIVE_DATE, '1-Jan-1980') <> '1-Jan-1980'