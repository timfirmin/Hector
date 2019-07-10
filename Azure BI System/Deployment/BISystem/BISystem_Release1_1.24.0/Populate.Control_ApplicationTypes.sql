SET IDENTITY_INSERT [Control].[Application] ON;
GO
MERGE INTO [Control].[Application] AS Tgt
USING 
	(VALUES
	-- 	[ApplicationId],[Name],												[Code],			[Description],													  [Priority],	[UpTimeHours],	[ETLType],	[WarehouseType],[Prefix],	[CreatedDate]
	
		(18,			'TM1 Data Integrations - FDM/Hector2',				'TM1FDM',		'TM1 Data Integration to Finance Data Mart and Hector 2 Apps',			null,	 null,			null,		'DataMart',		'TM1FDM',	SYSDATETIME()),
		(19,			'MDS Integration',									'MDSI',		    'Master Data Systems Data Integration',									null,	 null,			null,		'DataMart',		'MDSI',	    SYSDATETIME()),
		(20,			'FPV Application / Integration',					'FPV',		    'FPV Application and Integration Systems',								null,	 null,			null,		'DataMart',		'FPV',		SYSDATETIME()),
		(21,			'DDI - Distribution Data Integration',				'DDI',		    'DDI - Distribution Data Integration',									null,	 null,			null,		'DataMart',		'DDI',	    SYSDATETIME())
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
;
--  Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;
GO
SET IDENTITY_INSERT [Control].[Application] OFF;

