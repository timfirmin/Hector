/*
NotificationTemplates
A template is required for each notification the system will send.
This table defines the name of the template and the content, including placeholders. When a notification is processed, the placeholders are replaced with items of data that are
logged when the notification is requested.
*/

-------------------------------------------------
--Determine Server Name as Profile Name
DECLARE @profileName VARCHAR(255)

SELECT 
	@profileName = 
	CASE	
		WHEN @@SERVERNAME = 'azp-ms-sql-d002' AND DB_NAME() = 'BISystemDev' THEN 'AZI-MS-SQL-D002 SQL Database Mail'
		WHEN @@SERVERNAME = 'azp-ms-sql-d002' AND DB_NAME() = 'BISystemTest' THEN 'AZI-MS-SQL-T001 SQL Database Mail'
		WHEN @@SERVERNAME = 'azp-ms-sql-u001' AND DB_NAME() = 'BISystemUat' THEN 'AZI-MS-SQL-U001 SQL Database Mail'
		WHEN @@SERVERNAME = 'azp-ms-sql-p003' AND DB_NAME() = 'BISystem' THEN 'AZI-MS-SQL-P001 SQL Database Mail'
		WHEN @@SERVERNAME = 'GR2-W8-POW068\LOCALDB#52B1709C' AND DB_NAME() = 'BISystem_Checks' THEN 'Unknown SQL Database Mail'
		ELSE 'Unknown'
	END

PRINT @profileName

IF @profileName = 'Unknown' RETURN
----------------------------------------------------

----------------------------------------------------
--Notification HTML

DECLARE @MDSSuppliedStation VARCHAR(4000)
SET @MDSSuppliedStation = 
'
<html>
  <head>
    <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
  </head>
  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
  <table id="t01">
    <tr>
      <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
      <th align="left"  bgcolor="white" >
        <h3>PRS Master Data Management</h3>
      </th>
      <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers-->      <!--Other email content-->    </p>  
    </tr>
    <tr>
      <td align="center" bgcolor="black" style="color: white;">
        <p>
        <h3>Stations from the following data sources (BARB,RAJAR) require mapping to a Master Station Id before they can be added to MDS. #Date#</h3>
        <br>#UnmatchedBARB# BARB station(s) are not mapped to a Master Station Id in MDS.</br>
		<br>#UnmatchedRAJAR# RAJAR station(s) are not mapped to a Master Station Id in MDS.</br>
      </td>
    </tr>
    <tr>
      <td align="center"  bgcolor="white" >Please review the required mappings here:<br><a href=#ReportLink#>MDS Supplied Station</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br>
    </tr>
  </table>
  </body>
</html>
'

DECLARE @MDSStationUDCValidation VARCHAR(4000)
SET @MDSStationUDCValidation = 
'
<html>
   <head>
      <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
   </head>
   <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
   <table id="t01">
      <tr>
         <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
         <th align="left"  bgcolor="white" >
            <h3>PRS Master Data Management</h3>
         </th>
         <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  
      </tr>
      <tr>
         <td align="center" bgcolor="black" style="color: white;">
            <p>
            <h3>Station UDC Changes In MDS Aligned with REP #Date#</h3>
            </p>
			<br>#UDCNew# New UDCs from REP.</br><br>#UDCInactive# Updates to UDC InactiveDate from Rep. These updates have been applied in MDS.</br>
			<br>#UDCStationNew# New Station/UDC mappings from REP. These updates have been applied in MDS.</br>
			<br>#UDCStationChange# Changes to Station/UDC attributes from REP. These changes have not been applied in MDS, please review on the report link below and make the necessary change.</br>
         </td>
      </tr>
      <tr>
         <td align="center"  bgcolor="white">Full details can be found by following the report link below<br><a href=#ReportLink#>Station UDC Validation</a></br>  <br><font size="2" >In accordance with the agreed data governance process, please review the above changes and ensure updates are made.</font></br>
      </tr>
      <tr>
         <td bgcolor="#F2F3F4" style="color: #273746;">
            <h2>PRS BI Team</h2>
         </td>
      </tr>
   </table>
   </body>
</html>
'

DECLARE @AnalogyStationIntegration VARCHAR(4000)
SET @AnalogyStationIntegration = 
'
<html>
  <head>
    <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
  </head>
  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
  <table id="t01">
    <tr>
      <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
      <th align="left"  bgcolor="white" >
        <h3>PRS Master Data Management</h3>
      </th>
      <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  
    </tr>
    <tr>
      <td align="center" bgcolor="black" style="color: white;">
        <p>
        <h3>Master Station Data Changes #Date#</h3>
        <p>&nbsp;</p>
        <strong>Updates to existing stations [Analagy Station ID]</strong>        <br>Analogy Station updates have been made to #Updates# existing Master Station(s).</br> <br><strong>Further Analogy Station updates were not made because:</strong></br>   <br>#UnmatchedMasterStations# specified Master Station(s) could not be found in MDS</br><br>#UnmatchedAnalogyStations# specified Analogy Station(s) could not be found in MDS</br>  
    </tr>
    <tr>
      <td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>Analogy Station Updates</a></br> <br><font size="2" >In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</font></br></td>
    </tr>
  </table>
  </body>
</html>
'

