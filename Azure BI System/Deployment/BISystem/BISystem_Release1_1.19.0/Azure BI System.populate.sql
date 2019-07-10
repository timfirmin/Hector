
PRINT 'OPENING TRANSACTION...'
BEGIN TRAN

PRINT 'Control.Application.Populate.sql'
GO

SET IDENTITY_INSERT [Control].[Application] ON;
GO

MERGE INTO [Control].[Application] AS Tgt
USING 
	(VALUES
	-- 	[ApplicationId],[Name],												[Code],			[Description],													  [Priority],	[UpTimeHours],	[ETLType],	[WarehouseType],[Prefix],	[CreatedDate]
		(13,			'Spotify Chart Daily 200',							'SPDCH200',		'Spotify daily chart top 200 datadownload',								null,	 null,			null,		'DataMart',		'SPDCH200',	SYSDATETIME())
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
		);

GO
SET IDENTITY_INSERT [Control].[Application] OFF;
GO

PRINT 'Control.EntityType.Populate.sql'
GO

SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]								[CreatedDate]
		(959,	NULL,	13,		1,		0,		N'SpotifyDailyTop200',						N'SpotifyDailyTop200',					N'SpotifyDailyTop200',											N'SPDCH200',			N'SpotifyDailyTop200',						N'piotr.starczynski@prsformusic.com',	SYSDATETIME()),
		(960,	NULL,	13,		0,		0,		N'SpotifyTrackMasterId',					N'SpotifyTrackMasterId',				N'SpotifyTrackMasterId',										N'SPDCH200',			N'SpotifyTrackMasterId',					N'piotr.starczynski@prsformusic.com',	SYSDATETIME())

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

GO

SET IDENTITY_INSERT [Control].[EntityType] OFF;
GO

PRINT 'ChartMartControlPopulate.sql'
GO

SET IDENTITY_INSERT [ChartMartControl].[Country] ON;
GO

MERGE INTO [ChartMartControl].[Country] AS Tgt
--Source
USING 
	(VALUES
	  --[CountryKey],	[ApplicationId],	[Name],					[Code]		IsChartDownloaded
		(1,				13,					'Andorra',				'AD',		1),
		(2,				13,					'Argentina',			'AR',		1),
		(3,				13,					'Australia',			'AU',		1),
		(4,				13,					'Austria',				'AT',		1),
		(5,				13,					'Belgium',				'BE',		1),
		(6,				13,					'Bolivia',				'BO',		1),
		(7,				13,					'Brazil',				'BR',		1),
		(8,				13,					'Bulgaria',				'BG',		1),
		(9,				13,					'Canada',				'CA',		1),
		(10,			13,					'Chile',				'CL',		1),
		(11,			13,					'Colombia',				'CO',		1),
		(12,			13,					'Costa Rica',			'CR',		1),
		(13,			13,					'Cyprus',				'CY',		1),
		(14,			13,					'Czech Republic',		'CZ',		1),
		(15,			13,					'Denmark',				'DK',		1),
		(16,			13,					'Dominican Republic',	'DO',		1),
		(17,			13,					'Ecuador',				'EC',		1),
		(18,			13,					'El Salvador',			'SV',		1),
		(19,			13,					'Estonia',				'EE',		1),
		(20,			13,					'Finland',				'FI',		1),
		(21,			13,					'France',				'FR',		1),
		(22,			13,					'Germany',				'DE',		1),
		(23,			13,					'Greece',				'GR',		1),
		(24,			13,					'Guatemala',			'GT',		1),
		(25,			13,					'Honduras',				'HN',		1),
		(26,			13,					'Hong Kong',			'HK',		1),
		(27,			13,					'Hungary',				'HU',		1),
		(28,			13,					'Iceland',				'IS',		1),
		(29,			13,					'Indonesia',			'ID',		1),
		(30,			13,					'Ireland',				'IE',		1),
		(31,			13,					'Italy',				'IT',		1),
		(32,			13,					'Japan',				'JP',		1),
		(33,			13,					'Latvia',				'LV',		1),
		(34,			13,					'Lithuania',			'LT',		1),
		(35,			13,					'Luxembourg',			'LU',		1),
		(36,			13,					'Malaysia',				'MY',		1),
		(37,			13,					'Malta',				'MT',		1),
		(38,			13,					'Mexico',				'MX',		1),
		(39,			13,					'Monaco',				'MC',		1),
		(40,			13,					'Netherlands',			'NL',		1),
		(41,			13,					'New Zealand',			'NZ',		1),
		(42,			13,					'Nicaragua',			'NI',		1),
		(43,			13,					'Norway',				'NO',		1),
		(44,			13,					'Panama',				'PA',		1),
		(45,			13,					'Paraguay',				'PY',		1),
		(46,			13,					'Peru',					'PE',		1),
		(47,			13,					'Philippines',			'PH',		1),
		(48,			13,					'Poland',				'PL',		1),
		(49,			13,					'Portugal',				'PT',		1),
		(50,			13,					'Singapore',			'SG',		1),
		(51,			13,					'Slovakia',				'SK',		1),
		(52,			13,					'Spain',				'ES',		1),
		(53,			13,					'Sweden',				'SE',		1),
		(54,			13,					'Switzerland',			'CH',		1),
		(55,			13,					'Taiwan',				'TW',		1),
		(56,			13,					'Turkey',				'TR',		1),
		(57,			13,					'United Kingdom',		'GB',		1),
		(58,			13,					'United States',		'US',		1),
		(59,			13,					'Uruguay',				'UY',		1)
	) AS Src
	(
		[CountryKey],
		[ApplicationId],
		[Name],
		[Code],
		[IsChartDownloaded]		
	)
	ON Tgt.CountryKey = Src.CountryKey

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]				= Src.[Name],
		[ApplicationId]		= Src.[ApplicationId],
		[Code]				= Src.[Code],
		[IsChartDownloaded]	= Src.[IsChartDownloaded]	

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[CountryKey],
			[ApplicationId],
			[Name],
			[Code],
			[IsChartDownloaded]	
		)
	VALUES
		(
			Src.[CountryKey],
			Src.[ApplicationId],
			Src.[Name],
			Src.[Code],
			Src.[IsChartDownloaded]
		)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO

SET IDENTITY_INSERT [ChartMartControl].[Country] OFF;



PRINT 'TRANSACTION NEED TO BE COMMIT'
--COMMIT