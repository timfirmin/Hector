PRINT N'Populate [Control].[EntityType] for Case QC...'

SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],								[Description],											[Schema],				[Table],									[CreatedBy]							[CreatedDate]
-- CaseQC
		(1140,	NULL,	15,		1,		0,		N'CueLevel',							   N'CaseQCstgCueLevel',				   N'CaseQC Stg Cue Level',											N'CaseQC',		        N'CueLevel',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1141,	NULL,	15,		1,		0,		N'WorkLevel',							   N'CaseQCstgCWorkLevel',				   N'CaseQC Stg Work Level',						   				N'CaseQC',		     	N'WorkLevel',	       	            	    N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1142,	NULL,	15,		1,		0,		N'ProductionLevel',		                   N'CaseQCstgCProductionLevel',	       N'CaseQC Stg Production Level',                         			N'CaseQC',			    N'ProductionLevel',	      	             	N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1143,	NULL,	15,		1,		0,		N'TrnCueLevel',							   N'CaseQCtrnCueLevel',				   N'CaseQC Trn Cue Level',											N'dbo',					N'CueLevel',								N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1144,	NULL,	15,		1,		0,		N'TrnWorkLevel',						   N'CaseQCtrnCWorkLevel',				   N'CaseQC Trn Work Level',						   				N'dbo',		     		N'WorkLevel',	       	            	    N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1145,	NULL,	15,		1,		0,		N'TrnProductionLevel',		               N'CaseQCtrnCProductionLevel',	       N'CaseQC Trn Production Level',                        			N'dbo',					N'ProductionLevel',	      	             	N'vandana.bangera@prsformusic.com',		SYSDATETIME()),
		(1146,	NULL,	15,		1,		0,		N'TrnCaseHeader',						   N'CaseQCtrnCases',					   N'CaseQC Trn case header',                        				N'dbo',					N'Cases',	      	             			N'vandana.bangera@prsformusic.com',		SYSDATETIME())



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

--  Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;



PRINT N'Populate [Control].[Application] for Case QC...'

SET IDENTITY_INSERT [Control].[Application] ON;
GO
MERGE INTO [Control].[Application] AS Tgt
USING 
	(VALUES
	-- 	[ApplicationId],[Name],												[Code],			[Description],													  [Priority],	[UpTimeHours],	[ETLType],	[WarehouseType],[Prefix],	[CreatedDate]
		(15,			'Case Management',									'CASEQCDQ',		'Case Management Quality Check',										null,	 null,			null,		'DataMart',		'CaseQC',  	SYSDATETIME())

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
--  Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;
GO
SET IDENTITY_INSERT [Control].[Application] OFF;

