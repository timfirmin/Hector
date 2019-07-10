/*
Template Parameters
Notification templates contain placeholders in the content that are replaced with data items logged when a notification is requested.
The [notification].[template_parameter_mapping] defines the mapping between the content placeholders and the parameters that are logged when a notification is requested.
*/
with TemplateParameters as (
select	[templateName],[placeholder_name],[parameter_name],[parameter_ordinal]
from (values ('MDS Master Station Validation','#ValidationBreaks#','NValidationBreaks',1)
			,('MDS Master Station Validation','#Date#','NDate',2)
			,('MDS Master Station Validation','#ReportLink#','NReportLink',3)
			,('Distribution Data Integration','#MusicMinutes#','NMusicMinutes',1)
			,('Distribution Data Integration','#MissingMinutes#','NMissingMinutes',2)
			,('Distribution Data Integration','#PublicReception#','NPublicReception',3)
			,('Distribution Data Integration','#Date#','NDate',4)
			,('Distribution Data Integration','#ReportLink#','NReportLink',5)
			,('MDS Supplied Station','#UnmatchedBARB#','NUnmatchedBARB',1)
			,('MDS Supplied Station','#UnmatchedRAJAR#','NUnmatchedRAJAR',2)
			,('MDS Supplied Station','#UnknownBARB#','NUnknownBARB',3)
			,('MDS Supplied Station','#UnknownRAJAR#','NUnknownRAJAR',4)
			,('MDS Supplied Station','#Date#','NDate',5)
			,('MDS Supplied Station','#ReportLink#','NReportLink',6)
			,('MDS Supplied Station','#DataSources#','NDataSources',7)
			,('Station UDC Validation','#UDCNew#','NUDCNew',1)
			,('Station UDC Validation','#UDCInactive#','NUDCInactive',2)
			,('Station UDC Validation','#UDCStationNew#','NUDCStationNew',3)
			,('Station UDC Validation','#UDCStationChange#','NUDCStationChange',4)
			,('Station UDC Validation','#Date#','NDate',5)
			,('Station UDC Validation','#ReportLink#','NReportLink',6)
            ,('Analogy Station Integration','#Updates#','NUpdates',1)
			,('Analogy Station Integration','#UnmatchedMasterStations#','NUnmatchedMasterStations',2)
			,('Analogy Station Integration','#UnmatchedAnalogyStations#','NUnmatchedAnalogyStations',3)
			,('Analogy Station Integration','#Date#','NDate',4)
			,('Analogy Station Integration','#ReportLink#','NReportLink',5)
			,('MDS Validation Finance','#NullCodaCustomerCodes#','NNullCodaCustomerCodes',2)
			,('MDS Validation Finance','#Date#','NDate',3)
			,('MDS Validation Finance','#ReportLink#','NReportLink',4)
			,('Distribution Data Integration End Batch','#MusicMinutes#','NMusicMinutes',1)
			,('Distribution Data Integration End Batch','#MissingMinutes#','NMissingMinutes',2)
			,('Distribution Data Integration End Batch','#PublicReception#','NPublicReception',3)
			,('Distribution Data Integration End Batch','#Date#','NDate',4)
			,('Distribution Data Integration End Batch','#ReportLink#','NReportLink',5)
	)p([templateName],[placeholder_name],[parameter_name],[parameter_ordinal])
)
merge [notification].[template_parameter_mapping] t
using (select t.[templateID][template_id],p.[placeholder_name],p.[parameter_name],p.[parameter_ordinal]
		from TemplateParameters p
		join [notification].[template] t on t.[templateName]=p.[templateName]) s ([template_id],[placeholder_name],[parameter_name],[parameter_ordinal])
on t.[template_id]=s.[template_id] and t.[placeholder_name]=s.[placeholder_name]

when not matched then
insert ([template_id],[placeholder_name],[parameter_name],[parameter_ordinal])
values (s.[template_id],s.[placeholder_name],s.[parameter_name],s.[parameter_ordinal])
when matched then update
set t.[parameter_name]=s.[parameter_name]
	,t.[parameter_ordinal]=s.[parameter_ordinal];
/* Template Parameters - End*/



