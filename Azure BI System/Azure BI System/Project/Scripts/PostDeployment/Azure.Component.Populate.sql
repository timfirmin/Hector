SET IDENTITY_INSERT [Azure].[Component] ON;
GO

MERGE INTO [Azure].[Component] AS Tgt
USING 
	(
	VALUES
		(1,'BI-ADW-U01'		, 'AZP-RG-SQL'		,'BI-ADW-U01', 'AZP-MS-SQL-U001'	, 'BI-ADW-U01'		,	1),
		(2,'AZI-MS-SIS-U001', 'AZI-RG-WINDOWS'	, NULL		 , 'AZI-MS-SIS-U001'	, 'AZI-MS-SIS-U001'	,	2),
		(3,'AZI-MS-SAS-U002', 'AZI-RG-WINDOWS'	, NULL		 , 'AZI-MS-SAS-U002'	, 'AZI-MS-SAS-U002'	,	2)
	) 
	AS Src
	(
		[ComponentId],
		[Name],
		[ResourceGroup],
		[DatabaseName],
		[ServerName],
		[ComponentTag],
		[TypeId]    
	)
	ON Tgt.[ComponentId] = Src.[ComponentId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]			= Src.[Name],
		[ResourceGroup]	= Src.[ResourceGroup],
		[DatabaseName]	= Src.[DatabaseName],
		[ServerName]	= Src.[ServerName],
		[ComponentTag]	= Src.[ComponentTag],
		[TypeId]		= Src.[TypeId] 

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ComponentId],
			[Name],
			[ResourceGroup],
			[DatabaseName],
			[ServerName],
			[ComponentTag],
			[TypeId]  
		)
	VALUES
		(
			Src.[ComponentId],
			Src.[Name],
			Src.[ResourceGroup],
			Src.[DatabaseName],
			Src.[ServerName],
			Src.[ComponentTag],
			Src.[TypeId] 	 
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Azure].[Component] OFF;