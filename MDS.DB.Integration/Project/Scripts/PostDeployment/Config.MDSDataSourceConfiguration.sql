-- select * from [Config].[MDSDataSourceConfiguration]
SET IDENTITY_INSERT [Config].[MDSDataSourceConfiguration] ON;
GO
MERGE INTO [Config].[MDSDataSourceConfiguration] AS Tgt
USING 
	(VALUES
	  --[Id], [MDSEntity], [DataSource], [DataSourceType]
		(1, N'MasterStation', N'REP', N'P'),
		(2, N'MasterStation', N'CRM', N'S'),
		(3, N'MasterStation', N'BARB', N'S'),
		(4, N'MasterStation', N'RAJAR', N'S')
	) AS Src
	(
	 [Id]
	,[MDSEntity]
	,[DataSource]
	,[DataSourceType]
	)
	ON Tgt.[Id] = Src.[Id]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[MDSEntity]				= Src.[MDSEntity],
		[DataSource]			= Src.[DataSource],
		[DataSourceType]		= Src.[DataSourceType]

WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			 [Id]
			,[MDSEntity]
			,[DataSource]
			,[DataSourceType]
		)
	VALUES
		(
		 SRC.[Id]
		,SRC.[MDSEntity]
		,SRC.[DataSource]
		,SRC.[DataSourceType]
		)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Config].[MDSDataSourceConfiguration] OFF;


