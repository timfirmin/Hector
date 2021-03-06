
/****** Object:  StoredProcedure [notification].[uspUpdateNotificationBody]    Script Date: 11/07/2018 10:44:11 ******/
DROP PROCEDURE IF EXISTS [notification].[uspUpdateNotificationBody]
GO
/****** Object:  StoredProcedure [notification].[uspRequestNotification]    Script Date: 11/07/2018 10:44:11 ******/
DROP PROCEDURE IF EXISTS [notification].[uspRequestNotification]
GO
/****** Object:  StoredProcedure [notification].[uspProcessQueue]    Script Date: 11/07/2018 10:44:11 ******/
DROP PROCEDURE IF EXISTS [notification].[uspProcessQueue]
GO
/****** Object:  StoredProcedure [notification].[uspProcessNotification]    Script Date: 11/07/2018 10:44:11 ******/
DROP PROCEDURE IF EXISTS [notification].[uspProcessNotification]
GO
/****** Object:  StoredProcedure [notification].[uspGetNotificationFromQueue]    Script Date: 11/07/2018 10:44:11 ******/
DROP PROCEDURE IF EXISTS [notification].[uspGetNotificationFromQueue]
GO
/****** Object:  StoredProcedure [notification].[update_param_values]    Script Date: 11/07/2018 10:44:11 ******/
DROP PROCEDURE IF EXISTS [notification].[update_param_values]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[template]') AND type in (N'U'))
ALTER TABLE [notification].[template] DROP CONSTRAINT IF EXISTS [DF__template__enable__390F3758]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[Notification]') AND type in (N'U'))
ALTER TABLE [notification].[Notification] DROP CONSTRAINT IF EXISTS [df_queue_queueSysTime]
GO
/****** Object:  Table [notification].[template_parameter_mapping]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[template_parameter_mapping]
GO
/****** Object:  Table [notification].[solution]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[solution]
GO
/****** Object:  Table [notification].[notification_parameters]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[notification_parameters]
GO
/****** Object:  View [notification].[vNotification]    Script Date: 11/07/2018 10:44:11 ******/
DROP VIEW IF EXISTS [notification].[vNotification]
GO
/****** Object:  View [notification].[vNotificationQueue]    Script Date: 11/07/2018 10:44:11 ******/
DROP VIEW IF EXISTS [notification].[vNotificationQueue]
GO
/****** Object:  Table [notification].[Notification]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[Notification]
GO
/****** Object:  View [notification].[vTemplateRecipientList]    Script Date: 11/07/2018 10:44:11 ******/
DROP VIEW IF EXISTS [notification].[vTemplateRecipientList]
GO
/****** Object:  Table [notification].[templateRecipient]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[templateRecipient]
GO
/****** Object:  Table [notification].[template]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[template]
GO
/****** Object:  Table [notification].[recipient]    Script Date: 11/07/2018 10:44:11 ******/
DROP TABLE IF EXISTS [notification].[recipient]
GO
/****** Object:  UserDefinedFunction [notification].[udfLogNotificationResponse]    Script Date: 11/07/2018 10:44:11 ******/
DROP FUNCTION IF EXISTS [notification].[udfLogNotificationResponse]
GO
/****** Object:  UserDefinedFunction [notification].[udfLogNotificationResponse]    Script Date: 11/07/2018 10:44:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[udfLogNotificationResponse]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'



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
	SET @TextValue = ''''		

	If @templateID =2 and ISJSON(@notificationData)>0
	BEGIN
	SELECT @TextValue =  replace (
								 replace (
									replace (bodyText,''#NDate#'',JSON_VALUE(@notificationData,''$[0].NDate''))
									,''#New#'',JSON_VALUE( @notificationData,''$[0].NewStations'')
									),
								    ''#Updated#'',JSON_VALUE( @notificationData, ''$[0].UpdatedStations'')
		) 
	FROM	[notification].[template] 
	Where TemplateID=@templateID
	
	END
	
	RETURN @TextValue

END



' 
END

GO
/****** Object:  Table [notification].[recipient]    Script Date: 11/07/2018 10:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[recipient]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [notification].[template]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[template]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [notification].[templateRecipient]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[templateRecipient]') AND type in (N'U'))
BEGIN
CREATE TABLE [notification].[templateRecipient](
	[templateID] [int] NOT NULL,
	[recipientID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[templateID] ASC,
	[recipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
END
GO
/****** Object:  View [notification].[vTemplateRecipientList]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[notification].[vTemplateRecipientList]'))
EXEC dbo.sp_executesql @statement = N'
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
				, ''['' + left(recipientNameList,len(recipientNameList)-1) + '']'' [recipientNameList]
				, ''['' + left(friendlyNameList,len(friendlyNameList)-1) + '']'' [friendlyNameList]
FROM recipients r1
CROSS APPLY ( SELECT [recipientEmail] + '';'' 
                     FROM recipients r2
                     WHERE r2.templateID = r1.templateID 
                     ORDER BY [recipientEmail] 
                     FOR XML PATH('''') )  D ( recipientList )
CROSS APPLY ( SELECT [recipientName] + '','' 
                     FROM recipients r3
                     WHERE r3.templateID = r1.templateID 
                     ORDER BY [recipientName] 
                     FOR XML PATH('''') )  E ( recipientNameList )
CROSS APPLY ( SELECT [friendlyName] + '','' 
                     FROM recipients r4
                     WHERE r4.templateID = r1.templateID 
                     ORDER BY [recipientName] 
                     FOR XML PATH('''') )  F ( friendlyNameList )

' 
GO
/****** Object:  Table [notification].[Notification]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[Notification]') AND type in (N'U'))
BEGIN
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
PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
END
GO
/****** Object:  View [notification].[vNotificationQueue]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[notification].[vNotificationQueue]'))
EXEC dbo.sp_executesql @statement = N'
CREATE  VIEW [notification].[vNotificationQueue]

AS

SELECT  
      [notificationID]  
FROM  [notification].[Notification]
WHERE Processed =0
      AND ISNULL([ExpiryDate],getdate()) >= getdate()' 
GO
/****** Object:  View [notification].[vNotification]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[notification].[vNotification]'))
EXEC dbo.sp_executesql @statement = N'


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
			



' 
GO
/****** Object:  Table [notification].[notification_parameters]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[notification_parameters]') AND type in (N'U'))
BEGIN
CREATE TABLE [notification].[notification_parameters](
	[notification_id] [int] NULL,
	[placeholder_name] [varchar](100) NULL,
	[parameter_name] [varchar](100) NULL,
	[parameter_value] [nvarchar](1000) NULL
)
END
GO
/****** Object:  Table [notification].[solution]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[solution]') AND type in (N'U'))
BEGIN
CREATE TABLE [notification].[solution](
	[solutionID] [int] IDENTITY(1,1) NOT NULL,
	[solutionName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[solutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
END
GO
/****** Object:  Table [notification].[template_parameter_mapping]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[template_parameter_mapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [notification].[template_parameter_mapping](
	[template_id] [int] NULL,
	[placeholder_name] [varchar](100) NULL,
	[parameter_name] [varchar](100) NULL,
	[parameter_ordinal] [int] NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[df_queue_queueSysTime]') AND type = 'D')
BEGIN
ALTER TABLE [notification].[Notification] ADD  CONSTRAINT [df_queue_queueSysTime]  DEFAULT (sysutcdatetime()) FOR [queueSysTime]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[DF__template__enable__390F3758]') AND type = 'D')
BEGIN
ALTER TABLE [notification].[template] ADD  DEFAULT ((1)) FOR [enabled]
END

GO
/****** Object:  StoredProcedure [notification].[update_param_values]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[update_param_values]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[update_param_values] AS' 
END
GO

ALTER proc [notification].[update_param_values]
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
/****** Object:  StoredProcedure [notification].[uspGetNotificationFromQueue]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspGetNotificationFromQueue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspGetNotificationFromQueue] AS' 
END
GO





ALTER PROCEDURE [notification].[uspGetNotificationFromQueue]
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
/****** Object:  StoredProcedure [notification].[uspProcessNotification]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspProcessNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspProcessNotification] AS' 
END
GO

ALTER PROCEDURE [notification].[uspProcessNotification]
  @notificationId int
AS
BEGIN

		update [notification].[notification]
		set [processSysTime]=sysutcdatetime(),
		     Processed = 1
		where [notificationID] = @notificationID
	
END



GO
/****** Object:  StoredProcedure [notification].[uspProcessQueue]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspProcessQueue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspProcessQueue] AS' 
END
GO
ALTER PROCEDURE [notification].[uspProcessQueue]
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
/****** Object:  StoredProcedure [notification].[uspUpdateNotificationBody]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspUpdateNotificationBody]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspUpdateNotificationBody] AS' 
END
GO

ALTER proc [notification].[uspUpdateNotificationBody]
@notification_id int
as
declare @i int = 1
declare @notification_body nvarchar(Max)

select @notification_body= [notificationResponse] from [notification].[notification] where [notificationid]=@notification_id

--extract notification parameters from json to table
exec [notification].[update_param_values] @notification_id

--determine number of iterations based on number of parameters expected in the template
while @i <= (	select	count([notification_id]) 
				from	[notification].[notification_parameters] n
				where	n.[notification_id]=@notification_id 
				)
begin
	select @notification_body=replace(@notification_body,p.[placeholder_name],p.[parameter_value])  
	from [notification].[notification_parameters] p
	where p.[notification_id]=@notification_id

	select @i=@i+1
end
update [notification].[notification]
set [notificationResponse]=@notification_body
where [notificationid]=@notification_id

GO

/****** Object:  StoredProcedure [notification].[uspRequestNotification]    Script Date: 11/07/2018 10:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspRequestNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspRequestNotification] AS' 
END
GO

/*
EXEC [notification].[uspRequestNotification]  @notificationTemplate = 'MDS Station Changes',@notificationSubject = '## MDS Station Changes ##',@notificationData ='[{\"NewStations\":7,\"UpdatedStations\":9691,\"NDate\":\"08\\/06\\/2018\"}]',@reportLink = 'https://app-reports-dev01/reports/report/MDSIntegration/MasterStationAlertDetails?LoadId=0'
*/

ALTER PROCEDURE [notification].[uspRequestNotification]
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
