
CREATE VIEW [Transform].[v_MDSMasterStationValidation]
AS  
--------------------------------------------------------------------------
--Created By : Senay 2018SEP07 ~ MDS Integration Hector 2 Project
--Last Change : tjf 2017NOV29 Multiple Spelling Mistakes - Licene changed to Licence

  SELECT  
		LoadId,
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
		BroadcasterDomain,
		CodaAccountCodeEl2,
		CodaCustomerCode,
		DistributionGroup,
		Diversity,
		EffectiveDate,
		LicencedStatus,
		MCPSLicenceType,
		MusicReportingGroup,
		PublicReceptionAdminRate,
		RightType,
		StationAdminRate,
		Territory,
		Cast(LogDate  as smalldatetime ) as ProcessDate
   FROM  [Transform].[MDSMasterStationValidated] mds
	   CROSS APPLY OPENJSON([data]) WITH (	[Code]					varchar(200) '$.Code',
											[Name]					varchar(200) '$.Name',
											[LowRevenue]	        varchar(200) '$.LowRevenue',
											[CommercialSampleDays]	varchar(200) '$.CommercialSampleDays',
											[CurrentLicenceFee]		varchar(200) '$.CurrentLicenceFee',
											[InceptionDate]		    varchar(200) '$.InceptionDate',
											[AudioPolicy]		    varchar(200) '$.AudioPolicy',
											[MainCommercial]		varchar(200) '$.MainCommercial',
											[SampleDays]		    varchar(200) '$.SampleDays',
											[LicenceGroup]		    varchar(200) '$.LicenceGroup',
											[BroadcasterDomain]		varchar(200) '$.BroadcasterDomain',
											[CodaAccountCodeEl2]	varchar(200) '$.CodaAccountCodeEl2',
											[CodaCustomerCode]		varchar(200) '$.CodaCustomerCode',
											[DistributionGroup]		varchar(200) '$.DistributionGroup',
											[Diversity]				varchar(200) '$.Diversity',
											[EffectiveDate]			varchar(200) '$.EffectiveDate',
											[LicencedStatus]		varchar(200) '$.LicencedStatus',
											[MCPSLicenceType]		varchar(200) '$.MCPSLicenceType',
											[MusicReportingGroup]	varchar(200) '$.MusicReportingGroup',
											[PublicReceptionAdminRate]	varchar(200) '$.PublicReceptionAdminRate',
											[RightType]				varchar(200) '$.RightType',
											[StationAdminRate]		varchar(200) '$.StationAdminRate',
											[Territory]				varchar(200) '$.Territory'
									  )