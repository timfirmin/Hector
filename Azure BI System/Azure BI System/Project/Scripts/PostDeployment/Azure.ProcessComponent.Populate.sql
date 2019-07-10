
MERGE INTO [Azure].[ProcessComponent] AS Tgt
USING 
	(
	VALUES
		(1,1),
		(1,2),
		(1,3),
		(2,1),
		(2,2)
	) 
	AS Src
	(
		[ProcessId],
		[ComponentId]
	)
	ON	Tgt.[ProcessId]		= Src.[ProcessId]
	AND Tgt.[ComponentId]	= Src.[ComponentId]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ProcessId],
			[ComponentId]
		)
	VALUES
		(
			Src.[ProcessId],
			Src.[ComponentId]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
