/*
Template Recipients
The [notification].[templateRecipient] table defines which recipients defines in the [notification].[recipient] table will receive the specified notification.
*/
with TemplateRecipients as (
select	[templateName],[recipientName]

from (values
			 ('MDS Master Station Validation','Tony Wilkinson')
			,('MDS Master Station Validation','Nathalie Carlberg')
			,('MDS Master Station Validation','Victor Mendes')
			,('MDS Master Station Validation','Tim Firmin')
            ,('MDS Master Station Validation','Emma Williams')
			,('MDS Supplied Station','Tony Wilkinson')
			,('MDS Supplied Station','Nathalie Carlberg')
			,('MDS Supplied Station','Victor Mendes')
			,('MDS Supplied Station','Tim Firmin')
            ,('MDS Supplied Station','Emma Williams')
			,('Distribution Data Integration','Tony Wilkinson')
			,('Distribution Data Integration','Nathalie Carlberg')
			,('Distribution Data Integration','Victor Mendes')
			,('Distribution Data Integration','Tim Firmin')
            ,('Distribution Data Integration','Emma Williams')
			,('Station UDC Validation','Tony Wilkinson')
			,('Station UDC Validation','Nathalie Carlberg')
			,('Station UDC Validation','Victor Mendes')
			,('Station UDC Validation','Tim Firmin')
            ,('Station UDC Validation','Emma Williams')
			,('Analogy Station Integration','Tony Wilkinson')
			,('Analogy Station Integration','Victor Mendes')
			,('Analogy Station Integration','Nathalie Carlberg')
            ,('Analogy Station Integration','Emma Williams')
			,('MDS Validation Finance','Tony Wilkinson')
			,('MDS Validation Finance','Victor Mendes')
			,('MDS Validation Finance','Nathalie Carlberg')
			,('MDS Validation Finance','Tim Firmin')
            ,('MDS Validation Finance','Emma Williams')
			,('Distribution Data Integration End Batch','Steve Webb')
			,('Distribution Data Integration End Batch','Daniel Weerawardena')
			,('Analogy Station Integration','Steve Webb')
			,('Analogy Station Integration','Daniel Weerawardena')
			,('MDS Validation Finance','Steve Webb')
			,('MDS Validation Finance','Daniel Weerawardena')
			,('Distribution Data Integration End Batch','Steve Webb')
			,('Distribution Data Integration End Batch','Daniel Weerawardena')
			,('Station UDC Validation','Steve Webb')
            ,('Station UDC Validation','Daniel Weerawardena')

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

