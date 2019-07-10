SET IDENTITY_INSERT [Azure].[Jobs] ON;
GO

MERGE INTO [Azure].[Jobs] AS Tgt
USING 
	(
	VALUES
		(1,'Financial Solution Load' ,  'Finance Solution' ,  'This is the load from Coda into our financial solution in Azure' , 'ETL' , 'Finance' , '4')
	) 
	AS Src
	(
		[JobId],      
		[JobName], 
		[JobShortName],     
		[JobDescription], 
		[JobType],
		[RunbookName],
		[ApplicationId]
	)
	ON Tgt.[JobId] = Src.[JobId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[JobName]			= Src.[JobName],     
		[JobShortName]		= Src.[JobShortName],
		[JobDescription]	= Src.[JobDescription], 
		[JobType]			= Src.[JobType],
		[RunbookName]		= Src.[RunbookName],
		[ApplicationId]		= Src.[ApplicationId]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[JobId],      
			[JobName],
			[JobShortName],      
			[JobDescription], 
			[JobType],
			[RunbookName],
			[ApplicationId]
		)
	VALUES
		(
			Src.[JobId],	 
			Src.[JobName], 
			Src.[JobShortName],    
			Src.[JobDescription],
			Src.[JobType],
			Src.[RunbookName],
			Src.[ApplicationId]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Azure].[Jobs] OFF;