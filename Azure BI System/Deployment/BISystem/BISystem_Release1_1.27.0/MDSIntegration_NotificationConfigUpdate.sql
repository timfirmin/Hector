/*************************************************************************************************************
date: 28/05/2019
author: tony wilkinson
description: notification config update to include email distribution lists for Abacus Data Hub notifications
*************************************************************************************************************/

--bi system notification data configuration
with Recipients as (
select	[recipientName],[recipientEmail],[friendlyName]
from (values ('Abacus (Licensing)','AbacusLicensing@prsformusic.com','Licensing')
			,('Abacus (Service Delivery)','AbacusServiceDelivery@prsformusic.com','Service Delivery')
            ,('Abacus (Operational Assurance)','AbacusOperationalAssurance@prsformusic.com','Operational Assurance')
	)r([recipientName],[recipientEmail],[friendlyName])
)
merge [notification].[recipient] t
using Recipients s
on t.[recipientEmail]=s.[recipientEmail]

when not matched by target then
insert ([recipientName],[recipientEmail],[friendlyName])
values (s.[recipientName],s.[recipientEmail],s.[friendlyName])

when matched then 
update set	t.[recipientName]=s.[recipientName]
			,t.[friendlyName]=s.[friendlyName];


/*
Template Recipients
The [notification].[templateRecipient] table defines which recipients defines in the [notification].[recipient] table will receive the specified notification.
*/
with TemplateRecipients as (
select	[templateName],[recipientName]

from (values ('MDS Supplied Station','Abacus (Licensing)')
			,('MDS Master Station Validation','Abacus (Licensing)')
			,('MDS Master Station Validatione','Abacus (Service Delivery)')
			,('MDS Master Station Validation','Abacus (Operational Assurance)')
		) r ([templateName],[recipientName])
)
merge [notification].[templateRecipient] t
using (select [templateID],[recipientID]
		from	TemplateRecipients s
		join	[notification].[template] t on t.[templateName]=s.[templateName]
		join	[notification].[recipient] r on r.[recipientName]=s.[recipientName]) s ([templateID],[recipientID])
on t.[templateID]=s.[templateID] and t.[recipientID]=s.[recipientID]
when not matched then 
insert ([templateID],[recipientID])
values (s.[templateID],s.[recipientID]);

