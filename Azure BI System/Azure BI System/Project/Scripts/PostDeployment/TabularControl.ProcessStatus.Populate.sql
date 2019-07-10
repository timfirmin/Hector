SET IDENTITY_INSERT [TabularControl].[ProcessStatus] ON;
GO

MERGE INTO [TabularControl].[ProcessStatus] AS Tgt
USING 
	(
	VALUES
		(1,'ToBeCreated'),
		(2,'New'),
		(3,'Dirty'),
		(4,'Processed'),
		(5,'ToBeDeleted'),
		(6,'Deleted')
	) 
	AS Src
	(
		[ProcessStatusId],
		[Name]
	)
	ON Tgt.[ProcessStatusId] = Src.[ProcessStatusId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name] = Src.[Name]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[ProcessStatusId],
		[Name]
	)
	VALUES
	(
		Src.[ProcessStatusId],    
		Src.[Name]
	)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

GO
SET IDENTITY_INSERT [TabularControl].[ProcessStatus] OFF;