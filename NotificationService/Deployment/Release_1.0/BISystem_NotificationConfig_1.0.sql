--bi system notification data configuration
with Recipients as (
select	[recipientName],[recipientEmail],[friendlyName]
from (values ('Tony Wilkinson','tony.wilkinson@prsformusic.com','Tony')
			,('Ian Norman','ian.norman@prsformusic.com','Ian')
			,('Tim Firmin','tim.firmin@prsformusic.com','Tim')
            ,('Emma Williams','emma.williams@prsformusic.com','Emma')
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
NotificationTemplates
A template is required for each notification the system will send.
This table defines the name of the template and the content, including placeholders. When a notification is processed, the placeholders are replaced with items of data that are
logged when the notification is requested.   
*/
with NotificationTemplate as (
select [templateName],[category],[enabled],[profileName],[greeting],[bodyText],[signature]
from (values 
 ('MDS Station Changes','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr>    <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers-->      <!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;">      <p><h3>Master Station Data Changes from REP & CRM #Date#</h3>         <font size="2">         <p>&nbsp;</p>        <strong>New Stations REP: #NewREP# </strong>        <br>These station(s) have been added to MDS. Please review and update outstanding fields.</br>        <p>&nbsp;</p>    <strong>New Stations CRM: #NewCRM# </strong>        <br>These station(s) have been added to MDS. Please review and update outstanding fields.</br>        <p>&nbsp;</p>  <strong>New Stations MDS: #NewMDS# </strong>   <br>These station(s) have been added in MDS but dont exist in REP. Please review and update outstanding fields.</br>        <p>&nbsp;</p>   <strong>Updates to existing stations from REP: #UpdatedREP# </strong>        <br>These changes are pending approval. Please make the necessary changes to either the master data in MDS, or the source data in REP.</br> </tr>  <tr>    <td align="center"  bgcolor="white" >Full details about these pending changes<br><a href=#ReportLink#>MDS Station Changes</a></br> <br> <font size="2" >In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</font></br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('MDS Validation SDM','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>MDS Validation Report #Date#</h3>  <p>&nbsp;</p><br>This is the daily MDS validation notification which provides alerting to potential invalid data conditions within MDS.</br>  <br>#LicenceUpdate# Licence group update(s) has been made to the MDS.</br><br>#AudioPolicyUpdates# Audio Policy update(s) has been made the MDS.</br><br>#ValidationBreaks# station(s) breaks Validation Rule.</br></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Validation Report (SDM)</a></br>  <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br> </tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('MDS Validation Licensing','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>MDS Validation Report #Date#</h3>    <p>&nbsp;</p><br>This is the daily MDS validation notification which provides alerting to potential invalid data conditions within MDS.</br>     <br>#ValidationBreaks# station(s) breaks Validation Rule.</br><br>#LicenceFeeBreaks# Licence Fee(s) was validated.</br><br>#AttributeMismatches# mapped licence attribute does not match with MDS counterpart.</br></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Validation Report (Licensing)</a></br>  <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('MDS Validation BI','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>MDS Validation Report #Date#</h3>         <p>&nbsp;</p><strong>This is the daily MDS validation notification which provides alerting to potential invalid data conditions within MDS.</strong>  <p>&nbsp;</p> <br>#ValidationBreaks# station(s) breaks Validation Rule.</br></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Validation Report (BI)</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br> </tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('Distribution Data Integration','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>Distribution Data Integration #Date#</h3></p><br>#MusicMinutes# unmatched/unknown station(s) have been identified in Music Minutes.</br><br>#MissingMinutes# unmatched/unknown station(s) have been identified in Missing Minutes.</br><br>#PublicReception# unmatched/unknown station(s) have been identified in Public Reception.</br>   <br>Please review station(s) listed on the detail report and add to Master Data / remove from source file where appropriate.</br><br></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>Distributed Data Integration</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br> </tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('MDS Supplied Station','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>Issues found when updating MDS from external data sources (BARB;RAJAR) #Date#</h3></p><br>#UnmatchedBARB# Unmatched BARB station(s).</br><br>#UnmatchedRAJAR# Unmatched RAJAR station(s).</br>  <br><font size="2" >(A station is unmatched when a new station from source file has not been previously matched to MDS)</font></br><br>#UnknownBARB# Unknown BARB station(s).</br><br>#UnknownRAJAR# Unknown RAJAR station(s).</br><br><font size="2" >(A station is unknown when it is marked as unknown by a user)</font></br>   </p></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Supplied Station</a></br> <br><font size="2" >In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</font></br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('Station UDC Validation','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>Station UDC Changes #Date#</h3></p><br>#MDSREP# specified station(s) not existing in REP.</br><br>#MDSDandM# specified station(s) not existing in D&M.</br><br>#NotInMDS# specified station(s) not in MDS.</br></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>Station UDC Validation</a></br>  <br><font size="2" >In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</font></br</tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('Analogy Station Integration','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr><!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>Master Station Data Changes #Date#</h3>     <p>&nbsp;</p><strong>Updates to existing stations [Analagy Station ID]</strong>        <br>Analogy Station updates have been made to #Updates# existing Master Station(s).</br> <br><strong>Further Analogy Station updates were not made because:</strong></br>   <br>#UnmatchedMasterStations# specified Master Station(s) could not be found in MDS</br><br>#UnmatchedAnalogyStations# specified Analogy Station(s) could not be found in MDS</br>  </tr>  <tr>    <td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>Analogy Station Updates</a></br> <br><font size="2" >In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</font></br></td></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
,('MDS Validation Finance','HTMLEMAIL',1,'AZI-MS-SQL-D002 SQL Database Mail','<BR>','<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr>    <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers-->      <!--Other email content-->    </p>  </tr>  <tr> <td align="center" bgcolor="black" style="color: white;"> <p><h3>MDS Validation Report #Date#</h3><br>This is the daily MDS validation notification which provides alerting to potential invalid data conditions within MDS.</br><br>#NullEL2Codes# station(s) have NULL EL2 Codes.</br><br>#NullCodaCustomerCodes# station(s) have NULL Coda Customer Codes.</br></td> </tr><tr><td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Validation Report (Finance)</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>','<BR> Regards, <BR> PRS BI Team')
	)t([templateName],[category],[enabled],[profileName],[greeting],[bodyText],[signature])
) 
merge notification.[template] t
using NotificationTemplate s
on s.[templateName]=t.[templateName]

when not matched then
insert ([templateName],[category],[enabled],[profileName],[greeting],[bodyText],[signature])
values (s.[templateName],s.[category],s.[enabled],s.[profileName],s.[greeting],s.[bodyText],s.[signature])

when matched then
update set t.[category]=s.[category]
			,t.[enabled]=s.[enabled]
			,t.[profileName]=s.[profileName]
			,t.[greeting]=s.[greeting]
			,t.[bodyText]=s.[bodyText]
			,t.[signature]=s.[signature];

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
	,t.[parameter_ordinal]=s.[parameter_ordinal]
	
when not matched by source then delete;
/* Template Parameters - End*/

/*
Template Recipients
The [notification].[templateRecipient] table defines which recipients defines in the [notification].[recipient] table will receive the specified notification.
*/
with TemplateRecipients as (
select	[templateName],[recipientName]

from (values('MDS Station Changes','Tony Wilkinson')
			,('MDS Station Changes','Tim Firmin')
            ,('MDS Station Changes','Emma Williams')
			,('MDS Validation SDM','Tony Wilkinson')
			,('MDS Validation SDM','Tim Firmin')
            ,('MDS Validation SDM','Emma Williams')
			,('MDS Validation Licensing','Tony Wilkinson')
			,('MDS Validation Licensing','Tim Firmin')
            ,('MDS Validation Licensing','Emma Williams')
			,('MDS Validation BI','Tony Wilkinson')
			,('MDS Validation BI','Tim Firmin')
            ,('MDS Validation BI','Emma Williams')
			,('MDS Supplied Station','Senay Yilmaz')
			,('MDS Supplied Station','Tim Firmin')
            ,('MDS Supplied Station','Emma Williams')
			,('Distribution Data Integration','Tony Wilkinson')
			,('Distribution Data Integration','Tim Firmin')
            ,('Distribution Data Integration','Emma Williams')
			,('Station UDC Validation','Tony Wilkinson')
			,('Station UDC Validation','Tim Firmin')
            ,('Station UDC Validation','Emma Williams')
			,('Analogy Station Integration','Tony Wilkinson')
            ,('Analogy Station Integration','Emma Williams')
			,('MDS Validation Finance','Tony Wilkinson')
			,('MDS Validation Finance','Tim Firmin')
            ,('MDS Validation Finance','Emma Williams')
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

