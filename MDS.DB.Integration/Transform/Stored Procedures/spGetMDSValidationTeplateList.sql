CREATE PROCEDURE [Transform].[spGetMDSValidationTeplateList]
 @LoadId as bigint
AS

SELECT  Value as Template,count(V.RuleId) NumberOfValidationFailuers
              FROM [Transform].[v_MDSMasterStationValidation] V INNER JOIN
                   [Config].[MDSBusinessRules] C  ON C.RuleId = V.RuleId
				    CROSS APPLY STRING_SPLIT(NotificationTemplate, ',') 
WHERE LoadId = @LoadId
GROUP BY Value