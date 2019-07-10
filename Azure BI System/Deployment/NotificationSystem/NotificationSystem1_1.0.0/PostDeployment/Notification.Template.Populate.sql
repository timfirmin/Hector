SET IDENTITY_INSERT [notification].[template] ON;
GO
MERGE INTO [notification].[template] AS Tgt
USING 
	(VALUES

--	templateID	templateName	category	enabled	profileName	greeting	bodyText	signature
	(1,	'Notification Service Test Email',	        'INFO',      	1,	'AZI-MS-SQL-D002 SQL Database Mail',	'Hi %recipientList%',	'This is test body text',	'Regards, PRS BI Team'),
	(2,	'MDS Station Changes',	                    'HTMLEMAIL',	1,	'AZI-MS-SQL-D002 SQL Database Mail',	'<BR>', 	            '<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <!-- <h2><font face="Segoe UI"> Email content</font></h2>--><br><table id="t01">   <tr>    <!-- <th align="left"><p><font face="Comic sans MS" color="green">PRS Master Data Management</font></p></th>-->    <th align="left"  bgcolor="white" ><h3>PRS Master Data Management</h3></th>  <!--https://www.prsformusic.com/press/2018/record-royalties-paid-to-songwriters-and-composers-->      <!--Other email content-->    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;">      <p><h3>Master Station Data Changes from REP & CRM 26/06/2018</h3>         <font size="2">         <p>&nbsp;</p>        <strong>New Stations: #New# </strong>        <br>These stations have been added to MDS. Please review and update outstanding fields.</br>        <p>&nbsp;</p>        <strong>Updates to existing stations from REP: #Updated# </strong>        <br>These changes are pending approval. Please make the necessary changes to either the master data in MDS, or the source data in REP.</br>        <p>&nbsp;</p>        <strong>Updates to existing stations from CRM: #CRMUpdates# </strong>        <br>These changes are pending approval. Please make the necessary changes to either the master data in MDS, or the source data in REP.</br>  </font>         <p>&nbsp;</p>         <font size="1" >In accordance with the agreed data governance process, please review the above changes and ensure all updates are made.</font>         </p></td>  </tr>  <tr>    <td align="center"  bgcolor="white" >Full details about these pending changes<br><a href=#ReportLink#>Check it out</a></br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>', '<BR> Regards, <BR> PRS BI Team'),
	(3,	'MDS Master Station Finance Code Changes',	'HTMLEMAIL',	1,	'AZI-MS-SQL-D002 SQL Database Mail',	'<BR>', 	            '<BR><BR><BR>',  	'<BR>'),
	(5,	'MDS Supplied Station Changes' ,         	'HTMLEMAIL',	1,	'AZI-MS-SQL-D002 SQL Database Mail',	'<BR>', 	            '<BR><BR><BR>', 	'<BR>')


	) AS Src
	(
		    [templateID]
		   ,[templateName]
           ,[category]
           ,[enabled]
           ,[profileName]
           ,[greeting]
           ,[bodyText]
           ,[signature]
	)
	ON Tgt.templateID = Src.templateID

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		--templateID	=	SRC.templateID,
		templateName	=	SRC.templateName,
		category	=	SRC.category,
		enabled	    =	SRC.enabled,
		profileName	=	SRC.profileName,
		greeting	=	SRC.greeting,
		bodyText	=	SRC.bodyText,
		signature	=	SRC.signature


-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[templateID]
		   ,[templateName]
           ,[category]
           ,[enabled]
           ,[profileName]
           ,[greeting]
           ,[bodyText]
           ,[signature]		
		)
	VALUES
		(
			SRC.[templateID]
		   ,SRC.[templateName]
           ,SRC.[category]
           ,SRC.[enabled]
           ,SRC.[profileName]
           ,SRC.[greeting]
           ,SRC.[bodyText]
           ,SRC.[signature]
		)


WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [notification].[template] OFF;

