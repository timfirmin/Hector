

CREATE VIEW [Clean].[v_RightType]
AS
SELECT 
  CHECKSUM(RV_LOW_VALUE,RV_MEANING) as RightTypeKey,
  [RV_LOW_VALUE] as RightTypeCode, 
  [RV_MEANING] as RightTypeName 

FROM  [Clean].[CG_Ref_Codes] 
WHERE [RV_DOMAIN] = 'RIGHT_TYPE'
     AND RejectRow_YN = 'N'

