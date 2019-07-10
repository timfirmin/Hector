
CREATE PROCEDURE  [Reporting].[ObtainMDSValidationLicencingReport] 
@LoadId bigint,
@RuleType varchar(50)
AS
BEGIN 
		With  LoadData AS (
				SELECT  LoadId,
				        ProcessDate,
						RuleId,
						Code,
						Name,
						Val 
				FROM [Transform].[v_MDSMasterStationValidation]
				 as S
				UNPIVOT
				(
				   Val  for Vals in 
						(LowRevenue,
						CurrentLicenceFee,
						InceptionDate,
						CommercialSampleDays,
						AudioPolicy,
						MainCommercial,
						SampleDays,
						LicenceGroup					
						)
				) as up  
		)
, 
 AllValidationFailures AS
(		SELECT * 
		FROM LoadData
				
		UNION

		SELECT LoadId,
				        ProcessDate,
						RuleId,
						Code,
						Name,
						null  
		FROM [Transform].[v_MDSMasterStationValidation]
		WHERE RuleId in (1,2,8,10,11,4,12,13,14,15,16,17,18,19,20,21)
		)
		
		SELECT LoadId	,EnitytName	, Code,	Name, Val as Value ,RuleDescription,RuleType 
		FROM AllValidationFailures A
		INNER JOIN [Config].[MDSBusinessRules] BR ON A.RuleId = BR.RuleId
		WHERE  LoadId = @LoadId  and NotificationTemplate like '%MDS Validation Licensing%' And (RuleType = @RuleType OR @RuleType  = '<All>')
		Order by A.Code, A.RuleId
END