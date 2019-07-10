IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Transform].[v_MDSMasterStationValidation]'))
EXEC dbo.sp_executesql @statement = N'
create VIEW [Transform].[v_MDSMasterStationValidation]
AS  
--------------------------------------------------------------------------
--Created By : Senay 2018SEP07 ~ MDS Integration Hector 2 Project
--Last Change : tjf 2017NOV29 Multiple Spelling Mistakes - Licene changed to Licence

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
		LicenceGroup,
		Cast(LogDate  as smalldatetime ) as ProcessDate
   FROM  [Transform].[MDSMasterStationValidated]
       CROSS APPLY OPENJSON(data) WITH (	 [Code]					varchar(200) ''$.Code'',
                                             [Name]					varchar(200) ''$.Name'',
									         [LowRevenue]	        varchar(200) ''$.LowRevenue'',
									         [CommercialSampleDays]	varchar(200) ''$.CommercialSampleDays'',
									 [CurrentLicenceFee]		    varchar(200) ''$.CurrentLicenceFee'',
									 [InceptionDate]		    varchar(200) ''$.InceptionDate'',
									 [AudioPolicy]		        varchar(200) ''$.AudioPolicy'',
									 [MainCommercial]		        varchar(200) ''$.MainCommercial'',
									 [SampleDays]		        varchar(200) ''$.SampleDays'',
									 [LicenceGroup]		        varchar(200) ''$.LicenceGroup''
									  )	
' 
GO