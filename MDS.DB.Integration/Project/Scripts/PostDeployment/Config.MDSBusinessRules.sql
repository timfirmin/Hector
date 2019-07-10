	-- select * from [Config].[MDSBusinessRules]
	SET IDENTITY_INSERT [Config].[MDSBusinessRules] ON;
	GO
	MERGE INTO [Config].[MDSBusinessRules] AS Tgt
	USING 
		(VALUES
		  --[RuleId], [EnitytName], [AttributeName], [RuleDescription], [RuleUdf], [DataType], [IsNullable], [LookupEnitity], [DefaultValue], [PermittedValues], [NotificationTemplate], [RuleType], [RuleActiveYN]
			(1, N'MasterStation', N'Name', N'The non-nullable field BroadcasterName is null', N'Transform.udfValidateBroadcasterName()', N'Text', N'N', N'', N'', N'', N'MDS Master Station Validation', N'Broadcaster Name','Y'),
			(2, N'MasterStation', N'InceptionDate', N'The non-nullable field InceptionDate is null', N'Transform.udfValidateInceptionDate()', N'Date', N'N', N'', N'', N'', N'MDS Master Station Validation', N'Inception Data is null','N'),
			(3, N'MasterStation', N'LowRevenue', N'The Low Revenue Flag Check Failed', N'Transform.udfValidateLowRevenueFlag()', N'Bool', N'N', N'', N'', N'', N'MDS Master Station Validation', N'Low Revenue check','N'),
			(4, N'MasterStation', N'CommercialSampleDays', N'The CommercialSampleDays Value is not between 0 and 365', N'Transform.udfValidateCommercialSampleDays()', N'Integer', N'Y', N' ', N' ', N' ', N'MDS Master Station Validation', N'Commercial Sample Days','Y'),
			(5, N'MasterStation', N'LicenceGroup', N'The LicenceGroup field has changed value', N'Transform.udfCheckLicenceGroupChange()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Licence Updates','N'),
			(6, N'MasterStation', N'AudioPolicy', N'The AudioPolicy field has changed value', N'Transform.udfCheckAudioPolicyChange()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Audio Policy Changes','Y'),
			(7, N'MasterStation', N'AudioPolicy', N'SampleDays is less than 365 when AudioPolicy is Census, or SampleDays is equal to 365 when AudioPolicy is Sampled', N'Transform.udfValidateAudioPolicySampleDays()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Audio Policy / Sample Days Changes','Y'),
			(8, N'MasterStation', N'CodaAccountCodeEL2', N'The non-nullable field CodaAccountCodeEL2 is null.', N'Transform.udfValidateCodaAccountCodeEl2()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Coda Account Code EL2','N'),
			(10, N'MasterStation', N'BroadcasterDomain', N'The non-nullable field BroadcasterDomain is null', N'Transform.udfValidateBroadcasterDomain()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Broadcaster Domain','N'),
			(11, N'MasterStation', N'DistributionGroup', N'The non-nullable field DistributionGroup is null', N'Transform.udfValidateDistributionGroup()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Distribution Group','Y'),
			(12, N'MasterStation', N'MusicReportingGroup', N'The non-nullable field MusicReportingGroup is null', N'Transform.udfValidateMusicReportingGroup()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Music Reporting Group','N'),
			(13, N'MasterStation', N'LicenceGroup', N'The non-nullable field LicenceGroup is null', N'Transform.udfValidateLicenceGroup()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Licence Group','N'),
			(14, N'MasterStation', N'MCPSLicenceType', N'The non-nullable field MCPSLicenceType is null', N'Transform.udfValidateMCPSLicenceType()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'MCPS Licence Type','N'),
			(15, N'MasterStation', N'LicencedStatus', N'The non-nullable field LicensedStatus is null', N'Transform.udfValidateLicencedStatus()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Licensed Status','Y'),
			(16, N'MasterStation', N'Territory', N'The non-nullable field Territory is null', N'Transform.udfValidateTerritory()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Territory','N'),
			(17, N'MasterStation', N'CodaCustomerCode', N'The non-nullable field CodaCustomerCode is null', N'Transform.udfValidateCodaCustomerCode()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Coda Customer Code','Y'),
			(18, N'MasterStation', N'RightType', N'The non-nullable field RightType is null', N'Transform.udfValidateRightType()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Right Type','Y'),
			(19, N'MasterStation', N'Diversity', N'The non-nullable field Diversity is null', N'Transform.udfValidateDiversity()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Diversity','N'),
			(20, N'MasterStation', N'StationAdminRate', N'The non-nullable field StationAdminRate is null', N'Transform.udfValidateStationAdminRate()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Station Admin Rate','Y'),
			(21, N'MasterStation', N'PublicReceptionAdminRate', N'The non-nullable field PublicReceptionAdminRate is null', N'Transform.udfValidatePublicReceptionAdminRate()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'Public Reception Admin Rate','Y'),
			(22, N'MasterStation', N'StationUDC', N'Mapped UDC Station is Invalid in UDC or Station Master', N'Transform.udfValidateStationUDC()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'UDC Mapped is null','Y'),
			(23, N'MasterStation', N'AVSampleDays', N'CommercialSampleDays are not equal to NonCommercialSampleDays', N'Transform.udfValidateSampleDays()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'AV Sample Days Mismatch','Y'),
			(24, N'MasterStation', N'BR3Licence', N'The field BR3Licence is null for an ILR station', N'Transform.udfValidateBR3Licence()', N'Text', N'N', N' ', N' ', N' ', N'MDS Master Station Validation', N'BR3 Licence','Y'),
			(1017, N'MasterStation', N'MinimumFee', N'MinimumFee is null', N'Transform.udfValidateMinimumFee()', N'Text', N'Y', N' ', N' ', N' ', N'MDS Master Station Validation', N'Minimum Fee', N'Y')
		) AS Src
		(
		 [RuleId]
		,[EnitytName]
		,[AttributeName]
		,[RuleDescription]
		,[RuleUdf]
		,[DataType]
		,[IsNullable]
		,[LookupEnitity]
		,[DefaultValue]
		,[PermittedValues]
		,[NotificationTemplate]
		,[RuleType]
		,RuleActiveYN
		)
		ON Tgt.RuleId = Src.RuleId
	-- Update matched rows
	WHEN MATCHED  
		   AND isnull(Tgt.[EnitytName],0)!=isnull(Src.[EnitytName],0)
			OR isnull(Tgt.[AttributeName],0)!=isnull(Src.[AttributeName],0)
			OR isnull(Tgt.[RuleDescription],0)!=isnull(Src.[RuleDescription],0)
			OR isnull(Tgt.[RuleUdf],0)!=isnull(Src.[RuleUdf],0)
			OR isnull(Tgt.[DataType],0)!=isnull(Src.[DataType],0)
			OR isnull(Tgt.[IsNullable],0)!=isnull(Src.[IsNullable],0)
			OR isnull(Tgt.[LookupEnitity],0)!=isnull(Src.[LookupEnitity],0)
			OR isnull(Tgt.[DefaultValue],0)!=isnull(Src.[DefaultValue],0)
			OR isnull(Tgt.[PermittedValues],0)!=isnull(Src.[PermittedValues],0)
			OR isnull(Tgt.[NotificationTemplate],0)!=isnull(Src.[NotificationTemplate],0)
			OR isnull(Tgt.[RuleType],0)!=isnull(Src.[RuleType],0)
			OR isnull(Tgt.RuleActiveYN,0)!=isnull(Src.RuleActiveYN,0)
	THEN
		UPDATE
		SET
			[EnitytName]			= Src.[EnitytName],
			[AttributeName]			= Src.[AttributeName],
			[RuleDescription]		= Src.[RuleDescription],
			[RuleUdf]		        = Src.[RuleUdf],
			[DataType]		        = Src.[DataType],
			[IsNullable]		    = Src.[IsNullable],
			[LookupEnitity]		    = Src.[LookupEnitity],
			[DefaultValue]		    = Src.[DefaultValue],
			[PermittedValues]		= Src.[PermittedValues],
			[NotificationTemplate]	= Src.[NotificationTemplate],
			[RuleType]	            = Src.[RuleType],
			RuleActiveYN            = Src.RuleActiveYN
	WHEN NOT MATCHED BY TARGET THEN




		INSERT
			(
				 [RuleId]
				,[EnitytName]
				,[AttributeName]
				,[RuleDescription]
				,[RuleUdf]
				,[DataType]
				,[IsNullable]
				,[LookupEnitity]
				,[DefaultValue]
				,[PermittedValues]
				,[NotificationTemplate]
				,[RuleType]	
			)
		VALUES
			(
			 SRC.[RuleId]
			,SRC.[EnitytName]
			,SRC.[AttributeName]
			,SRC.[RuleDescription]
			,SRC.[RuleUdf]
			,SRC.[DataType]
			,SRC.[IsNullable]
			,SRC.[LookupEnitity]
			,SRC.[DefaultValue]
			,SRC.[PermittedValues]
			,SRC.[NotificationTemplate]
			,SRC.[RuleType]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
	GO
	SET IDENTITY_INSERT [Config].[MDSBusinessRules] OFF;