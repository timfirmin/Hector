﻿CREATE PROCEDURE [Reporting].[ObtainMDSMasterStationValidationSummary] 
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

  SELECT COUNT(*) as Total , station_rules.RuleType
  FROM
    station_rules
  LEFT OUTER JOIN validations ON
    validations.Code = station_rules.Code AND
    validations.RuleId = station_rules.RuleId
	WHERE validations.RuleId IS NOT NULL
	GROUP BY station_rules.RuleType


  ;
END

GO