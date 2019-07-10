SET IDENTITY_INSERT [TabularControl].[Database] ON;
GO

MERGE INTO [TabularControl].[Database] AS Tgt
USING 
	(
	VALUES
		(1,'MemberStatementsDistributedRoyatlyIDQ', 'AZI-MS-SAS-U002:50502', 'AzureDataSource')
	) 
	AS Src
	(
		[DatabaseId],			
		[Name],			
		[ServerConnectionString],
		[DataSourceName]		
	)
	ON Tgt.[DatabaseId] = Src.[DatabaseId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]						= Src.[Name],     
		[ServerConnectionString]	= Src.[ServerConnectionString],
		[DataSourceName]			= Src.[DataSourceName]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[DatabaseId],			
		[Name],			
		[ServerConnectionString],
		[DataSourceName]	
	)
	VALUES
	(
		Src.[DatabaseId],			
		Src.[Name],			
		Src.[ServerConnectionString],
		Src.[DataSourceName]	
	)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

GO
SET IDENTITY_INSERT [TabularControl].[Database] OFF;