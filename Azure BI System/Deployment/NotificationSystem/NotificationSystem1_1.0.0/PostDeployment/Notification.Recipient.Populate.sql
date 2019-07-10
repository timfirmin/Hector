SET IDENTITY_INSERT [notification].[recipient] ON;
GO
MERGE INTO [notification].[recipient] AS Tgt
USING 
	(VALUES

--	recipientID	recipientName	recipientEmail	friendlyName
	(1,	'Tony Wilkinson','tony.wilkinsonn@prsformusic.com',      	'Tony'),
	(2,	'Senay Yilmaz',	 'senay.yilmaz@prsformusic.com',          	'Senay'),
	(3,	'Ian Norman' ,   'ian.normann@prsformusic.com' ,'Ian')


	) AS Src
	(
		    [recipientID]
		   ,[recipientName]
           ,[recipientEmail]
           ,[friendlyName]
          
	)
	ON Tgt.recipientID = Src.recipientID

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		--recipientID	=	SRC.recipientID,
		recipientName	=	SRC.recipientName,
		recipientEmail	=	SRC.recipientEmail,
		friendlyName	=	SRC.friendlyName

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			recipientID
		   ,recipientName
           ,recipientEmail
           ,friendlyName
          	
		)
	VALUES
		(
			SRC.recipientID
		   ,SRC.recipientName
           ,SRC.recipientEmail
           ,SRC.friendlyName
        
		)


WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [notification].[recipient] OFF;

