SET IDENTITY_INSERT [Control].[Application] ON;
GO
MERGE INTO [Control].[Application] AS Tgt
USING 
	(VALUES
	-- 	[ApplicationId],[Name],												[Code],			[Description],													  [Priority],	[UpTimeHours],	[ETLType],	[WarehouseType],[Prefix],	[CreatedDate]
		(1,				'Data Experience Online Statements',				'DEOS',			'Data Experience Solution',												null,	 null,			null,		'Azure DW ',	'DX',		SYSDATETIME()),
		(2,				'BroadcastDataQuality',								'BRDDQ',		'DataQuality Solution for AV',											null,	 null,			null,		'DataMart',		'DQ',		SYSDATETIME()),
		(3,				'Broadcast Play to Pay',							'BRDPTP',		'Play to Pay Solution for Broadcast 1 and 2',							null,	 null,			null,		'Azure DW',		'BR',		SYSDATETIME()),
		(4,				'Finance DataMart',									'FDM',			'Finance DataMart for CODA and TM1',									null,	 null,			null,		'DataMart',		'FDM',		SYSDATETIME()),
		(5,				'REP Transactional',								'REPTXN',		'BI DSP Invoice Approval Archive Reporting Finance & Membershp',		null,	 null,			null,		'DataMart',		'OL',		SYSDATETIME()),
		(6,				'ETL System',										'ETLDq',		'ETL DQ System - Rep Load File Analysis Files',							null,	 null,			null,		'DataMart',		'ETLSystem',SYSDATETIME()),
		(7,				'CashOut Reconciliation System',					'CORS',			'CashOut Reconciliation System',										null,	 null,			null,		'Azure DW',		'CORS',		SYSDATETIME()),
		(8,				'Data Experience Online Statements SAS Data Fixes',	'DEOSSAS',		'Data Experience SASA Data Fixes Solution',								null,	 null,			null,		'Azure DW ',	'SAS',		SYSDATETIME()),
		(9,				'BITurqoiseSystem',									'BITS',			'Project Turquoise Joint Ventures CODA - File to Azure to Link Tables',	null,	 null,			null,		'DataMart',		'BITS',		SYSDATETIME()),
		(10,			'DotMailer',										'DOTMAILER',	'DotMailer API Application',											null,	 null,			null,		'DataMart',		'DOTMAILER',SYSDATETIME()),
		(11,			'ICE Files',										'ICEF',			'Solution for loading ICE files',										null,	 null,			null,		'Azure DW ',	'ICE',		SYSDATETIME()),
		(12,			'PreDistribution Play to Pay',						'PDPTP',		'Play to Pay Solution for Pre Distribution',							null,	 null,			null,		'Azure DW',		'PDPTP',	SYSDATETIME()),
		(13,			'Spotify Chart Daily 200',							'SPDCH200',		'Spotify daily chart top 200 datadownload',								null,	 null,			null,		'DataMart',		'SPDCH200',	SYSDATETIME()),
		(14,			'International Financial Reporting - IKFD',		    'IKFD',		    'International Financial Reporting - IKFD',								null,	 null,			null,		'DataMart',		'IKFD',  	SYSDATETIME()),
		(15,			'Case Management',									'CASEQCDQ',		'Case Management Quality Check',										null,	 null,			null,		'DataMart',		'CaseQC',  	SYSDATETIME()),
		(16,			'Data Experience Online Statements DM Stmt Rerun',  'DEOSDM',		'Data Experience DM Stmt Rerun Solution',								null,	 null,			null,		'Azure DW ',	'DMS',		SYSDATETIME()),
		(17,			'Distribution Assurance -Hector',					'HCTR2',		'Distribution Assurance -Hector',										null,	 null,			null,		'DataMart',		'Hctr',		SYSDATETIME()),
		(18,			'TM1 Data Integrations - FDM/Hector2',				'TM1FDM',		'TM1 Data Integration to Finance Data Mart and Hector 2 Apps',			null,	 null,			null,		'DataMart',		'TM1FDM',	SYSDATETIME()),
		(19,			'MDS Integration',									'MDSI',		    'Master Data Systems Data Integration',									null,	 null,			null,		'DataMart',		'MDSI',	    SYSDATETIME()),
		(20,			'FPV Application / Integration',					'FPV',		    'FPV Application and Integration Systems',								null,	 null,			null,		'DataMart',		'FPV',		SYSDATETIME()),
		(21,			'DDI - Distribution Data Integration',				'DDI',		    'DDI - Distribution Data Integration',									null,	 null,			null,		'DataMart',		'DDI',	    SYSDATETIME()),
		(22,			'Licencing CRM',									'LCRM',		    'CRM data for Licensing',												null,	 null,			null,		'DataMart',		'LCRM',	    SYSDATETIME()),
		(23,			'Audience Mart',									'BARB',		    'Audience Mart - BARB and RAJAR',										null,	 null,			null,		'DataMart',		'BARB',	    SYSDATETIME())
	) AS Src
	(
		[ApplicationId],
		[Name],
     	[Code],
		[Description],
		[Priority],		   
		[UpTimeHours],	   
		[ETLType],		   
        [WarehouseType],
		[Prefix],
		[CreatedDate]
	)
	ON Tgt.[ApplicationId] = Src.[ApplicationId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]			   = Src.[Name],
		[Code]			   = Src.[Code],
		[Description]	   = Src.[Description],
		[Priority]		   = Src.[Priority],
		[UpTimeHours]	   = Src.[UpTimeHours],
		[ETLType]		   = Src.[ETLType],
		[WarehouseType]	   = Src.[WarehouseType],
		[Prefix]		   = Src.[Prefix]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ApplicationId],
			[Name],
     		[Code],
			[Description],
			[WarehouseType],
			[Prefix]		
		)
	VALUES
		(
			Src.[ApplicationId],
			Src.[Name],
			Src.[Code],
			Src.[Description],
			Src.[WarehouseType],
			Src.[Prefix]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[Application] OFF;

