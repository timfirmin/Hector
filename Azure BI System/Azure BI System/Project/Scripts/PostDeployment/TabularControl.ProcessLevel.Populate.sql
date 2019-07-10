SET IDENTITY_INSERT [TabularControl].[ProcessLevel] ON;
GO

MERGE INTO [TabularControl].[ProcessLevel] AS Tgt
USING 
	(
	VALUES
		(1,'Table'),
		(2,'Partition')
	) 
	AS Src
	(
		[ProcessLevelId],
		[Name]
	)
	ON Tgt.[ProcessLevelId] = Src.[ProcessLevelId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET  
		[Name] = Src.[Name]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[ProcessLevelId],
		[Name]
	)
	VALUES
	(
		Src.[ProcessLevelId],    
		Src.[Name]
	)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

GO
SET IDENTITY_INSERT [TabularControl].[ProcessLevel] OFF;