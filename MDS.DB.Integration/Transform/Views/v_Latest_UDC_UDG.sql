
CREATE view [Transform].[v_Latest_UDC_UDG]
as

WITH stg_udc_udgs AS
(
SELECT top 100 percent udg.*,
       ROW_NUMBER()
       OVER(PARTITION BY DC_SURR_ID ORDER BY TARGET_DISTRIBUTION_DATE DESC) rn
  FROM [Clean].[Usage_Distribution_Groups] udg
 ORDER BY DC_SURR_ID ASC, rn ASC 
)

SELECT distinct *
  FROM stg_udc_udgs
 WHERE rn = 1