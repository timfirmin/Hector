SET IDENTITY_INSERT [Azure].[ComponentType] ON;
GO

MERGE INTO [Azure].[ComponentType] AS Tgt
USING 
	(
	VALUES
		(1,'Azure Data Warehouse'),
		(2,'Azure Virtual Machine')
	) 
	AS Src
	(
		[ComponentTypeId],
		[Name]
	)
	ON Tgt.[ComponentTypeId] = Src.[ComponentTypeId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE SET [Name] = Src.[Name]     

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ComponentTypeId],
			[Name]
		)
	VALUES
		(
			Src.[ComponentTypeId],	 
			Src.[Name]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Azure].[ComponentType] OFF;