USE [BISystemUAT]
GO

/****** Object:  Table [notification].[Notification]    Script Date: 29/10/2018 08:21:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[Notification](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[queueSysTime] [datetime2](7) NOT NULL,
	[templateID] [int] NOT NULL,
	[notificationSubject] [nvarchar](255) NOT NULL,
	[notificationData] [nvarchar](max) NOT NULL,
	[notificationResponse] [nvarchar](max) NULL,
	[processSysTime] [datetime2](7) NULL,
	[ExpiryDate] [datetime2](7) NULL,
	[Processed] [bit] NULL,
	[suser_name] [varchar](100) NULL,
	[notificationSource] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO

ALTER TABLE [notification].[Notification] ADD  CONSTRAINT [df_queue_queueSysTime]  DEFAULT (sysutcdatetime()) FOR [queueSysTime]
GO




/****** Object:  Table [notification].[notification_parameters]    Script Date: 29/10/2018 08:22:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[notification_parameters](
	[notification_id] [int] NULL,
	[placeholder_name] [varchar](100) NULL,
	[parameter_name] [varchar](100) NULL,
	[parameter_value] [nvarchar](1000) NULL
)

GO


/****** Object:  Table [notification].[recipient]    Script Date: 29/10/2018 08:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[recipient](
	[recipientID] [int] IDENTITY(1,1) NOT NULL,
	[recipientName] [varchar](100) NOT NULL,
	[recipientEmail] [varchar](255) NULL,
	[friendlyName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[recipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO


/****** Object:  Table [notification].[solution]    Script Date: 29/10/2018 08:22:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[solution](
	[solutionID] [int] IDENTITY(1,1) NOT NULL,
	[solutionName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[solutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO


/****** Object:  Table [notification].[template]    Script Date: 29/10/2018 08:23:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[template](
	[templateID] [int] IDENTITY(1,1) NOT NULL,
	[templateName] [varchar](100) NOT NULL,
	[category] [varchar](50) NULL,
	[enabled] [bit] NULL,
	[profileName] [varchar](255) NULL,
	[greeting] [varchar](100) NULL,
	[bodyText] [varchar](4000) NULL,
	[signature] [varchar](255) NULL
)

GO

ALTER TABLE [notification].[template] ADD  DEFAULT ((1)) FOR [enabled]
GO


/****** Object:  Table [notification].[template_parameter_mapping]    Script Date: 29/10/2018 08:23:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[template_parameter_mapping](
	[template_id] [int] NULL,
	[placeholder_name] [varchar](100) NULL,
	[parameter_name] [varchar](100) NULL,
	[parameter_ordinal] [int] NULL
)

GO

/****** Object:  Table [notification].[templateRecipient]    Script Date: 29/10/2018 08:23:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [notification].[templateRecipient](
	[templateID] [int] NOT NULL,
	[recipientID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[templateID] ASC,
	[recipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO



/****** Object:  View [notification].[vNotification]    Script Date: 29/10/2018 08:24:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE view [notification].[vNotification]
as
		select  n.[notificationID]
				,n.[templateID]
				,t.[category]
				,t.[enabled]
				, [greeting]
				,l.[recipientList]
				,n.[notificationSubject]
				,t.bodyText
				,n.[notificationdata]
				,[notificationResponse]
				,t.[profileName]
				,t.[signature]
				,n.[suser_name]
				,n.[queueSysTime]
				,n.[processSysTime]
				,p.[Processed] 
		  	   ,rank() over (partition by t.[enabled],p.[Processed] order by n.[queueSysTime])[Priority]
       FROM [notification].[notification] n
			join [notification].[template] t on t.templateID=n.templateID
			join [notification].[vTemplateRecipientList] l on l.templateID=t.templateID
			join (select [notificationID],case when [processSysTime] is null then 0 else 1 end [processed] from [notification].[notification] ) p on p.[notificationID]=n.notificationID
			




GO

/****** Object:  View [notification].[vNotificationQueue]    Script Date: 29/10/2018 08:24:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  VIEW [notification].[vNotificationQueue]

AS

SELECT  
      [notificationID]  
FROM  [notification].[Notification]
WHERE Processed =0
      AND ISNULL([ExpiryDate],getdate()) >= getdate()
GO


/****** Object:  View [notification].[vTemplateRecipientList]    Script Date: 29/10/2018 08:24:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [notification].[vTemplateRecipientList]
as
with recipients as (
	select t.[templateID],r.[recipientEmail],r.[recipientName],r.[friendlyName]
	from [notification].[recipient] r
	join [notification].[templateRecipient] tr on tr.recipientID = r.recipientID
	join [notification].[template] t on t.[templateID] = tr.[templateID] 
)

SELECT DISTINCT templateID
				, recipientList
				, '[' + left(recipientNameList,len(recipientNameList)-1) + ']' [recipientNameList]
				, '[' + left(friendlyNameList,len(friendlyNameList)-1) + ']' [friendlyNameList]
FROM recipients r1
CROSS APPLY ( SELECT [recipientEmail] + ';' 
                     FROM recipients r2
                     WHERE r2.templateID = r1.templateID 
                     ORDER BY [recipientEmail] 
                     FOR XML PATH('') )  D ( recipientList )
CROSS APPLY ( SELECT [recipientName] + ',' 
                     FROM recipients r3
                     WHERE r3.templateID = r1.templateID 
                     ORDER BY [recipientName] 
                     FOR XML PATH('') )  E ( recipientNameList )
CROSS APPLY ( SELECT [friendlyName] + ',' 
                     FROM recipients r4
                     WHERE r4.templateID = r1.templateID 
                     ORDER BY [recipientName] 
                     FOR XML PATH('') )  F ( friendlyNameList )


GO



/****** Object:  UserDefinedFunction [notification].[udfLogNotificationResponse]    Script Date: 29/10/2018 08:26:52 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [notification].[udfLogNotificationResponse]
(
	@notificationData NVarchar(MAX)
	,
	@templateID int
)
RETURNS NVarchar(MAX)
AS
BEGIN
	
	DECLARE @TextValue NVARCHAR(MAX)
	SET @TextValue = ''		

	If @templateID =2 and ISJSON(@notificationData)>0
	BEGIN
	SELECT @TextValue =  replace (
								 replace (
									replace (bodyText,'#NDate#',JSON_VALUE(@notificationData,'$[0].NDate'))
									,'#New#',JSON_VALUE( @notificationData,'$[0].NewStations')
									),
								    '#Updated#',JSON_VALUE( @notificationData, '$[0].UpdatedStations')
		) 
	FROM	[notification].[template] 
	Where TemplateID=@templateID
	
	END
	
	RETURN @TextValue

END

GO



/****** Object:  StoredProcedure [notification].[update_param_values]    Script Date: 29/10/2018 08:25:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [notification].[update_param_values]
@notification_id int
as
declare @i int = 1
declare @param_name varchar(100)
declare @sql nvarchar(1000)

--clear down any existing params, and reseed the notification params for this notification
delete [notification].[notification_parameters] where [notification_id]=@notification_id
insert [notification].[notification_parameters]([notification_id],[placeholder_name],[parameter_name])
select	n.[notificationID],m.[placeholder_name],m.[parameter_name]
from [notification].[Notification] n
left join [notification].[template_parameter_mapping] m on m.[template_id]=n.[templateID]
where n.[notificationID]=@notification_id

--update parameter values
while @i <= (	select	max([parameter_ordinal]) 
				from [notification].[notification] n	
				join [notification].[template_parameter_mapping] m on m.[template_id]=n.[templateid]
				where n.[notificationid]=@notification_id)
begin
	--get the next parameter to process
	select @param_name = p.[parameter_name] 
	from [notification].[notification] n 
	join [notification].[template_parameter_mapping] p on p.[template_id]=n.[templateID]
	where p.[template_id]=n.[templateID]
	and p.[parameter_ordinal]=@i
	and n.[notificationID]=@notification_id

	select @sql = 'update p set parameter_value = json_value(n.[notificationData],''$.' + @param_name +''') from [notification].[notification_parameters] p join [notification].[notification] n on n.[notificationID]=p.[notification_id] where p.[parameter_name]=''' + @param_name +''' and n.[notificationID]=' + cast(@notification_id as varchar(3))
	exec sp_executesql @sql
	select @i = @i + 1
end

GO

/****** Object:  StoredProcedure [notification].[uspGetNotificationFromQueue]    Script Date: 29/10/2018 08:27:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [notification].[uspGetNotificationFromQueue]
	@notificationId int
AS

   SELECT        
	     n.[recipientList],
		 n.[notificationSubject],
		 n.[notificationResponse]  as notificationBody,
		 n.[profileName]
	FROM [notification].[vNotification] n
	WHERE  n.[Processed]=0 and n.[enabled]=1  and n.[notificationID] = @notificationId
	
GO


/****** Object:  StoredProcedure [notification].[uspProcessNotification]    Script Date: 29/10/2018 08:28:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [notification].[uspProcessNotification]
  @notificationId int
AS
BEGIN

		update [notification].[notification]
		set [processSysTime]=sysutcdatetime(),
		     Processed = 1
		where [notificationID] = @notificationID
	
END
GO


/****** Object:  StoredProcedure [notification].[uspProcessQueue]    Script Date: 29/10/2018 08:29:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [notification].[uspProcessQueue]
AS
BEGIN

	declare @notificationID int
	declare @recipients varchar(max)
	declare @subject nvarchar(255)
	declare @profile_name sysname
	declare @body nvarchar(max)

/********************************************************************************************************************
       while there are unprocessed notifications
********************************************************************************************************************/
       while ((select count([notificationID]) from [notification].[vNotification] where [Processed]=0) > 0)
       begin
       /********************************************************************************************************************
              get the notification parameters
       ********************************************************************************************************************/
              select @notificationID=n.[notificationID]
                           ,@recipients=n.[recipientList]
                           ,@subject=n.[notificationSubject]
                           ,@body = n.notificationResponse
                           ,@profile_name = n.[profileName]
              from [notification].[vNotification] n
              where n.[Processed]=0 and n.[Priority]=1 and n.[enabled]=1

       /********************************************************************************************************************
              send notification
       ********************************************************************************************************************/
              --exec msdb.dbo.sp_send_dbmail @recipients=@recipients,@subject = @subject,@profile_name = @profile_name,@body = @body;

       /********************************************************************************************************************
              set the notification to be processed
       ********************************************************************************************************************/
              --update [notification].[notification]
              --set [processSysTime]=sysutcdatetime()
              --where [notificationID] = @notificationID
 END
