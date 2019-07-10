

 
CREATE VIEW [Transform].[v_MDSMasterStationValidation]
AS  


  SELECT  LoadId,
		RuleId,
		Code,
		Name,
		LowRevenue,
		CurrentLicenceFee,
		InceptionDate,
		CommercialSampleDays,
		AudioPolicy,
		MainCommercial,
		SampleDays,
		LiceneGroup,
		Cast(LogDate  as smalldatetime ) as ProcessDate
   FROM  [Transform].[MDSMasterStationValidated]
       CROSS APPLY OPENJSON(data) WITH (	 [Code]					varchar(200) '$.Code',
                                             [Name]					varchar(200) '$.Name',
									         [LowRevenue]	        varchar(200) '$.LowRevenue',
									         [CommercialSampleDays]	varchar(200) '$.CommercialSampleDays',
									 [CurrentLicenceFee]		    varchar(200) '$.CurrentLicenceFee',
									 [InceptionDate]		    varchar(200) '$.InceptionDate',
									 [AudioPolicy]		        varchar(200) '$.AudioPolicy',
									 [MainCommercial]		        varchar(200) '$.MainCommercial',
									 [SampleDays]		        varchar(200) '$.SampleDays',
									 [LiceneGroup]		        varchar(200) '$.LiceneGroup'
									  )