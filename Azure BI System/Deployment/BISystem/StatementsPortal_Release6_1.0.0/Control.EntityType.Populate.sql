SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
		-- Statement Download (Under SAS Datafixes project)
		(1720,	-1,		8,		1,		0,		N'SASElectronicStmts',			            N'saselectronicstmts',	                N'SAS Electronic Statements table',							    N'SAS',					N'SAS_ELECTRONIC_STMTS',		     		N'chris.ellis@prsformusic.com',	    SYSDATETIME()),
		(1721,	-1,	    8,		1,		0,		N'SASElectronicStmtsPDF',					N'saselectronicstmtspdf',				N'SAS Electronic Statements PDF table',							N'SAS',		         	N'SAS_ELECTRONIC_STMTS_PDF',				N'chris.ellis@prsformusic.com',	    SYSDATETIME()),
	    (1722,	NULL,	8,		0,		0,		N'StatementFile',							N'StatementFile',						N'Statement File',											    N'Warehouse',			N'StatementFile',							N'chris.ellis@prsformusic.com',	    SYSDATETIME())

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
;
--  Delete rows that are in the target but not the source
/*
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;
*/