DECLARE @MDSValidationFinance VARCHAR(4000)
SET @MDSValidationFinance = 
'
<html>
   <head>
      <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
   </head>
   <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
   <table id="t01">
      <tr>
         <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
         <th align="left"  bgcolor="white" >
            <h3>PRS Master Data Management</h3>
         </th>
         <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers-->      <!--Other email content-->    </p>  
      </tr>
      <tr>
         <td align="center" bgcolor="black" style="color: white;">
            <p>
            <h3>MDS Master Station Validation (Finance) #Date#</h3>
			<br>#NullCodaCustomerCodes# MDS Master station(s) have missing Coda Customer Codes.</br>
         </td>
      </tr>
      <tr>
         <td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Validation Report (Finance)</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br>
      </tr>
   </table>
   </body>
</html>
'

DECLARE @DistributionDataIntegration VARCHAR(4000)
SET @DistributionDataIntegration = 
'
<html>
  <head>
    <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
  </head>
  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
  <table id="t01">
    <tr>
      <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
      <th align="left"  bgcolor="white" >
        <h3>PRS Master Data Management</h3>
      </th>
      <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  
    </tr>
    <tr>
      <td align="center" bgcolor="black" style="color: white;">
        <p>
        <h3>Distribution Data Integration (Missing Station Codes) #Date#</h3>
        </p><br>#MusicMinutes# unmatched/unknown station(s) have been identified in Music Minutes.</br><br>#MissingMinutes# unmatched/unknown station(s) have been identified in Missing Minutes.</br><br>#PublicReception# unmatched/unknown station(s) have been identified in Public Reception.</br>   <br>Please review station(s) listed on the detail report and add to Master Data / remove from source file where appropriate.</br><br>
      </td>
    </tr>
    <tr>
      <td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>DDI Missing Stations Report</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br> 
    </tr>
  </table>
  </body>
</html>
'

DECLARE @DistributionDataIntegrationEndBatch VARCHAR(4000)
SET @DistributionDataIntegrationEndBatch = 
'
<html>
  <head>
    <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
  </head>
  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
  <table id="t01">
    <tr>
      <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
      <th align="left"  bgcolor="white" >
        <h3>PRS Master Data Management</h3>
      </th>
      <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  
    </tr>
    <tr>
      <td align="center" bgcolor="black" style="color: white;">
        <p>
        <h3>Distribution Data Integration (End of Batch) #Date#</h3>
        </p><br>#MusicMinutes# failed Music Minute File(s) within last Batch.</br><br>#MissingMinutes# failed Missing Minutes File(s) within last Batch.</br><br>#PublicReception# failed Public Reception File(s) within last Batch.</br>   <br>Please review Failed File(s) listed on the detail report and resubmit if appropriate.	</br><br>
      </td>
    </tr>
    <tr>
      <td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>DDI End of Batch Report</a></br> <br>In accordance with the agreed data governance process, please resolve issues above. These files have not been integrated into the Abacus Application.</br> 
    </tr>
  </table>
  </body>
</html>
'

DECLARE @MDSMasterStationValidation VARCHAR(4000)
SET @MDSMasterStationValidation = 
'
<html>
  <head>
    <style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style>
  </head>
  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br>
  <table id="t01">
    <tr>
      <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    
      <th align="left"  bgcolor="white" >
        <h3>PRS Master Data Management</h3>
      </th>
      <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers--><!--Other email content-->    </p>  
    </tr>
    <tr>
      <td align="center" bgcolor="black" style="color: white;">
        <p>
        <h3>MDS Master Station Validation Report #Date#</h3>
		<br>#ValidationBreaks# Master station(s) break validation rules.</br>
      </td>
    </tr>
    <tr>
      <td align="center"  bgcolor="white" >Full details can be found by following the report link below<br><a href=#ReportLink#>MDS Master Station Validation Report</a></br> <br>In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</br> 
    </tr>
  </table>
  </body>
</html>
'
---------------------------------------------------------------


;with NotificationTemplate as (
select [templateName],[category],[enabled],[profileName],[greeting],[bodyText],[signature]
from (values 
 ('MDS Supplied Station','HTMLEMAIL',1,@profileName,'<BR>',@MDSSuppliedStation,'<BR> Regards, <BR> PRS BI Team')
,('Station UDC Validation','HTMLEMAIL',1,@profileName,'<BR>',@MDSStationUDCValidation,'<BR> Regards, <BR> PRS BI Team')
,('Analogy Station Integration','HTMLEMAIL',1,@profileName,'<BR>',@AnalogyStationIntegration,'<BR> Regards, <BR> PRS BI Team')
,('MDS Validation Finance','HTMLEMAIL',1,@profileName,'<BR>',@MDSValidationFinance,'<BR> Regards, <BR> PRS BI Team')
,('Distribution Data Integration','HTMLEMAIL',1,@profileName,'<BR>',@DistributionDataIntegration,'<BR> Regards, <BR> PRS BI Team')
,('Distribution Data Integration End Batch','HTMLEMAIL',1,@profileName,'<BR>',@DistributionDataIntegrationEndBatch,'<BR> Regards, <BR> PRS BI Team')
,('MDS Master Station Validation','HTMLEMAIL',1,@profileName,'<BR>',@MDSMasterStationValidation,'<BR> Regards, <BR> PRS BI Team')
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
			,t.[signature]=s.[signature]
;
/*
NotificationTemplates - End
*/

