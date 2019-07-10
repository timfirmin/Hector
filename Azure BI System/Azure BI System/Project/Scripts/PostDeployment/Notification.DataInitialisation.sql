--this data initialisation is a temporary solution during development in lieu of an admin application
merge [notification].[template] t
using ( values ('Notification Service Test Email','INFO',1,'$(MailProfile)','Hi %recipientList%,','This is test body text','Regards, PRS BI Team')
				,('MDS Station Changes','INFO',1,'$(MailProfile)','Hi %recipientList%,',NULL,'Regards, PRS BI Team')
	) s ([templateName],[category],[enabled],[profileName],[greeting],[bodyText],[signature])
ON t.[templateName]=s.[templateName]
when not matched then
insert ([templateName],[category],[enabled],[profileName],[greeting],[bodyText],[signature])
values (s.[templateName],s.[category],s.[enabled],s.[profileName],s.[greeting],s.[bodyText],s.[signature])

when matched then update
set [category]=s.[category]
	,[enabled]=s.[enabled]
	,[profileName]=s.[profileName]
	,[greeting]=s.[greeting]
	,[bodyText]=s.[bodyText]
	,[signature]=s.[signature];

merge [notification].[recipient] t
using ( values ('Tony Wilkinson','tony.wilkinson@prsformusic.com','Tony')
				,('Senay Yilmaz','senay.yilmaz@prsformusic.com','Senay')
				,('Ian Norman','ian.norman@prsformusic.com','Ian')
	) s ([recipientName],[recipientEmail],[friendlyName])
on t.[recipientEmail]=s.[recipientEmail]
when not matched then
insert ([recipientName],[recipientEmail],[friendlyName])
values (s.[recipientName],s.[recipientEmail],s.[friendlyName])
when matched then update
set [recipientName]=s.[recipientName],[friendlyName]=s.[friendlyName];


merge [notification].[templateRecipient] t
using (
		select [templateID],[recipientID]
		from [notification].[recipient] r,[notification].[template] t
		where t.[templateName]='Notification Service Test Email'
		and r.recipientName in ('Tony Wilkinson')
		union
		select [templateID],[recipientID]
		from [notification].[recipient] r,[notification].[template] t
		where t.[templateName]='MDS Station Changes'
		and r.recipientName in ('Tony Wilkinson','Senay Yilmaz','Ian Norman')
		) s ([templateID],[recipientID])
on t.[templateID]=s.[templateID] and t.[recipientID]=s.[recipientID]
when not matched by target then
insert ([templateID],[recipientID])
values (s.[templateID],s.[recipientID])
when not matched by source then delete;