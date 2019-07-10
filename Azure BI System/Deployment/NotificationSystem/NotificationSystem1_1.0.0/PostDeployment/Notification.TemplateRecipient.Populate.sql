--SET IDENTITY_INSERT [notification].[templateRecipient] ON;
GO
MERGE INTO [notification].[templateRecipient] AS Tgt
USING 
	(VALUES

--	templateID	recipientID
	(1,1),
	(2,	1),
	(2,	2),
	(2,	3),
	(3,	2)


	) AS Src
	(
		    templateID
		   ,recipientID
         
	)
	ON Tgt.templateID = Src.templateID and Tgt.recipientID = Src.recipientID

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		templateID	        =	SRC.templateID,
		recipientID	       =	SRC.recipientID

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			templateID
		   ,recipientID         	
		)
	VALUES
		(
			SRC.templateID
		   ,SRC.recipientID
        
		)


WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
--SET IDENTITY_INSERT [notification].[templateRecipient] OFF;

