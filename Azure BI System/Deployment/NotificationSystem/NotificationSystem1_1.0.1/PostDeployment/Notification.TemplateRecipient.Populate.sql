/*
Template Recipients
The [notification].[templateRecipient] table defines which recipients defines in the [notification].[recipient] table will receive the specified notification.
*/
with TemplateRecipients as (
select	[templateName],[recipientName]

from (values
             ('MDS Station Changes','Tony Wilkinson')
			,('MDS Station Changes','Omoadoni Ayonote')
			,('MDS Station Changes','Senay Yilmaz')
			,('MDS Station Changes','Tim Firmin')
			,('MDS Validation SDM','Tony Wilkinson')
			,('MDS Validation SDM','Omoadoni Ayonote')
            ,('MDS Validation SDM','Senay Yilmaz')
			,('MDS Validation SDM','Tim Firmin')
			,('MDS Validation Licencing','Tony Wilkinson')
			,('MDS Validation Licencing','Omoadoni Ayonote')
			,('MDS Validation Licencing','Senay Yilmaz')
			,('MDS Validation Licencing','Tim Firmin')
			,('MDS Validation BI','Tony Wilkinson')
			,('MDS Validation BI','Omoadoni Ayonote')
			,('MDS Validation BI','Senay Yilmaz')
			,('MDS Validation BI','Tim Firmin')
			,('MDS Supplied Station','Tony Wilkinson')
			,('MDS Supplied Station','Omoadoni Ayonote')
			,('MDS Supplied Station','Senay Yilmaz')
			,('MDS Supplied Station','Tim Firmin')
			,('Distribution Data Integration','Tony Wilkinson')
			,('Distribution Data Integration','Omoadoni Ayonote')
			,('Distribution Data Integration','Senay Yilmaz')
			,('Distribution Data Integration','Tim Firmin')
			,('Station UDC Validation','Tony Wilkinson')
			,('Station UDC Validation','Senay Yilmaz')
			,('Station UDC Validation','Tim Firmin')
			,('Station UDC Validation','Omoadoni Ayonote')
			,('Analogy Station Integration','Tony Wilkinson')
			,('Analogy Station Integration','Ian Norman')
			,('Analogy Station Integration','Senay Yilmaz')
			,('MDS Validation Finance','Tony Wilkinson')
			,('MDS Validation Finance','Ian Norman')
			,('MDS Validation Finance','Tim Firmin')
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


