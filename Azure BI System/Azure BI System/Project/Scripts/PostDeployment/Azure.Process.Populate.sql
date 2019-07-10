SET IDENTITY_INSERT [Azure].[Process] ON;
GO

MERGE INTO [Azure].[Process] AS Tgt
USING 
	(
	VALUES
		(1,'Financial Solution'		, 4),
		(2,'PlayToPay - PreShare'	, 3)
	) 
	AS Src
	(
		[ProcessId],
		[Name],
		[ApplicationId]
	)
	ON Tgt.[ProcessId] = Src.[ProcessId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET 
		[Name]			= Src.[Name],
		[ApplicationId]	= Src.[ApplicationId]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ProcessId],
			[Name],
			[ApplicationId]
		)
	VALUES
		(
			Src.[ProcessId],
			Src.[Name],
			Src.[ApplicationId]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Azure].[Process] OFF;