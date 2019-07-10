SET IDENTITY_INSERT [Control].[CleanseRuleType] ON;
GO
MERGE INTO [Control].CleanseRuleType AS Tgt
USING 
	(VALUES
		(10, 'ReplaceWith'),
		(20, 'RemoveTrailing'),
		(30, 'ToUpper'),
		(40, 'ToLower'),
		(50, 'Capitalise'),
		(60, 'RemoveNonNumbers')
	) AS Src
	(
		  CleanseRuleTypeId
		 ,Name    
	)
	ON Tgt.CleanseRuleTypeId = Src.CleanseRuleTypeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		  Name = Src.Name

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			 CleanseRuleTypeId
			,Name      
		)
	VALUES
		(
			 Src.CleanseRuleTypeId
			,Src.Name 
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
GO

SET IDENTITY_INSERT [Control].CleanseRuleType OFF;
