/* 
 * This script merges EntityType for Play to Pay application into EntityType table. 
 * Please Ensure that it does not overwrite entityId from other applications (reserverd EI-EntityId)
 */
SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
		(157,	NULL,	3,		1,		0,		N'Dim File',								N'prbidimfile',							N'Oracle Dim_File table',										N'PRBI_DW',				N'DIM_FILE',								N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(158,	NULL,	3,		1,		0,		N'Dim Third Party Tree',					N'prbidimthirdpartytree',				N'Oracle Dim_ThirdPartyTree table',								N'PRBI_DW',				N'DIM_THIRD_PARTY_TREE',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(159,	NULL,	3,		0,		0,		N'Dim Date',								N'prbidimdate',							N'Oracle Dim_Date table',										N'PRBI_DW',				N'DIM_DATE',								N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(160,	NULL,	3,		1,		0,		N'Dim Production',							N'prbidimproduction',					N'Oracle Dim_Production table',									N'PRBI_DW',				N'DIM_PRODUCTION',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(163,	NULL,	3,		1,		0,		N'Dim Broadcaster',							N'prbidimbroadcaster',					N'Oracle Dim_Broadcaster table',								N'PRBI_DW',				N'DIM_BROADCASTER',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(164,	NULL,	3,		1,		0,		N'Dim Usage Of Work Status',				N'prbidimusageofworkstatus',			N'Oracle Dim_Usage_Of_Work_Status table',						N'PRBI_DW',				N'DIM_USAGE_OF_WORK_STATUS',				N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(169,	NULL,	3,		1,		0,		N'Dim Right Type',							N'prbidimrighttype',					N'Oracle Dim_Right_Type table',									N'PRBI_DW',				N'DIM_RIGHT_TYPE',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(172,	NULL,	3,		1,		0,		N'Dim Work',								N'prbidimwork',							N'Oracle Dim_Work table',										N'PRBI_DW',				N'DIM_WORK',								N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(173,	NULL,	3,		1,		0,		N'Dim Transmission Status',					N'prbidimtransmissionstatus',			N'Oracle Dim_Transmission_Status table',						N'PRBI_DW',				N'DIM_TRANSMISSION_STATUS',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(174,	NULL,	3,		1,		0,		N'Dim Usage Distribution Code',				N'prbidimusagedistributioncode',		N'Oracle Dim_Usage_Distribution_Code table',					N'PRBI_DW',				N'DIM_USAGE_DISTRIBUTION_CODE',				N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(178,	NULL,	3,		1,		0,		N'Dim Music Origin',						N'prbidimmusicorigin',					N'Oracle Dim_Music_Origin table',								N'PRBI_DW',				N'DIM_MUSIC_ORIGIN',						N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(179,	NULL,	3,		0,		0,		N'DimRightType',							N'DimRightType',						N'DimRightType table',											N'PipelineWarehouse',	N'DimRightType',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(300,	NULL,	3,		0,		0,		N'DimBroadcaster',							N'DimBroadcaster',						N'Play to Pay DimBroadcaster table',							N'PipelineWarehouse',	N'DimBroadcaster',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(301,	NULL,	3,		0,		0,		N'DimFile',									N'DimFile',								N'Play to Pay DimFile table',									N'PipelineWarehouse',	N'DimFile',									N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(302,	NULL,	3,		0,		0,		N'DimMusicOrigin',							N'DimMusicOrigin',						N'Play to Pay DimMusicOrigin table',							N'PipelineWarehouse',	N'DimMusicOrigin',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(303,	NULL,	3,		0,		0,		N'DimProduction',							N'DimProduction',						N'Play to Pay DimProduction table',								N'PipelineWarehouse',	N'DimProduction',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(304,	NULL,	3,		0,		0,		N'DimThirdPartyTree',						N'DimThirdPartyTree',					N'Play to Pay DimThirdPartyTree table',							N'PipelineWarehouse',	N'DimThirdPartyTree',						N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(305,	NULL,	3,		0,		0,		N'DimTransmissionStatus',					N'DimTransmissionStatus',				N'Play to Pay DimTransmissionStatus table',						N'PipelineWarehouse',	N'DimTransmissionStatus',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(306,	NULL,	3,		0,		0,		N'DimUsageDistributionCode',				N'DimUsageDistributionCode',			N'Play to Pay DimUsageDistributionCode table',					N'PipelineWarehouse',	N'DimUsageDistributionCode',				N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(307,	NULL,	3,		0,		0,		N'DimUsageOfWorkStatus',					N'DimUsageOfWorkStatus',				N'Play to Pay DimUsageOfWorkStatus table',						N'PipelineWarehouse',	N'DimUsageOfWorkStatus',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(308,	NULL,	3,		0,		0,		N'DimWork',									N'DimWork',								N'Play to Pay DimWork table',									N'PipelineWarehouse',	N'DimWork',									N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(309,	NULL,	3,		0,		0,		N'FactUsageOfWork',							N'FactUsageOfWork',						N'Play to Pay FactUsageOfWork table',							N'PipelineWarehouse',	N'FactUsageOfWork',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(310,	NULL,	3,		1,		0,		N'Dim Time',								N'prbidimtime',							N'Oracle Dim_Time table',										N'PRBI_DW',				N'DIM_TIME',								N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(311,	NULL,	3,		0,		0,		N'DimTime',									N'DimTime',								N'Play to Pay DimTime table',									N'PipelineWarehouse',	N'DimTime',									N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(312,	NULL,	3,		1,		1,		N'FactUsageOfWorkPl',						N'prbifactusageofworkpl',				N'Oracle Fact_Usage_Of_Work table',								N'PRBI_DW',				N'FACT_USAGE_OF_WORK_PL',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(313,	NULL,	3,		1,		1,		N'FactUsageOfWorkWl',						N'prbifactusageofworkwl',				N'Oracle Fact_Usage_Of_Work table',								N'PRBI_DW',				N'FACT_USAGE_OF_WORK_WL',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(314,	NULL,	3,		0,		0,		N'TempFactUsageOfWorkExisting',				N'prbitempfactusageofworkexisting',		N'Oracle Fact_Usage_Of_Work table',								N'PipelineTransform',	N'TempFactUsageOfWorkExisting',				N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(315,	NULL,	3,		0,		0,		N'TempFactUsageOfWorkNew',					N'prbitempfactusageofworknew',			N'Oracle Fact_Usage_Of_Work table',								N'PipelineTransform',	N'TempFactUsageOfWorkNew',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(316,	NULL,	3,		0,		0,		N'TempFactUsageOfWorkChanged',				N'prbitempfactusageofworkchanged',		N'Oracle Fact_Usage_Of_Work table',								N'PipelineTransform',	N'TempFactUsageOfWorkChanged',				N'emma.stewart@prsformusic.com',	SYSDATETIME()),			
		(317,	NULL,	3,		1,		0,		N'Dim Role Type',							N'prbidimroletype',						N'Oracle DIM_ROLE_TYPE table',									N'PRBI_DW',				N'DIM_ROLE_TYPE',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(318,	NULL,	3,		1,		0,		N'Dim Ownership Ip',						N'prbidimownershipip',					N'Oracle DIM_OWNERSHIP_IP table',								N'PRBI_DW',				N'DIM_OWNERSHIP_IP',						N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(319,	NULL,	3,		1,		0,		N'Fact Work Ownership Ip',					N'prbifactworkownershipip',				N'Oracle FACT_WORK_OWNERSHIP_IP table',							N'PRBI_DW',				N'FACT_WORK_OWNERSHIP_IP',					N'emma.stewart@prsformusic.com',	SYSDATETIME()),	
		(320,	NULL,	3,		0,		0,		N'DimRoleType',								N'DimRoleType',							N'Play to Pay DimRoleType table',								N'PipelineWarehouse',	N'DimRoleType',								N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(321,	NULL,	3,		0,		0,		N'DimOwnershipIp',							N'DimOwnershipIp',						N'Play to Pay DimOwnershipIp table',							N'PipelineWarehouse',	N'DimOwnershipIp',							N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(322,	NULL,	3,		0,		0,		N'FactWorkOwnershipIp',						N'FactWorkOwnershipIp',					N'Play to Pay FactWorkOwnershipIp table',						N'PipelineWarehouse',	N'FactWorkOwnershipIp',						N'emma.stewart@prsformusic.com',	SYSDATETIME()),
		(324,	NULL,	3,		1,		0,		N'Dim Broadcaster Attributes',				N'prbidimbroadcasterattributes',		N'Oracle Dim Broadcaster Attributes Table',						N'PRBI_DW',				N'DIM_BROADCASTER_ATTRIBUTES',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(325,	NULL,	3,		1,		0,		N'Dim Tune Code Group',						N'prbidimtunecodegroup',				N'Oracle Dim Tune Code Group Table',							N'PRBI_DW',				N'DIM_TUNE_CODE_GROUP',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(326,	NULL,	3,		1,		0,		N'Dim Music Classification',				N'prbidimmusicclassification',			N'Oracle Dim Music Classification Table',						N'PRBI_DW',				N'DIM_MUSIC_CLASSIFICATION',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(327,	NULL,	3,		1,		0,		N'Dim Usage Classification',				N'prbidimusageclassification',			N'Oracle Dim Usage Classification Table',						N'PRBI_DW',				N'DIM_USAGE_CLASSIFICATION',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(328,	NULL,	3,		1,		0,		N'Dim Mech Usage Classification',			N'prbidimmechusageclassification',		N'Oracle Dim Mech Usage Classification Table',					N'PRBI_DW',				N'DIM_MECH_USAGE_CLASSIFICATION',			N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(329,	NULL,	3,		1,		0,		N'Dim MCPS Licence Type',					N'prbidimmcpslicencetype',				N'Oracle Dim MCPS Licence Type Table',							N'PRBI_DW',				N'DIM_MCPS_LICENCE_TYPE',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(330,	NULL,	3,		1,		0,		N'Dim Bro Attribute Purpose   ',			N'prbidimbroattributepurpose',			N'Oracle Dim Bro Attribute Purpose    Table',					N'PRBI_DW',				N'DIM_BRO_ATTRIBUTE_PURPOSE   ',			N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(331,	NULL,	3,		1,		0,		N'Fact Bro Attributes',						N'prbifactbroattributes',				N'Oracle Fact Bro Attributes Table',							N'PRBI_DW',				N'FACT_BRO_ATTRIBUTES',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),	
		(332,	NULL,	3,		1,		0,		N'Fact Bro MCPS Licence Type',				N'prbifactbromcpslicencetype',			N'Oracle Fact Bro MCPS Licence Type Table',						N'PRBI_DW',				N'FACT_BRO_MCPS_LICENCE_TYPE',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(333,	NULL,	3,		1,		0,		N'Fact Bro Right Type',						N'prbifactbrorighttype',				N'Oracle Fact Bro Right Type Table',							N'PRBI_DW',				N'FACT_BRO_RIGHT_TYPE',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(334,	NULL,	3,		1,		0,		N'Fact Tune Code Group',					N'prbifacttunecodegroup',				N'Oracle Fact Tune Code Group Table',							N'PRBI_DW',				N'FACT_TUNE_CODE_GROUP',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(335,	NULL,	3,		1,		0,		N'Dim Ownership CAE Group',					N'prbidimownershipcaegroup',			N'Oracle Dim Ownership CAE Group Table',						N'PRBI_DW',				N'DIM_OWNERSHIP_CAE_GROUP',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(336,	NULL,	3,		1,		0,		N'Fact Ownership CAE Group',				N'prbifactownershipcaegroup',			N'Oracle Fact Ownership CAE Group Table',						N'PRBI_DW',				N'FACT_OWNERSHIP_CAE_GROUP',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(337,	NULL,	3,		1,		0,		N'Fact Bro Sample Date',					N'prbifactbrosampledate',				N'Oracle Fact Bro Sample Date Table',							N'PRBI_DW',				N'FACT_BRO_SAMPLE_DATE',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(338,	NULL,	3,		0,		0,		N'DimBroadcasterAttributes',				N'DimBroadcasterAttributes',			N'Play to Pay Dim Broadcaster Attributes Table',				N'PipelineWarehouse',	N'DimBroadcasterAttributes',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(339,	NULL,	3,		0,		0,		N'DimTuneCodeGroup',						N'DimTuneCodeGroup',					N'Play to Pay Dim Tune Code Group Table',						N'PipelineWarehouse',	N'DimTuneCodeGroup',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(340,	NULL,	3,		0,		0,		N'DimMusicClassification',					N'DimMusicClassification',				N'Play to Pay Dim Music Classification Table',					N'PipelineWarehouse',	N'DimMusicClassification',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(341,	NULL,	3,		0,		0,		N'DimUsageClassification',					N'DimUsageClassification',				N'Play to Pay Dim Usage Classification Table',					N'PipelineWarehouse',	N'DimUsageClassification',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(342,	NULL,	3,		0,		0,		N'DimMechUsageClassification',				N'DimMechUsageClassification',			N'Play to Pay Dim Mech Usage Classification Table',				N'PipelineWarehouse',	N'DimMechUsageClassification',				N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(343,	NULL,	3,		0,		0,		N'DimMCPSLicenceType',						N'DimMCPSLicenceType',					N'Play to Pay Dim MCPS Licence Type Table',						N'PipelineWarehouse',	N'DimMCPSLicenceType',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(344,	NULL,	3,		0,		0,		N'DimBroAttributePurpose',					N'DimBroAttributePurpose',				N'Play to Pay Dim Bro Attribute Purpose Table',					N'PipelineWarehouse',	N'DimBroAttributePurpose',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(345,	NULL,	3,		0,		0,		N'FactBroAttributes',						N'FactBroAttributes',					N'Play to Pay Fact Bro Attributes Table',						N'PipelineWarehouse',	N'FactBroAttributes',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(346,	NULL,	3,		0,		0,		N'FactBroSampleDate',						N'FactBroSampleDate',					N'Play to Pay Fact Bro Sample Date Table',						N'PipelineWarehouse',	N'FactBroSampleDate',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(347,	NULL,	3,		0,		0,		N'FactBroMCPSLicenceType',					N'FactBroMCPSLicenceType',				N'Play to Pay Fact Bro MCPS Licence Type Table',				N'PipelineWarehouse',	N'FactBroMCPSLicenceType',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(348,	NULL,	3,		0,		0,		N'FactBroRightType',						N'FactBroRightType',					N'Play to Pay Fact Bro Right Type Table',						N'PipelineWarehouse',	N'FactBroRightType',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(349,	NULL,	3,		0,		0,		N'FactTuneCodeGroup',						N'FactTuneCodeGroup',					N'Play to Pay Fact Tune Code Group Table',						N'PipelineWarehouse',	N'FactTuneCodeGroup',						N'tim.firmin@prsformusic.com',		SYSDATETIME()),		
		(350,	NULL,	3,		0,		0,		N'DimOwnershipCAEGroup',					N'DimOwnershipCAEGroup',				N'Play to Pay Dim Ownership CAE Group Table',					N'PipelineWarehouse',	N'DimOwnershipCAEGroup',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(351,	NULL,	3,		0,		0,		N'FactOwnershipCAEGroup',					N'FactOwnershipCAEGroup',				N'Play to Pay Fact Ownership CAE Group Table',					N'PipelineWarehouse',	N'FactOwnershipCAEGroup',					N'tim.firmin@prsformusic.com',		SYSDATETIME()),
		(352,	NULL,	3,		0,		0,		N'DimDate',									N'dimDate',								N'Play to Pay Dim Date',										N'PipelineWarehouse',	N'DimDate',									N'Emma.Stewart@prsformusic.com',	SYSDATETIME())
) AS Src
	(
		 EntityTypeId
		,ParentEntityTypeId
		,ApplicationId
		,IsSourceEntity
		,[HasMultipleSourceFile]
		,Name
		,Code
		,[Description]
		,[Schema]
		,[Table]
		,[CreatedBy]
        ,[CreatedDate]
	)
	ON Tgt.EntityTypeId = Src.EntityTypeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[ApplicationId]			= Src.[ApplicationId],
		[IsSourceEntity]	    = Src.[IsSourceEntity],
		[HasMultipleSourceFile]	= Src.[HasMultipleSourceFile],
		[Name]					= Src.[Name],
		[Code]					= Src.[Code],
		[ParentEntityTypeId]	= Src.[ParentEntityTypeId],
		[Description]			= Src.[Description],
		[Schema]				= Src.[Schema],
		[Table]					= Src.[Table],
		[CreatedBy]				= Src.[CreatedBy],
        [CreatedDate]			= Src.[CreatedDate]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[EntityTypeId],
			[ApplicationId],
			[IsSourceEntity],
			[HasMultipleSourceFile],
			[Name],				
			[Code],				
			[ParentEntityTypeId],
			[Description],		
			[Schema],			
			[Table],				
			[CreatedBy],			
			[CreatedDate]		
		)
	VALUES
		(
			Src.[EntityTypeId],
			Src.[ApplicationId],
			Src.[IsSourceEntity],
			Src.[HasMultipleSourceFile],
			Src.[Name],
			Src.[Code],
			src.[ParentEntityTypeId],
			src.[Description],
			src.[Schema],
			src.[Table],
			src.[CreatedBy],			
			src.[CreatedDate]
		);


SET IDENTITY_INSERT [Control].[EntityType] OFF;




