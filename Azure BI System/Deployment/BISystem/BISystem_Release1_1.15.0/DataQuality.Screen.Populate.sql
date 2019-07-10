SET IDENTITY_INSERT DataQuality.Screen ON 
GO 
MERGE INTO DataQuality.Screen AS Tgt
USING 
	(VALUES
		-- Column rules

		-- Format 5 Line 10

		(1,'Series Indicator'						,'Valid Series Indicator Check'							,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'SeriesIndicator NOT IN(''Y'', ''N'', '''')'										,	NULL,	NULL,	NULL, NULL, 'AV'),
		(2,'Production/Series Name'					,'Production/Series Name Mandatory Column Check'		,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'ProductionName = '''''															,	NULL,	NULL,	NULL, NULL, 'AV'),
		(3,'Series Number'							,'Series Number Population Check'						,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'SeriesIndicator = ''Y'' AND SeriesNumber = '''''									,	NULL,	NULL,	NULL, NULL, 'AV'),
		(4,'Episode Name'							,'Episode Name Population Check'						,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = '''''			,	NULL,	NULL,	NULL, NULL, 'AV'),
		(5,'Episode Number'							,'Episode Number Population Check'						,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = '''''			,	NULL,	NULL,	NULL, NULL, 'AV'),
		(6,'Transmission Station'					,'Transmission Station Population Check'				,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'TransmissionStation = '''''														,	NULL,	NULL,	NULL, NULL, 'AV'),
		(7,'Daily Transmission Schedule Date'		,'Daily Transmission Schedule Date Population Check'	,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'DailyTransmissionScheduleDate = '''''												,	NULL,	NULL,	NULL, NULL, 'AV'),
		(8,'Transmission Time'						,'Transmission Time Population Check'					,NULL	,NULL		,'DataQuality Format5 Line10'		,	1		,'TransmissionTime = '''''															,	NULL,	NULL,	NULL, NULL, 'AV'),
		(9,'Production Company','Production Company Population Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ProductionSourceIndicator = ''C'' AND ProductionCompany = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(10,'First Transmission Indicator','Valid First Transmission Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'FirstTransmissionIndicator NOT IN(''Y'', ''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		 --Reference rule previously removed as MDS not available.
		(11,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'AV'),
		(12,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'AV'),
		(13,'Production Source Indicator','Valid Production Source Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ENT.ProductionSourceIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionSource PS ON ENT.ProductionSourceIndicator = PS.Code',	NULL, NULL, 'AV'),
		(14,'Domestic International Indicator','Valid Domestic International Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ENT.DomesticInternationalIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.DomesticInternationalTransmission DI ON ENT.DomesticInternationalIndicator = DI.Code',	NULL, NULL, 'AV'),
		 --Column rule
		(15,'MCPS Blanket Indicator','Valid MCPS Blanket Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'MCPSBlanketIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'AV'),
		-- Reference rule
		(16,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'AV'),
		(17,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'AV'),
	--	 Column rule
		(18,'Valid Amendment Indicator','Valid Amendment Indicator Check',NULL,NULL,'DataQuality Format5 Line10',	1,	'AmendmentIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'AV'),
		
		
		-- Format 5 Line 20
		(30,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(31,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(32,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(33,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(34,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(35,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'AV'),
		(36,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''M'',''S'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(37,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(38,'Prior Approval Indicator','Prior Approval Indicator Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'PriorApprovalIndicator NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(39,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(40,'Licensing Status Of Commissioned Music','Licensing Status Of Commissioned Music Check', NULL,NULL,'DataQuality Format5 Line20',	1,	'LicensingStatusofCommissionedMusic NOT IN(''N'',''Y'') AND MusicCommissionFlag = ''Y''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(41,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(42,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(43,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicPerformer = '''' AND MusicOriginClassification = ''C''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(44,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format5 Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),



		--Format 5 Line 00

		(60,'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format5 Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),
		(61,'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format5 Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(62,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format5 Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(63,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format5 Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(64,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format5 Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),

		--Format 5 Line 99

		(70,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format5 Line99',	1,	'RecordCount IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),

	
		-- Format 303 Line 10

		--(1,'Series Indicator','Valid Series Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'SeriesIndicator NOT IN(''Y'', ''N'', '''')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(71,'Production/Series Name','Production/Series Name Mandatory Column Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(3,'Series Number','Series Number Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'SeriesIndicator = ''Y'' AND SeriesNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(72,'Episode Name','Episode Name Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'EpisodeNumber = '''' AND EpisodeName = '''' AND ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(73,'Episode Number','Episode Number Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'EpisodeNumber = '''' AND EpisodeName = '''' AND ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(74,'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(75,'Transmission Date','Transmission Date Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'TransmissionDate = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(76,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'TransmissionTime = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(77,'Production Company','Production Company Population Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ProductionSourceIndicator = ''C'' AND ProductionCompany = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(10,'First Transmission Indicator','Valid First Transmission Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'FirstTransmissionIndicator NOT IN(''Y'', ''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		 
		 --Reference rule previously removed as MDS not available.
		
		(78,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'AV'),
		(79,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'AV'),
		(80,'Production Source Indicator','Valid Production Source Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ENT.ProductionSourceIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionSource PS ON ENT.ProductionSourceIndicator = PS.Code',	NULL, NULL, 'AV'),
		--(14,'Domestic International Indicator','Valid Domestic International Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ENT.DomesticInternationalIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.DomesticInternationalTransmission DI ON ENT.DomesticInternationalIndicator = DI.Code',	NULL, NULL, 'AV'),
		 --Column rule
		(81,'MCPS Blanket Indicator','Valid MCPS Blanket Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'MCPSBlanketIndicator NOT IN(''Y'', ''N'')',NULL, NULL,	NULL, NULL, 'AV'),
		-- Reference rule
		(82,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'AV'),
		--(17,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'AV'),
	
	--	 Column rule
		(83,'Valid Amendment Indicator','Valid Amendment Indicator Check',NULL,NULL,'DataQuality Format303 Line10',	1,	'AmendmentIndicator NOT IN(''Y'', ''N'')',NULL, NULL,	NULL, NULL, 'AV'),
		
		
		-- Format 303 Line 20
		(84,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(85,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(86,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(87,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(88,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(89,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'AV'),
		(90,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''S'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(91,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(92,'Prior Approval Indicator','Prior Approval Indicator Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'PriorApprovalIndicator NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(93,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(94,'Licensing Status Of Commissioned Music','Licensing Status Of Commissioned Music Check', NULL,NULL,'DataQuality Format303 Line20',	1,	'LicensingStatusofCommissionedMusic NOT IN(''N'',''Y'') AND MusicCommissionFlag = ''Y''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(95,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(96,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(97,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicPerformer = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(44,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format303 Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),



		--Format 303 Line 00

		(98,'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format303 Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),
		(99,'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format303 Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(100,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format303 Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(101,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format303 Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(102,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format303 Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),

		--Format 303 Line 99

		(103,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format303 Line99',	1,	'RecordCount IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),

		-- Format 50 Line 10

		(104,'Series Indicator','Valid Series Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'SeriesIndicator NOT IN(''Y'', ''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(105,'Production/Series Name','Production/Series Name Mandatory Column Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(106,'Series Number','Series Number Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'SeriesIndicator = ''Y'' AND SeriesNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(107,'Episode Name','Episode Name Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(108,'Episode Number','Episode Number Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(109,'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(110,'Daily Transmission Schedule Date','Daily Transmission Schedule Date Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'DailyTransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(111,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'TransmissionTime = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(112,'Production Company','Production Company Population Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ProductionSourceIndicator = ''C'' AND ProductionCompany = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(113,'First Transmission Indicator','Valid First Transmission Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'FirstTransmissionIndicator NOT IN(''Y'', ''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		 --Reference rule previously removed as MDS not available.
		(114,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'AV'),
		(115,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'AV'),
		(116,'Production Source Indicator','Valid Production Source Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ENT.ProductionSourceIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionSource PS ON ENT.ProductionSourceIndicator = PS.Code',	NULL, NULL, 'AV'),
		--(117,'Domestic International Indicator','Valid Domestic International Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ENT.DomesticInternationalIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.DomesticInternationalTransmission DI ON ENT.DomesticInternationalIndicator = DI.Code',	NULL, NULL, 'AV'),
		 --Column rule
		(118,'MCPS Blanket Indicator','Valid MCPS Blanket Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'MCPSBlanketIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'AV'),
		-- Reference rule
		(119,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'AV'),
		--(120,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'AV'),
	--	 Column rule
		--(121,'Valid Amendment Indicator','Valid Amendment Indicator Check',NULL,NULL,'DataQuality Format50 Line10',	1,	'AmendmentIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'AV'),
		
		
		-- Format 50 Line 20
		(122,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(123,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(124,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(125,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(126,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(127,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'AV'),
		(128,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''M'',''S'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(129,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(130,'Prior Approval Indicator','Prior Approval Indicator Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'PriorApprovalIndicator NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(131,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(132,'Licensing Status Of Commissioned Music','Licensing Status Of Commissioned Music Check', NULL,NULL,'DataQuality Format50 Line20',	1,	'LicensingStatusofCommissionedMusic NOT IN(''N'',''Y'') AND MusicCommissionFlag = ''Y''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(133,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(134,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(135,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicPerformer = '''' AND MusicOriginClassification = ''C''',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(136,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format50 Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),



		--Format 50 Line 00

		(137,'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format50 Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),
		(138,'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format50 Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(139,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format50 Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(140,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format50 Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(141,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format50 Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),

		--Format 50 Line 99

		(142,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format50 Line99',	1,	'RecordCount IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),


		-- Format 52 Line 10

		(143,'Series Indicator','Valid Series Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'SeriesIndicator NOT IN(''Y'', ''N'', '''')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(144,'Production/Series Name','Production/Series Name Mandatory Column Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(145,'Series Number','Series Number Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'SeriesIndicator = ''Y'' AND SeriesNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(146,'Episode Name','Episode Name Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(147,'Episode Number','Episode Number Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(148,'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(149,'Daily Transmission Schedule Date','Daily Transmission Schedule Date Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'DailyTransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(150,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'TransmissionTime = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(151,'Production Company','Production Company Population Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ProductionSourceIndicator = ''C'' AND ProductionCompany = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(152,'First Transmission Indicator','Valid First Transmission Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'FirstTransmissionIndicator NOT IN(''Y'', ''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		 --Reference rule previously removed as MDS not available.
		(153,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'AV'),
		(154,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'AV'),
		(155,'Production Source Indicator','Valid Production Source Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ENT.ProductionSourceIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionSource PS ON ENT.ProductionSourceIndicator = PS.Code',	NULL, NULL, 'AV'),
		--(156,'Domestic International Indicator','Valid Domestic International Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ENT.DomesticInternationalIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.DomesticInternationalTransmission DI ON ENT.DomesticInternationalIndicator = DI.Code',	NULL, NULL, 'AV'),
		 --Column rule
		--(157,'MCPS Blanket Indicator','Valid MCPS Blanket Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'MCPSBlanketIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'AV'),
		-- Reference rule
		(158,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'AV'),
		(159,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'AV'),
	--	 Column rule
		--(160,'Valid Amendment Indicator','Valid Amendment Indicator Check',NULL,NULL,'DataQuality Format52 Line10',	1,	'AmendmentIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'AV'),
		
		
		-- Format 52 Line 20
		(161,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(162,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(163,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(164,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(165,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(166,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'AV'),
		(167,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''M'',''S'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(168,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		--(169,'Prior Approval Indicator','Prior Approval Indicator Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'PriorApprovalIndicator NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(170,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'AV'),
		(171,'Licensing Status Of Commissioned Music','Licensing Status Of Commissioned Music Check', NULL,NULL,'DataQuality Format52 Line20',	1,	'LicensingStatusofCommissionedMusic NOT IN(''N'',''Y'') AND MusicCommissionFlag = ''Y''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(172,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(173,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(174,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicPerformer = '''' AND MusicOriginClassification = ''C''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(175,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format52 Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'')',	NULL,	NULL,	NULL, NULL, 'AV'),



		--Format 52 Line 00

		(176,'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format52 Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),
		(177,'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format52 Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(178,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format52 Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(179,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format52 Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),
		(180,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format52 Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'AV'),

		--Format 52 Line 99

		(181,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format52 Line99',	1,	'RecordCount IS NULL',	NULL,	NULL,	NULL, NULL, 'AV'),

		-- Format 51 Line 00

		(182, 'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format51 Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(183, 'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format51 Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(184,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format51 Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(185,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format51 Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(186,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format51 Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),

		--Format 51 line 10


		(188,'Production Number','Production Number Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ProductionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(189,'Production/Series Name','Production/Series Name Mandatory Column Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(190,'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(191,'Daily Transmission Schedule Date','Daily Transmission Schedule Date Population Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'DailyTransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(192,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'TransmissionTime = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
	 

	    --Reference rule previously removed as MDS not available.
		(193,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'Radio'),
		(194,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'Radio'),
	    (195,'Domestic International Indicator','Valid Domestic International Indicator Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ENT.DomesticInternationalIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.DomesticInternationalTransmission DI ON ENT.DomesticInternationalIndicator = DI.Code',	NULL, NULL, 'Radio'),
		 
		-- Reference rule
		(196,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'Radio'),
		(197,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'Radio'),
	   --Column rule
		(198,'Valid Amendment Indicator','Valid Amendment Indicator Check',NULL,NULL,'DataQuality Format51 Line10',	1,	'AmendmentIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'Radio'),
		
		--Format 51 line 20


		(199,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(200,'Music Title','Music Title Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicTitle = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(201,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(202,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(203,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(204,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(205,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(206,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''M'',''S'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(207,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(208,'Prior Approval Indicator','Prior Approval Indicator Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'PriorApprovalIndicator NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(209,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(210,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(211,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(212,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicPerformer = '''' AND MusicOriginClassification = ''C''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(213,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format51 Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'')',	NULL,	NULL,	NULL, NULL, 'Radio'),

		--Format 51 line 99


		(214,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format51 Line99',	1,	'NumberOfRecords IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio'),

		
			-- Format 51a Line 00

		(215, 'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format51a Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(216, 'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format51a Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(217,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format51a Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(218,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format51a Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(219,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format51a Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),

		--Format 51a line 10


		(220,'Production Number','Production Number Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ProductionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (221,'Series Indicator','Valid Series Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'SeriesIndicator NOT IN(''Y'', ''N'', '''')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(222,'Production/Series Name','Production/Series Name Mandatory Column Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(223,'Series Number','Series Number Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'SeriesIndicator = ''Y'' AND SeriesNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(224,'Episode Name','Episode Name Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(225,'Episode Number','Episode Number Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(226,'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		--(227,'Originating Network Station','Originating Network Station Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'OriginatingNetworkStation = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(228,'Daily Transmission Schedule Date','Daily Transmission Schedule Date Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'DailyTransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(229,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'LTRIM(TransmissionTime) = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
	    (230,'Running Time','Running Time Population Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'RunningTime = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(231,'Production Company','Production Company Check', NULL,NULL,'DataQuality Format51a Line10',	1,	'ProductionCompany = '''' AND ProductionSourceIndicator = ''C''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		--(232,'Production Year','Production Year Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ProductionYear = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(233,'First Transmission Indicator','First Transmission Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'FirstTransmissionIndicator NOT IN(''Y'', ''N'', '''')',	NULL,	NULL,	NULL, NULL, 'Radio'),
	    --reference rule previously removed as MDS not available.
		(234,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'Radio'),
		(235,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'Radio'),
	    (236,'Production Source Indicator','Valid Production Source Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ENT.ProductionSourceIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionSource PS ON ENT.ProductionSourceIndicator = PS.Code',	NULL, NULL, 'Radio'),
	    (237,'Domestic International Indicator','Valid Domestic International Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ENT.DomesticInternationalIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.DomesticInternationalTransmission DI ON ENT.DomesticInternationalIndicator = DI.Code',	NULL, NULL, 'Radio'),
		 
		-- Reference rule
		(238,'MCPS Blanket Indicator','Valid MCPS Blanket Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'MCPSBlanketIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'Radio'),
		(239,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'Radio'),
		(240,'Secondary Exploitation Indicator','Secondary Exploitation Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'SecondaryExploitationIndicator NOT IN(''Y'', ''N'', '''')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(241,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'Radio'),
	   --Column rule
		(242,'Valid Amendment Indicator','Valid Amendment Indicator Check',NULL,NULL,'DataQuality Format51a Line10',	1,	'AmendmentIndicator NOT IN(''Y'', ''N'', '''')',NULL, NULL,	NULL, NULL, 'Radio'),
		
		--Format 51a line 20


		(243,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(244,'Music Title','Music Title Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicTitle = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(245,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(246,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(247,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(248,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		--(249,'Product Side Number','Product Side Number Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ProductSideNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		--(250,'Product Track Number','Product Track Number Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ProductTrackNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(251,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(252,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''M'',''S'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(253,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(254,'Grand Rights Classification','Grand Rights Classification Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'GrandRightsClassification NOT IN(''B'',''M'',''O'', '''')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(255,'Prior Approval Indicator','Prior Approval Indicator Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'PriorApprovalIndicator NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(256,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(257,'Licensing Status Of Commissioned Music','Licensing Status Of Commissioned Music Check', NULL,NULL,'DataQuality Format51a Line20',	1,	'LicensingStatusofCommissionedMusic NOT IN(''N'',''Y'') AND MusicCommissionFlag = ''Y''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(258,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
	    --(259,'Music Arranger Translator Editor etc','Music Arranger Translator Editor etc Check', NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicArrangerTranslatorEditor = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(260,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(261,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicPerformer = '''' AND MusicOriginClassification = ''C''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(262,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format51a Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'')',	NULL,	NULL,	NULL, NULL, 'Radio'),

		--Format 51a line 99


		(263,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format51a Line99',	1,	'NumberOfRecords IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio'),

			--Selector 1 Line 00

		(264, 'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality FormatS1 Line00',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),

			--Selector 1 Line 10

		(265,'Station Ref','Station Ref Check',NULL,NULL,'DataQuality FormatS1 Line10',	1,	'StationRef = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(266,'Transmission Schedule Date','Transmission Schedule Date Check',NULL,NULL,'DataQuality FormatS1 Line10',	1,	'TransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (267,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality FormatS1 Line10',	1,	'LTRIM(TransmissionTime) = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (268,'Standard Text','Standard Text Check',NULL,NULL,'DataQuality FormatS1 Line10',	1,	'StandardText = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(269,'Page Number','Page Number Check',NULL,NULL,'DataQuality FormatS1 Line10',	1,	'PageNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (270,'Selector Version','Selector Version Check',NULL,NULL,'DataQuality FormatS1 Line10',	1,	'SelectorVersion = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		
       
            --Selector 1 Line 20

	    (271,'Artist Name 1','Artist Name 1 Check', NULL,NULL,'DataQuality FormatS1 Line20',	1,	'ArtistName1 = '''' AND ArtistName2 <> ''News''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (272,'Artist Name 2','Artist Name 2 Check',NULL,NULL,'DataQuality FormatS1 Line20',	1,	'ArtistName2 = '''' AND ArtistName1 = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (273,'Music Title','Music Title Check',NULL,NULL,'DataQuality FormatS1 Line20',	1,	'MusicTitle = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (274,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality FormatS1 Line20',	1,	'MusicDuration = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		
		

			--Selector 2 Line 00

		--(275, 'Record Type','Record Type Check',NULL,NULL,'DataQuality FormatS2 Line00',	1,	'RecordType = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(276, 'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality FormatS2 Line00',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),

			--Selector 2 Line 10

		--(277,'Record Type','Record Type Check',NULL,NULL,'DataQuality FormatS2 Line10',	1,	'RecordType = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (278,'Transmission Schedule Date','Transmission Schedule Date Check',NULL,NULL,'DataQuality FormatS2 Line10',	1,	'TransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (279,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality FormatS2 Line10',	1,	'LTRIM(TransmissionTime) = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
       
            --Selector 2 Line 20

	    (280,'Music Title','Music Title Check', NULL,NULL,'DataQuality FormatS2 Line20',	1,	'MusicTitle= ''''',   NULL,	NULL,	NULL, NULL, 'Radio'),
        (281,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality FormatS2 Line20',	1,	'MusicPerformer = '''' AND MusicComposer = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(282,'Music Composer','Music Composer Check', NULL,NULL,'DataQuality FormatS2 Line20',	1,	'MusicComposer = '''' AND MusicPerformer = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
        (283,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality FormatS2 Line20',	1,	'MusicDuration= ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(284,'Music Type','Music Type Check',NULL,NULL,'DataQuality FormatS2 Line20',	1,	'MusicType= ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
     	(285,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality FormatS2 Line20',	1,	'MusicDuration = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		--Selector 2 Line 99
		
	  --(286,'Record Type','Record Type Check',NULL,NULL,'DataQuality FormatS2 Line99',	1,	'RecordType = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(287,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality FormatS2 Line99',	1,	'NumberOfRecords IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio'),
	
		-- Format 52R Line 10

		(288,'Series Indicator','Valid Series Indicator Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'SeriesIndicator NOT IN(''Y'', ''N'', '''')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(289,'Production/Series Name','Production/Series Name Mandatory Column Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ProductionName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(290,'Series Number','Series Number Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'SeriesIndicator = ''Y'' AND SeriesNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(291,'Episode Name','Episode Name Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(292,'Episode Number','Episode Number Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'SeriesIndicator = ''Y'' AND EpisodeNumber = '''' AND EpisodeName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(293,'Transmission Station','Transmission Station Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'TransmissionStation = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(294,'Daily Transmission Schedule Date','Daily Transmission Schedule Date Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'DailyTransmissionScheduleDate = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(295,'Transmission Time','Transmission Time Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'TransmissionTime = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(296,'Production Company','Production Company Population Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ProductionSourceIndicator = ''C'' AND ProductionCompany = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(297,'First Transmission Indicator','Valid First Transmission Indicator Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'FirstTransmissionIndicator NOT IN(''Y'', ''N'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		 --Reference rule previously removed as MDS not Radioailable.
		(298,'Music Content Indicator','Valid Music Content Indicator Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ENT.MusicContentIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.MusicContent MC ON ENT.MusicContentIndicator = MC.Code',	NULL, NULL, 'Radio'),
		(299,'Production Type','Valid Production Type Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ENT.ProductionType IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionType PT ON ENT.ProductionType = PT.Code',	NULL, NULL, 'Radio'),
		(300,'Production Source Indicator','Valid Production Source Indicator Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ENT.ProductionSourceIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.ProductionSource PS ON ENT.ProductionSourceIndicator = PS.Code',	NULL, NULL, 'Radio'),

		(301,'Local Network Indicator','Valid Local Network Indicator Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ENT.LocalNetworkIndicator IS NULL',NULL, 'LEFT JOIN MDS.mdm.LocalNetworkBroadcast LN ON ENT.LocalNetworkIndicator = LN.Code',	NULL, NULL, 'Radio'),
		(302,'Territory Code','Valid Territory Check',NULL,NULL,'DataQuality Format52R Line10',	1,	'ENT.TerritoryCode IS NULL',NULL, 'LEFT JOIN MDS.mdm.Territory T ON ENT.TerritoryCode = T.Code',	NULL, NULL, 'Radio'),
		
		-- Format 52R Line 20
		(303,'Production Reference Number','Production Reference Number Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'ProductionReferenceNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(304,'Music Item Sequence','Music Item Sequence Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicItemSequence = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(305,'Product Album Promo Title','Product Album Promo Title Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'ProductAlbumPromoTitle = '''' AND MusicOriginClassification IN(''C'',''L'')  AND ProductCatalogueNumber  = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(306,'Product Label','Product Label Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'ProductLabel = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(307,'Product Catalogue Number','Product Catalogue Number Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'ProductCatalogueNumber = '''' AND MusicOriginClassification IN(''C'',''L'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(308,'Music Duration','Music Duration Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'ISNULL(MusicDuration,0) <= 0',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(309,'Music Usage Classification','Music Usage Classification Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicUsageClassification NOT IN(''B'',''F'',''M'',''S'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(310,'Music Origin Classification','Music Origin Classification Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicOriginClassification NOT IN(''C'',''L'',''P'',''R'',''T'',''V'')',	NULL,	NULL,	NULL, NULL, 'Radio'),

		(311,'Music Commission Flag','Music Commission Flag Check',NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicCommissionFlag NOT IN(''N'',''Y'')',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(312,'Licensing Status Of Commissioned Music','Licensing Status Of Commissioned Music Check', NULL,NULL,'DataQuality Format52R Line20',	1,	'LicensingStatusofCommissionedMusic NOT IN(''N'',''Y'') AND MusicCommissionFlag = ''Y''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(313,'Music Composer/Author','Music Composer/Author Check', NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicComposerAuthor = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(314,'Music Publisher','Music Publisher Check', NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicPublisher = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(315,'Music Performer','Music Performer Check', NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicPerformer = '''' AND MusicOriginClassification = ''C''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		---(316,'Music Dubbing Flag','Music Dubbing Flag Check', NULL,NULL,'DataQuality Format52R Line20',	1,	'MusicDubbingFlag NOT IN(''Y'',''N'','''')',	NULL,	NULL,	NULL, NULL, 'Radio'),

		--Format 52R Line 00

		(317,'Extract Date','Extract Date Check',NULL,NULL,'DataQuality Format52R Line00',	1,	'ExtractDate IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(318,'Supplier Name','Supplier Name Check',NULL,NULL,'DataQuality Format52R Line00',	1,	'SupplierName = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(319,'Version Number','Version Number Check',NULL,NULL,'DataQuality Format52R Line00',	1,	'VersionNumber = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(320,'SupplierId','SupplierId Check',NULL,NULL,'DataQuality Format52R Line00',	1,	'SupplierId = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),
		(321,'Log Type','Log Type Check',NULL,NULL,'DataQuality Format52R Line00',	1,	'LogType = ''''',	NULL,	NULL,	NULL, NULL, 'Radio'),

		--Format 52 Line 99

		(322,'Number Of Records','Number Of Records Check',NULL,NULL,'DataQuality Format52R Line99',	1,	'RecordCount IS NULL',	NULL,	NULL,	NULL, NULL, 'Radio')


	) AS Src
	(
	   [ScreenId]
      ,[ScreenName]
      ,[ScreenDescription]
      ,[ProjectId]
      ,[EnvironmentId]
      ,[ObjectId]
      ,[ScreenSeverityID]
      ,[ScreenSQL]
	  ,[ReportSQL]
      ,[ScreenReferenceSQL]
      ,[ReportTableName]
	  ,[CleanseSQL]
	  ,[Domain]
	)
	ON Tgt.[ScreenId] = Src.[ScreenId]

-- Update matched rows
WHEN MATCHED THEN
UPDATE 
   SET [ScreenName] = src.ScreenName
      ,[ScreenDescription] = src.ScreenDescription
      ,[ProjectId] = src.ProjectId
      ,[EnvironmentId] = src.EnvironmentId
      ,[ObjectId] = src.ObjectId
      ,[ScreenSeverityID] = src.ScreenSeverityID
      ,[ScreenSQL] = src.ScreenSQL
      ,[ScreenReferenceSQL] = src.ScreenReferenceSQL
      ,[ReportSQL] = src.ReportSQL
      ,[ReportTableName] = src.ReportTableName
	  ,[CleanseSQL] = Src.[CleanseSQL]
	  ,[Domain] = Src.[Domain]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
	   [ScreenId]
      ,[ScreenName]
      ,[ScreenDescription]
      ,[ProjectId]
      ,[EnvironmentId]
      ,[ObjectId]
      ,[ScreenSeverityID]
      ,[ScreenSQL]
      ,[ScreenReferenceSQL]
      ,[ReportSQL]
      ,[ReportTableName]
	  ,[CleanseSQL]
	  ,[Domain]
		)
	VALUES
		(
		   src.[ScreenId]
		  ,src.[ScreenName]
		  ,src.[ScreenDescription]
		  ,src.[ProjectId]
		  ,src.[EnvironmentId]
		  ,src.[ObjectId]
		  ,src.[ScreenSeverityID]
		  ,src.[ScreenSQL]
		  ,src.[ScreenReferenceSQL]
		  ,src.[ReportSQL]
		  ,src.[ReportTableName]
		  ,src.[CleanseSQL]
		  ,src.[Domain]
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO

SET IDENTITY_INSERT DataQuality.Screen OFF;