END

GO

/****** Object:  StoredProcedure [notification].[uspRequestNotification]    Script Date: 29/10/2018 08:30:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
EXEC [notification].[uspRequestNotification]  @notificationTemplate = 'MDS Station Changes',@notificationSubject = '## MDS Station Changes ##',@notificationData ='[{\"NewStations\":7,\"UpdatedStations\":9691,\"NDate\":\"08\\/06\\/2018\"}]',@reportLink = 'https://app-reports-dev01/reports/report/MDSIntegration/MasterStationAlertDetails?LoadId=0'
*/

CREATE PROCEDURE [notification].[uspRequestNotification]
	@notificationTemplate varchar(100),
	@notificationSubject nvarchar(255),
	@notificationData nvarchar(max),
	@notificationExpiryDate varchar(8) = null
as
declare @templateid int
declare @notificationid int

	if exists (select templateID from [notification].[template] where [templateName]=@notificationTemplate)
	begin

		select @templateid=templateID from [notification].[template] where [templateName]=@notificationTemplate

		--insert a pending notification record
		insert [notification].[notification]([templateID],
		                                     [notificationSubject],
											 [notificationData],
											 [notificationResponse],
		                                 	 [ExpiryDate],
											 [Processed],
											 [suser_name])
		select	[templateID]
				,@notificationSubject
				,@notificationData
				,[bodyText]
				,ISNULL(@notificationExpiryDate, convert(varchar(8),dateadd(day,2,getdate()),112))
				,0
				,suser_name()
		from	[notification].[template] n 
		where	templateID=@templateid

		select @notificationid = scope_identity()

		--update the body text with logged parameter values
		exec [notification].[uspUpdateNotificationBody] @notificationid
		

	end
