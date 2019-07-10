/*
Recipients
Not template related at this stage. The [notification].[recipient] table stores all known recipients of any notification. 
This is the general directory of recipients for the notification system.
Mapping of recipients to a specific notification template is performed as a separate action.
*/
with Recipients as (
select	[recipientName],[recipientEmail],[friendlyName]
from (values ('Tony Wilkinson','tony.wilkinson@prsformusic.com','Tony')
			,('Nathalie Carlberg','nathalie.carlberg@prsformusic.com','Nathalie')
			,('Victor Mendes','victor.mendes@prsformusic.com','Victor')
			,('Tim Firmin','tim.firmin@prsformusic.com','Tim')
			--,('Omoadoni Ayonote','Omoadoni.Ayonote@prsformusic.com','Doni')
            ,('Emma Williams','emma.williams@prsformusic.com','Emma')
            ,('Steve Webb','Steve.Webb@prsformusic.com','steve')
            ,('Daniel Weerawardena','Daniel.Weerawardena@prsformusic.com','Daniel')
	)r([recipientName],[recipientEmail],[friendlyName])
)
merge [notification].[recipient] t
using Recipients s
on t.[recipientEmail]=s.[recipientEmail]

when not matched then
insert ([recipientName],[recipientEmail],[friendlyName])
values (s.[recipientName],s.[recipientEmail],s.[friendlyName])

when matched then 
update set	t.[recipientName]=s.[recipientName]
			,t.[friendlyName]=s.[friendlyName];
/*
Recipients - End
*/















--SET IDENTITY_INSERT [notification].[recipient] ON;
--GO
--MERGE INTO [notification].[recipient] AS Tgt
--USING 
--	(VALUES

----	recipientID	recipientName	recipientEmail	friendlyName
--	(1,	'Tony Wilkinson','tony.wilkinsonn@prsformusic.com',      	'Tony'),
--	(2,	'Senay Yilmaz',	 'senay.yilmaz@prsformusic.com',          	'Senay'),
--	(3,	'Ian Norman' ,   'ian.normann@prsformusic.com' ,'Ian')


--	) AS Src
--	(
--		    [recipientID]
--		   ,[recipientName]
--           ,[recipientEmail]
--           ,[friendlyName]
          
--	)
--	ON Tgt.recipientID = Src.recipientID

---- Update matched rows
--WHEN MATCHED THEN
--	UPDATE
--	SET
		
--		recipientName	=	SRC.recipientName,
--		recipientEmail	=	SRC.recipientEmail,
--		friendlyName	=	SRC.friendlyName

---- Insert new rows
--WHEN NOT MATCHED BY TARGET THEN
--	INSERT
--		(
--			recipientID
--		   ,recipientName
--           ,recipientEmail
--           ,friendlyName
          	
--		)
--	VALUES
--		(
--			SRC.recipientID
--		   ,SRC.recipientName
--           ,SRC.recipientEmail
--           ,SRC.friendlyName
        
--		)


--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;
--GO
--SET IDENTITY_INSERT [notification].[recipient] OFF;

