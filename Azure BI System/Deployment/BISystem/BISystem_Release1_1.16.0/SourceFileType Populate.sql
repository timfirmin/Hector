SET IDENTITY_INSERT [Control].[SourceFileType] ON;
GO
MERGE INTO [Control].[SourceFileType] AS Tgt
USING 
	(VALUES
		(1, 'DX','DataXchange Distribution Context', 'DX Partition', 'Out',0,''),
		(2,'UNK','UNKNOWN','Unknown','OUT',0,'UNKNOWN'),
		(3,'SAS','SASOWN','SASOWN','OUT',0,''),
		(4,'PRBI','PRBI oracle data waehouse','PRBI','OUT',0,''),
		(5,'CODA','CODA Data Warehouse','CODA','OUT',0,''),
		(6,'TM1','TM1 Planning - Forecasts Budgets','TM1','OUT',0,''),
		(7,'MDS','MDS2016 File Load','MDS','OUT',0,''),
	    (8,'Online'	,'REP Transactional Files'				,'Online'		,'OUT'	,0	,''			)
		) AS Src
	(
		[SourceFileTypeId],	
		[Code],
		[Description],
		[Name],
		[Direction],
		[32BitStageRequired],
		[Collection]
	)
	ON Tgt.[SourceFileTypeId] = Src.[SourceFileTypeId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET	
		[Code]					= Src.[Code],
		[Description]			= Src.[Description],
		[Name]					= Src.[Name],
		[Direction]				= Src.[Direction],
		[32BitStageRequired]	= src.[32BitStageRequired],
		[Collection]			= src.[Collection]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[SourceFileTypeId],	
			[Code],
			[Description],
			[Name],
			[Direction],
			[32BitStageRequired],
			[Collection]          
		)
	VALUES
		(
			SRC.[SourceFileTypeId],	
			SRC.[Code],
			SRC.[Description],
			SRC.[Name],
			SRC.[Direction],
			SRC.[32BitStageRequired],
			SRC.[Collection]
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[SourceFileType] OFF;