/*
Recipients
Not template related at this stage. The [notification].[recipient] table stores all known recipients of any notification. 
This is the general directory of recipients for the notification system.
Mapping of recipients to a specific notification template is performed as a separate action.
*/
with Recipients as (
select	[recipientName],[recipientEmail],[friendlyName]
from (values ('Tony Wilkinson','tony.wilkinson@prsformusic.com','Tony')
			,('Senay Yilmaz','senay.yilmaz@prsformusic.com','Senay')
			,('Ian Norman','ian.norman@prsformusic.com','Ian')
			,('Tim Firmin','tim.firmin@prsformusic.com','Tim')
			,('Omoadoni Ayonote','Omoadoni.Ayonote@prsformusic.com','Doni')
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