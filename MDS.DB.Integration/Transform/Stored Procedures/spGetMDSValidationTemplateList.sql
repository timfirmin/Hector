--------------------------------------------------------------------------
--Created By : Senay 2018SEP07 ~ MDS Integration Hector 2 Project
--Unpack JSON Columns in v_MDSMasterStationValidation
--Last Change : tjf 2018NOV29 Multiple Spelling Mistakes - UDF not matching JSON, Template and Failures Spelt Wrong
--Last Change : tjf 2018NOV29 Sproc WAS spGetMDSValidationTeplateList
--Last Change : tjf 2019MAR12 Added Rule Active Flag
--Test001 SingleUser : EXEC [Transform].[spValidateMDSMasterStation] @LoadId=101517
--------------------------------------------------------------------------
CREATE PROCEDURE [Transform].[spGetMDSValidationTemplateList]
 @LoadId as bigint
AS

SELECT  Value as Template,count(Distinct V.Code) NumberOfValidationFailures
              FROM [Transform].[v_MDSMasterStationValidation] V INNER JOIN
                   [Config].[MDSBusinessRules] C  ON C.RuleId = V.RuleId
				    CROSS APPLY STRING_SPLIT(NotificationTemplate, ',') 
WHERE LoadId = @LoadId AND C.RuleActiveYN = 'Y'
GROUP BY Value
GO

