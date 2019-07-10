SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
		(137,	NULL,	1,		1,		0,		N'ReportsText',								N'dxreportstext',						N'DX Reports Text',												N'DATAXCHANGE',			N'DX_REPORTS_TEXT',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(138,	NULL,	1,		1,		0,		N'ReportTypes',								N'dxreporttypes',						N'DX Report Types',												N'DATAXCHANGE',			N'DX_REPORT_TYPES',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME())
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
;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;


