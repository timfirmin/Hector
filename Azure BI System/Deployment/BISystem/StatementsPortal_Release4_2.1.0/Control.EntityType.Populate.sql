SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
 -- MSW	
		(180,	NULL,	1,		0,		0,		N'TempPayeeStatementSociety',			   N'TempPayeeStatementSociety',	       N'Temp Payee Statement Society table',							N'Transform',			N'TempPayeeStatementSociety',				N'Chris.Ellis@prsformusic.com',	    SYSDATETIME())
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


