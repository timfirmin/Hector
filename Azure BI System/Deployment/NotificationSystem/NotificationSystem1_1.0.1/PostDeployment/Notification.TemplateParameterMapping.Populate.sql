/*
Template Parameters
Notification templates contain placeholders in the content that are replaced with data items logged when a notification is requested.
The [notification].[template_parameter_mapping] defines the mapping between the content placeholders and the parameters that are logged when a notification is requested.
*/
with TemplateParameters as (
select	[templateName],[placeholder_name],[parameter_name],[parameter_ordinal]
from (values ('MDS Station Changes','#NewREP#','NNewREP',1)
            ,('MDS Station Changes','#NewCRM#','NNewCRM',2)
			,('MDS Station Changes','#NewMDS#','NNewMDS',3)
			,('MDS Station Changes','#UpdatedREP#','NUpdatedREP',4)
			--,('MDS Station Changes','#UpdatedCRM#','NUpdatedCRM',4)
			,('MDS Station Changes','#Date#','NDate',5)
			,('MDS Station Changes','#ReportLink#','NReportLink',6)
			,('MDS Validation SDM','#LicenceUpdate#','NLicenceUpdate',1)
			,('MDS Validation SDM','#AudioPolicyUpdates#','NAudioPolicyUpdates',2)
			,('MDS Validation SDM','#ValidationBreaks#','NValidationBreaks',3)
			,('MDS Validation SDM','#Date#','NDate',4)
			,('MDS Validation SDM','#ReportLink#','NReportLink',5)
			,('MDS Validation Licencing','#ValidationBreaks#','NValidationBreaks',1)
			,('MDS Validation Licencing','#LicenceFeeBreaks#','NLicenceFeeBreaks',2)
			,('MDS Validation Licencing','#AttributeMismatches#','NAttributeMismatches',3)
			,('MDS Validation Licencing','#Date#','NDate',4)
			,('MDS Validation Licencing','#ReportLink#','NReportLink',5)
			,('MDS Validation BI','#ValidationBreaks#','NValidationBreaks',1)
			,('MDS Validation BI','#Date#','NDate',2)
			,('MDS Validation BI','#ReportLink#','NReportLink',3)
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
			,('Station UDC Validation','#MDSREP#','NMDSREP',1)
			,('Station UDC Validation','#MDSDandM#','NMDSDandM',2)
			,('Station UDC Validation','#NotInMDS#','NNotInMDS',3)
			,('Station UDC Validation','#Date#','NDate',4)
			,('Station UDC Validation','#ReportLink#','NReportLink', 5)
            ,('Analogy Station Integration','#Updates#','NUpdates',1)
	       	,('Analogy Station Integration','#UnmatchedMasterStations#','NUnmatchedMasterStations',2)
			,('Analogy Station Integration','#UnmatchedAnalogyStations#','NUnmatchedAnalogyStations',3)
			,('Analogy Station Integration','#Date#','NDate',4)
			,('Analogy Station Integration','#ReportLink#','NReportLink',5)
			,('MDS Validation Finance','#NullEL2Codes#','NNullEL2Codes',1)
			,('MDS Validation Finance','#NullCodaCustomerCodes#','NNullCodaCustomerCodes',2)
			,('MDS Validation Finance','#Date#','NDate',3)
			,('MDS Validation Finance','#ReportLink#','NReportLink',4)
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
