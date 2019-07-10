SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
		
		-- Online Migration 
		--[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]								[CreatedDate]
		(721,	NULL,	5,		1,		0,		N'Default',									N'NA',									N'NA',															N'N/A',					N'N/A',										N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(722,	NULL,	5,		1,		0,		N'OrcCreationComponent',					N'OrcCreationComponent',				N'OracleCreationComponent',										N'Oracle',				N'CreationComponent',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(723,	NULL,	5,		1,		0,		N'OrcUsageHeader',							N'OrcUsageHeader',						N'OracleUsageHeader',											N'Oracle',				N'UsageHeader',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(724,	NULL,	5,		1,		0,		N'OrcUsageComponent',						N'OrcUsageComponent',					N'OracleUsageComponent',										N'Oracle',				N'UsageComponent',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(725,	NULL,	5,		1,		0,		N'OrcInvoiceUsageComponents',				N'OrcInvoiceUsageComponents',			N'OracleInvoiceUsageComponents',								N'Oracle',				N'InvoiceUsageComponents',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(726,	NULL,	5,		1,		0,		N'OrcWorkContributorBridge',				N'OrcWorkContributorBridge',			N'OracleWorkContributorBridge',									N'Oracle',				N'WorkContributorBridge',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(727,	NULL,	5,		1,		0,		N'OrcContributor',							N'OrcContributor',						N'OracleContributor',											N'Oracle',				N'Contributor',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(728,	NULL,	5,		1,		0,		N'OrcAudioVisualContributor',				N'OrcAudioVisualContributor',			N'OracleAudioVisualContributor',								N'Oracle',				N'AudioVisualContributor',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(729,	NULL,	5,		1,		0,		N'OrcUsageRoyaltyTransactions',				N'OrcUsageRoyaltyTransactions',			N'OracleUsageRoyaltyTransactions',								N'Oracle',				N'UsageRoyaltyTransactions',				N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(730,	NULL,	5,		1,		0,		N'InvoiceRequestSalesRevenues',				N'InvoiceRequestSalesRevenues',			N'OracleInvoiceRequestSalesRevenues',							N'Oracle',				N'InvoiceRequestSalesRevenues',				N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(731,	NULL,	5,		1,		0,		N'InvoiceRequestRHGRoyalties',				N'InvoiceRequestRHGRoyalties',			N'OracleInvoiceRequestRHGRoyalties',							N'Oracle',				N'InvoiceRequestRHGRoyalties',				N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(732,	NULL,	5,		1,		0,		N'InvoiceRequestSummaries',					N'InvoiceRequestSummaries',				N'OracleInvoiceRequestSummaries',								N'Oracle',				N'InvoiceRequestSummaries',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(733,	NULL,	5,		1,		0,		N'Broadcasters',							N'Broadcasters',						N'OracleBroadcasters',											N'Oracle',				N'Broadcasters',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(734,	NULL,	5,		1,		0,		N'ElementaryTerritories',					N'ElementaryTerritories',				N'OracleElementaryTerritories',									N'Oracle',				N'ElementaryTerritories',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(735,	NULL,	5,		1,		0,		N'FilePaperLogs',							N'FilePaperLogs',						N'OracleFilePaperLogs',											N'Oracle',				N'FilePaperLogs',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(736,	NULL,	5,		1,		0,		N'FilePeriods',								N'FilePeriods',							N'OracleFilePeriods',											N'Oracle',				N'FilePeriods',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(737,	NULL,	5,		1,		0,		N'FileUsageByTerritory',					N'FileUsageByTerritory',				N'OracleFileUsageByTerritory',									N'Oracle',				N'FileUsageByTerritory',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(738,	NULL,	5,		1,		0,		N'Invoices',								N'Invoices',							N'OracleInvoices',												N'Oracle',				N'Invoices',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(739,	NULL,	5,		1,		0,		N'LicensedFiles',							N'LicensedFiles',						N'OracleLicensedFiles',											N'Oracle',				N'LicensedFiles',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(740,	NULL,	5,		1,		0,		N'Licences',								N'Licences',							N'OracleLicences',												N'Oracle',				N'Licences',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(741,	NULL,	5,		1,		0,		N'ReceivedFileLogs',						N'ReceivedFileLogs',					N'OracleReceivedFileLogs',										N'Oracle',				N'ReceivedFileLogs',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(742,	NULL,	5,		1,		0,		N'Recordings',								N'Recordings',							N'OracleRecordings',											N'Oracle',				N'Recordings',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(743,	NULL,	5,		1,		0,		N'RightHolderRepGroups',					N'RightHolderRepGroups',				N'OracleRightHolderRepGroups',									N'Oracle',				N'RightHolderRepGroups',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(744,	NULL,	5,		1,		0,		N'RightHolderGroups',						N'RightHolderGroups',					N'OracleRightHolderGroups',										N'Oracle',				N'RightHolderGroups',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(745,	NULL,	5,		1,		0,		N'ServiceTypes',							N'ServiceTypes',						N'OracleServiceTypes',											N'Oracle',				N'ServiceTypes',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(746,	NULL,	5,		1,		0,		N'OrcWorks',								N'OrcWorks',							N'OracleWorks',													N'Oracle',				N'Works',									N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(747,	NULL,	5,		1,		0,		N'RightsHolderGroupParameters',				N'RightsHolderGroupParameters',			N'OracleRightsHolderGroupParameters',							N'Oracle',				N'RightsHolderGroupParameters',				N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(748,	NULL,	5,		1,		0,		N'LicensingBodies',							N'LicensingBodies',						N'OracleLicensingBodies',										N'Oracle',				N'LicensingBodies',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(749,	NULL,	5,		1,		0,		N'LIBORHGBridge',							N'LIBORHGBridge',						N'OracleLIBORHGBridge',											N'Oracle',				N'LIBORHGBridge',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(750,	NULL,	5,		1,		0,		N'Mandates',								N'Mandates',							N'OracleMandates',												N'Oracle',				N'Mandates',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(751,	NULL,	5,		1,		0,		N'UsageDistributionCodes',					N'UsageDistributionCodes',				N'OracleUsageDistributionCodes',								N'Oracle',				N'UsageDistributionCodes',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(752,	NULL,	5,		1,		0,		N'UsageDistributionGroups',					N'UsageDistributionGroups',				N'OracleUsageDistributionGroups',								N'Oracle',				N'UsageDistributionGroups',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),


		
	  -- Online Migration 
	    (970,	NULL,	5,		1,		0,		N'Raw_InvoiceRequestSalesRevenues',		    N'Raw_InvoiceRequestSalesRevenues',		N'OracleRawInvoiceRequestSalesRevenues',						N'Oracle',				N'Raw_InvoiceRequestSalesRevenues',			N'vandana.bangera@prsformusic.com',		SYSDATETIME()),

	 

    -- Online Migration Raw Entity
	     -- Online Migration 
	    (983,	NULL,	5,		1,		0,		N'RoyaltySplit',							N'RoyaltySplit',						N'RoyaltySplit',												N'Raw',					N'RoyaltySplit',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),

		
		(986,	NULL,	5,		0,		0,		N'MDSMarketRoyaltyRates',					N'MDSMarketRoyaltyRates',				N'MDS MarketRoyaltyRates',										N'MDS',					N'MarketRoyaltyRates',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(987,	NULL,	5,		0,		0,		N'MDSTerritories',							N'MDSTerritories',						N'MDS Territories',												N'MDS',					N'Territories',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(988,	NULL,	5,		0,		0,		N'MDSMarketRoyaltyExceptions',				N'MDSMarketRoyaltyExceptions',			N'MDS MarketRoyaltyExceptions',									N'MDS',					N'MarketRoyaltyExceptions',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(989,	NULL,	5,		0,		0,		N'MDSInvoiceStatusManagement',				N'MDSInvoiceStatusManagement',			N'MDS InvoiceStatusManagement',									N'MDS',					N'InvoiceStatusManagement',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(990,	NULL,	5,		0,		0,		N'MDSApprovedInvoices',						N'MDSApprovedInvoices',					N'MDS ApprovedInvoices',										N'MDS',					N'ApprovedInvoices',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(991,	NULL,	5,		0,		0,		N'MDSMarket',								N'MDSMarket',							N'MDS Market',													N'MDS',					N'Market',									N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(992,	NULL,	5,		0,		0,		N'DimMarket',								N'dspDimMarket',						N'Online Rep Dim Market',										N'Dim',					N'Market',									N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(993,	NULL,	5,		0,		0,		N'DimFileLog',								N'dspDimFileLog',						N'Online Rep Dim File Log',										N'Dim',					N'FileLog',									N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(994,	NULL,	5,		0,		0,		N'DimContributor',							N'dspDimContributor',					N'Online Rep Dim Contributor',									N'Dim',					N'Contributor',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(995,	NULL,	5,		0,		0,		N'DimInvoices',								N'dspDimInvoices',						N'Online Rep Dim Invoices',										N'Dim',					N'Invoices',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(996,	NULL,	5,		0,		0,		N'DimLicensingBodies',						N'dspDimLicensingBodies',				N'Online Rep Dim Licensing Bodies',								N'Dim',					N'Licensing Bodies',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(997,	NULL,	5,		0,		0,		N'DimMandates',								N'dspDimMandates',						N'Online Rep Dim Mandates',										N'Dim',					N'Mandates',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(998,	NULL,	5,		0,		0,		N'DimRightHolderGroup',						N'dspDimRightHolderGroup',				N'Online Rep Dim Right Holder Group',							N'Dim',					N'RightHolderGroup',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(999,	NULL,	5,		0,		0,		N'DimTerritory',							N'dspDimTerritory',						N'Online Rep Dim Territory',									N'Dim',					N'Territory',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1000,	NULL,	5,		0,		0,		N'DimUsageComponent',						N'dspDimUsageComponent',				N'Online Rep Dim Usage Component',								N'Dim',					N'Usage Component',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1001,	NULL,	5,		0,		0,		N'DimWork',									N'dspDimWork',							N'Online Rep Dim Work',											N'Dim',					N'Work',									N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1002,	NULL,	5,		0,		0,		N'FactInvoiceSalesRevenue',					N'dspFactInvoiceSalesRevenue',			N'Online Rep Fact Invoice Sales Revenue',						N'Fact',				N'InvoiceSalesRevenue',						N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1003,	NULL,	5,		0,		0,		N'FactInvoiceUsage',						N'dspFactInvoiceUsage',					N'Online Rep Fact Invoice Usage',								N'Fact',				N'InvoiceUsage',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1004,	NULL,	5,		0,		0,		N'FactRHGRoyalties',						N'dspFactRHGRoyalties',					N'Online Rep Fact RHG Royalties',								N'Fact',				N'RHGRoyalties',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1005,	NULL,	5,		0,		0,		N'FactUsageRoyalties',						N'dspFactUsageRoyalties',				N'Online Rep Fact Usage Royalties',								N'Fact',				N'UsageRoyalties',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1006,	NULL,	5,		0,		0,		N'FactWorkContributorBridge',				N'dspFactWorkContributorBridge',		N'Online Rep Fact Work Contributor Bridge',						N'Fact',				N'WorkContributorBridge',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1007,	NULL,	5,		0,		0,		N'AggregateMarketShareByPerformer',			N'dspAggregateMarketShareByPerformer',	N'Online Rep AggregateMarketShareByPerformer',					N'Aggregate',			N'MarketShareByPerformer',					N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1008,	NULL,	5,		0,		0,		N'AggregateUsage',							N'dspAggregateUsage',					N'Online Rep AggregateUsage',									N'Aggregate',			N'Usage',									N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1009,	NULL,	5,		0,		0,		N'AggregateUsageRoyalties',					N'dspAggregateUsageRoyalties',			N'Online Rep AggregateUsageRoyalties',							N'Aggregate',			N'UsageRoyalties',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1010,	NULL,	5,		0,		0,		N'IUCTunecode',								N'dspIUCTunecode',						N'Online Rep PELCA IUC Tunecode',								N'dbo',					N'IUCTunecode',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1011,	NULL,	5,		0,		0,		N'IUC1410CopCon',								N'dspCIUC1410CopCon',				N'Online Rep IUC 1410 CopCon',									N'dbo',					N'IUC1410CopCon',							N'vandana.bangera@prsformusic.com',		SYSDATETIME()),

		(1117,	NULL,	5,		0,		0,		N'FactUsage',								N'dspFactUsage',						N'Online Rep Fact Usage',										N'Fact',				N'Usage',									N'vandana.bangera@prsformusic.com',		SYSDATETIME())

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
		)

--  Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;


