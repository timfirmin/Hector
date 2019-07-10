SET IDENTITY_INSERT [TabularControl].[ModelTable] ON;
GO

MERGE INTO [TabularControl].[ModelTable] AS Tgt
USING 
	(
	VALUES
		(1,	1,	1,	'Adustment Reason',		'Y'),
		(2,	1,	1,	'Distribution',			'Y'),
		(3,	1,	2,	'Distribution Royalty',	'N')
	) 
	AS Src
	(
		 [ModelTableId],
		 [DatabaseId],
		 [ProcessLevelId],
		 [TableName],
		 [IsDimensionYN]
	)
	ON Tgt.[ModelTableId] = Src.[ModelTableId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[DatabaseId]	= Src.[DatabaseId],
		[ProcessLevelId]= Src.[ProcessLevelId],
		[TableName]		= Src.[TableName],	
		[IsDimensionYN]	= Src.[IsDimensionYN]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[ModelTableId],
		[DatabaseId],
		[ProcessLevelId],
		[TableName],
		[IsDimensionYN]
	)
	VALUES
	(
		Src.[ModelTableId],	
		Src.[DatabaseId],
		Src.[ProcessLevelId],
		Src.[TableName],	
		Src.[IsDimensionYN]
	)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

GO
SET IDENTITY_INSERT [TabularControl].[ModelTable] OFF;