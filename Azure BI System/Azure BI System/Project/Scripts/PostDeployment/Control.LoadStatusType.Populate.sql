SET IDENTITY_INSERT [Control].[LoadStatusType] ON;
GO
MERGE INTO [Control].[LoadStatusType] AS Tgt
USING 
	(VALUES
		(1,'In Progress','Load In Progress','InProgress','PostDeployment Script', SYSDATETIME()),
		(2,'Successful','Load Completed Successfully','Success','PostDeployment Script',SYSDATETIME()),
		(3,'Failed','Load Failed','Failed','PostDeployment Script',SYSDATETIME()),
		(4,'Reset','Load flagged for reset','Reset','PostDeployment Script',SYSDATETIME()),
		(5,'Already Run','Load Already Run','AlreadyRun','PostDeployment Script',SYSDATETIME())
	) AS Src
	(
		[LoadStatusTypeId],
		[Name],
		[Description],
		[ShortName],
		[UpdateUser],
		[UpdateTime]
	)
	ON Tgt.[LoadStatusTypeId] = Src.[LoadStatusTypeId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]			   = Src.[Name],
		[Description]	   = Src.[Description],
		[ShortName]		   = src.[ShortName],
		[UpdateUser]	   = Src.[UpdateUser],
		[UpdateTime]	   = Src.[UpdateTime]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[LoadStatusTypeId],
			[Name],			
			[Description],	
			[ShortName],		
			[UpdateUser],		
			[UpdateTime]	
		)
	VALUES
		(
			Src.[LoadStatusTypeId],
			Src.[Name],			
			Src.[Description],	
			src.[ShortName],		
			src.[UpdateUser],		
			src.[UpdateTime]	
		)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[LoadStatusType] OFF;

