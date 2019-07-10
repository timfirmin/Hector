SET IDENTITY_INSERT [Control].[EventActionType] ON;
GO
MERGE INTO [Control].[EventActionType] AS Tgt
USING 
	(VALUES
	--	EATId	Name		Description				CreatedBy						CreatedDate		UpdatedBy		UpdatedDate		RowVersion
		(10,	'Email',	'Send Notification',	'elliot.gross@prsformusic.com',	SYSDATETIME(),	SUSER_SNAME(),	SYSDATETIME(),	'0x00000000000117F5'),
		(20,	'Abort',	'Abort Batch',			'elliot.gross@prsformusic.com',	SYSDATETIME(),	SUSER_SNAME(),	SYSDATETIME(),	'0x00000000000117F6')

		) AS Src
	(
		[EventActionTypeId] 
		,[Name]              
		,[Description]       
		,[CreatedBy]         
		,[CreatedDate]       
		,[UpdatedBy]         
		,[UpdatedDate]       
		,[RowVersion]
	)
	ON Tgt.[EventActionTypeId] = Src.[EventActionTypeId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]				= Src.[Name] 
		,[Description]		= Src.[Description]
		,[UpdatedBy]        = Src.[UpdatedBy]
		,[UpdatedDate]      = Src.[UpdatedDate]
		,[RowVersion]		= Src.[RowVersion]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[EventActionTypeId] 
			,[Name]              
			,[Description]       
			,[CreatedBy]         
			,[CreatedDate]       
			,[UpdatedBy]         
			,[UpdatedDate]       
			,[RowVersion]	
		)
	VALUES
		(
			Src.[EventActionTypeId] 
			,Src.[Name]              
			,Src.[Description]       
			,Src.[CreatedBy]         
			,Src.[CreatedDate]       
			,Src.[UpdatedBy]         
			,Src.[UpdatedDate]       
			,Src.[RowVersion]	
		)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[EventActionType] OFF;

