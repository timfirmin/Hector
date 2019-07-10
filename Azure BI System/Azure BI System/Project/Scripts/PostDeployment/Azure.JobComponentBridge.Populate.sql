MERGE INTO [Azure].[JobComponentBridge] AS Tgt
USING 
	(
	VALUES
		(1 ,3 ),
		(1 ,10),
		(1 ,5 ),
		(1 ,7 ),
		(1 ,6 )
	) 
	AS Src
	(
		[JobId],      
		[ComponentId]
	)
	ON Tgt.[JobId] = Src.[JobId] AND Tgt.[ComponentId] = Src.[ComponentId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[JobId]				= Src.[JobId],     
		[ComponentId]		= Src.[ComponentId]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[JobId],      
			[ComponentId]
		)
	VALUES
		(
			Src.[JobId],	 
			Src.[ComponentId]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
