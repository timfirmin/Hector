SET IDENTITY_INSERT [Azure].[NotificationReceipient] ON;
GO

MERGE INTO [Azure].[NotificationReceipient] AS Tgt
USING 
	(
	VALUES
		(1,'Piotr Starczynski'	, 'piotr.starczynski@prsformusic.com'	,1 ,1),
		(2,'Emma Steawart'		, 'emma.steawart@prsformusic.com'		,0 ,1)
	) 
	AS Src
	(
		[NotificationReceipientId],
		[Name],
		[Email],
		[Enabled],
		[Level]
	)
	ON Tgt.[NotificationReceipientId] = Src.[NotificationReceipientId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]		= Src.[Name],
		[Email]		= Src.[Email],
		[Enabled]	= Src.[Enabled],
		[Level]		= Src.[Level] 

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[NotificationReceipientId],
			[Name],
			[Email],
			[Enabled],
			[Level]
		)
	VALUES
		(
			Src.[NotificationReceipientId],
			Src.[Name],
			Src.[Email],
			Src.[Enabled],
			Src.[Level] 
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Azure].[NotificationReceipient] OFF;