SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
		(1115,	NULL,	3,		1,		1,		N'DomesticUsageShares',		   				N'prbidomusageshares',    			    N'Oracle Stg.Domestic_Usage_Shares table',						N'PRBI_STAGING',	    N'DOM_USAGE_SHARES',       					N'jon.myers@prsformusic.com',	    SYSDATETIME()),
		(1116,	NULL,	3,		1,		1,		N'ForeignUsageShares',		   				N'prbiforusageshares',   			    N'Oracle Stg.Foreign_Usage_Shares table',						N'PRBI_STAGING',	    N'FOR_USAGE_SHARES',       					N'jon.myers@prsformusic.com',	    SYSDATETIME()),
		(1118,	NULL,	3,		1,		0,		N'ElementaryTerritories',		 			N'prbielementaryterritories',   		N'Oracle Stg.Elementary_Territories table',						N'PRBI_STAGING',	    N'ELEMENTARY_TERRITORIES',  				N'jon.myers@prsformusic.com',	    SYSDATETIME())
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


