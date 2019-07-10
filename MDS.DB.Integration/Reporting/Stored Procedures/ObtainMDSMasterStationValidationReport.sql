CREATE PROCEDURE [Reporting].[ObtainMDSMasterStationValidationReport] 
  @LoadId bigint
AS BEGIN 
  WITH validations AS
  (
    SELECT 
      Code, 
      RuleId 
    FROM 
      [Transform].[v_MDSMasterStationValidation]
    WHERE
      Code IS NOT NULL AND
      LoadId = @LoadId
  ),
  station_validation AS
  (
    SELECT DISTINCT 
      Code, 
      Name 
    FROM
      [Transform].[v_MDSMasterStationValidation]
    WHERE
      Code IS NOT NULL AND
      LoadId = @LoadId
  ),
  rules AS
  (
    SELECT 
      RuleId, 
      RuleType,
	  RuleDescription 
    FROM
      [Config].[MDSBusinessRules]
    WHERE
      RuleActiveYN = 'Y'
  ),
  station_rules AS
  (
    SELECT
      station_validation.Code,
      station_validation.Name,
      rules.RuleId,
      rules.RuleType,
	  rules.RuleDescription
    FROM
      station_validation
    CROSS JOIN
      rules
  )
  SELECT
    BroadcasterCode = station_rules.Code,
    BroadcasterName = station_rules.Name,
    station_rules.RuleId,
    station_rules.RuleType,	
	station_rules.RuleDescription,
    FailedRule = CASE WHEN validations.RuleId IS NOT NULL THEN 1 ELSE 0 END,
    FailedRuleMessage = CASE 
      WHEN validations.RuleId IS NOT NULL AND LOWER(station_rules.RuleDescription) LIKE '%null%' THEN 'No value'
      WHEN validations.RuleId IS NOT NULL THEN 'Invalid value'
      ELSE 'Valid value'
    END
  FROM
    station_rules
  LEFT OUTER JOIN validations ON
    validations.Code = station_rules.Code AND
    validations.RuleId = station_rules.RuleId
  ;
END

GO