GO


/****** Object:  StoredProcedure [notification].[uspUpdateNotificationBody]    Script Date: 29/10/2018 08:30:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [notification].[uspUpdateNotificationBody]
@notification_id int
as
declare @i int = 1
declare @notification_body nvarchar(Max)
declare @notification_template varchar(100)
declare @error_notification_body nvarchar(max)

select @notification_body= [notificationResponse] from [notification].[notification] where [notificationid]=@notification_id
select @notification_template = t.[templateName] from [notification].[notification] n join [notification].[template] t on t.templateID=n.templateid where [notificationid]=@notification_id
select @error_notification_body = '<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <br><table id="t01">   <tr>    <th align="left"  bgcolor="white" ><h3>PRS BI Notification System</h3></th>    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>Notification Failure</h3><br>The BI Notification System attempted to send you a notification.</br><br>An error has occurred while processing this notification.</br><p>&nbsp;</p><br>Please report this to the PRS BI Team.</br><br>Notification template: ' + @notification_template + '</br><br>Notification ID: ' + cast(@notification_id as varchar(10)) +'</br></td> </tr><tr><td align="center"  bgcolor="white" ><br></br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>'

--extract notification parameters from json to table
exec [notification].[update_param_values] @notification_id

--determine number of iterations based on number of parameters expected in the template
while @i <= (	select	count([notification_id]) 
				from	[notification].[notification_parameters] n
				where	n.[notification_id]=@notification_id 
				)
begin
	select @notification_body=replace(@notification_body,p.[placeholder_name],isnull(p.[parameter_value],'<Unspecified>'))  
	from [notification].[notification_parameters] p
	where p.[notification_id]=@notification_id

	select @i=@i+1
end
update [notification].[notification]
set [notificationResponse]=isnull(@notification_body,@error_notification_body)
where [notificationid]=@notification_id






GO














