/****** Object:  StoredProcedure [notification].[uspRequestNotification]    Script Date: 25/05/2018 11:12:53 ******/
DROP PROCEDURE IF EXISTS [notification].[uspRequestNotification]
GO
/****** Object:  StoredProcedure [notification].[uspProcessQueue]    Script Date: 25/05/2018 11:12:53 ******/
DROP PROCEDURE IF EXISTS [notification].[uspProcessQueue]
GO
/****** Object:  StoredProcedure [notification].[uspProcessNotification]    Script Date: 25/05/2018 11:12:53 ******/
DROP PROCEDURE IF EXISTS [notification].[uspProcessNotification]
GO
/****** Object:  StoredProcedure [notification].[uspGetNotificationFromQueue]    Script Date: 25/05/2018 11:12:53 ******/
DROP PROCEDURE IF EXISTS [notification].[uspGetNotificationFromQueue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[template]') AND type in (N'U'))
ALTER TABLE [notification].[template] DROP CONSTRAINT IF EXISTS [DF__template__enable__390F3758]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[Notification]') AND type in (N'U'))
ALTER TABLE [notification].[Notification] DROP CONSTRAINT IF EXISTS [df_queue_queueSysTime]
GO
/****** Object:  Table [notification].[solution]    Script Date: 25/05/2018 11:12:53 ******/
DROP TABLE IF EXISTS [notification].[solution]
GO
/****** Object:  View [notification].[vNotificationQueue]    Script Date: 25/05/2018 11:12:53 ******/
DROP VIEW IF EXISTS [notification].[vNotificationQueue]
GO
/****** Object:  View [notification].[vNotification]    Script Date: 25/05/2018 11:12:53 ******/
DROP VIEW IF EXISTS [notification].[vNotification]
GO
/****** Object:  Table [notification].[Notification]    Script Date: 25/05/2018 11:12:53 ******/
DROP TABLE IF EXISTS [notification].[Notification]
GO
/****** Object:  View [notification].[vTemplateRecipientList]    Script Date: 25/05/2018 11:12:53 ******/
DROP VIEW IF EXISTS [notification].[vTemplateRecipientList]
GO
/****** Object:  Table [notification].[templateRecipient]    Script Date: 25/05/2018 11:12:53 ******/
DROP TABLE IF EXISTS [notification].[templateRecipient]
GO
/****** Object:  Table [notification].[template]    Script Date: 25/05/2018 11:12:53 ******/
DROP TABLE IF EXISTS [notification].[template]
GO
/****** Object:  Table [notification].[recipient]    Script Date: 25/05/2018 11:12:53 ******/
DROP TABLE IF EXISTS [notification].[recipient]
GO
/****** Object:  Table [notification].[recipient]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[recipient]') AND type in (N'U'))
BEGIN
CREATE TABLE [Notification].[recipient](
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
/****** Object:  Table [notification].[template]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[template]') AND type in (N'U'))
BEGIN
CREATE TABLE [Notification].[template](
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
/****** Object:  Table [notification].[templateRecipient]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[templateRecipient]') AND type in (N'U'))
BEGIN
CREATE TABLE [Notification].[templateRecipient](
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
/****** Object:  View [notification].[vTemplateRecipientList]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[notification].[vTemplateRecipientList]'))
EXEC dbo.sp_executesql @statement = N'
CREATE view [Notification].[vTemplateRecipientList]
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
/****** Object:  Table [notification].[Notification]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[Notification]') AND type in (N'U'))
BEGIN
CREATE TABLE [Notification].[Notification](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[queueSysTime] [datetime2](7) NOT NULL,
	[templateID] [int] NOT NULL,
	[notificationSubject] [nvarchar](255) NOT NULL,
	[notificationBody] [nvarchar](max) NOT NULL,
	[reportLink] [varchar](1000) NULL,
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
/****** Object:  View [notification].[vNotification]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[notification].[vNotification]'))
EXEC dbo.sp_executesql @statement = N'


CREATE view [Notification].[vNotification]
as
		select n.[notificationID]
				,n.[templateID]
				,t.[category]
				,t.[enabled]
				,replace(t.[greeting],''%recipientList%'',l.[friendlyNameList])[greeting]
				,t.[signature]
				,l.[recipientList]
				,l.[recipientNameList]
				,l.[friendlyNameList]
				,n.[notificationSubject]
				,n.[notificationBody]
				,t.[profileName]
				,n.[reportLink]
				,case when n.[reportLink] is not null then ''Full details can be found at: '' + n.[reportLink] else '''' end [reportLinkText]
				,n.[suser_name]
				,n.[queueSysTime]
				,n.[processSysTime]
				,p.[Processed] 
				,rank() over (partition by t.[enabled],p.[Processed] order by n.[queueSysTime])[Priority]
		from [notification].[notification] n
		join [notification].[template] t on t.templateID=n.templateID
		join [notification].[vTemplateRecipientList] l on l.templateID=t.templateID
		join (select [notificationID],case when [processSysTime] is null then 0 else 1 end [processed] from [notification].[notification] ) p on p.[notificationID]=n.notificationID


' 
GO
/****** Object:  View [notification].[vNotificationQueue]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[notification].[vNotificationQueue]'))
EXEC dbo.sp_executesql @statement = N'
CREATE  VIEW [Notification].[vNotificationQueue]

AS

SELECT  
      [notificationID]  
FROM  [notification].[Notification]
WHERE Processed =0
      AND ISNULL([ExpiryDate],getdate()) >= getdate()' 
GO
/****** Object:  Table [notification].[solution]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[solution]') AND type in (N'U'))
BEGIN
CREATE TABLE [Notification].[solution](
	[solutionID] [int] IDENTITY(1,1) NOT NULL,
	[solutionName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[solutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
END
GO
SET IDENTITY_INSERT [notification].[Notification] ON 

GO
INSERT [notification].[Notification] ([notificationID], [queueSysTime], [templateID], [notificationSubject], [notificationBody], [reportLink], [processSysTime], [ExpiryDate], [Processed], [suser_name]) VALUES (1, CAST(N'2018-05-24T16:10:42.6647663' AS DateTime2), 2, N'MDS Station Changes', N' Number of New Records : 0,   Number of Updated Records : 1138', N'https://app-reports-dev01/reports/report/MDSIntegration/MasterStationAlertDetails?LoadId=0', CAST(N'2018-05-25T08:00:07.1302975' AS DateTime2), CAST(N'2018-05-26T00:00:00.0000000' AS DateTime2), 1, N'SQLProxyBIDev@prsformusic.com')
GO
INSERT [notification].[Notification] ([notificationID], [queueSysTime], [templateID], [notificationSubject], [notificationBody], [reportLink], [processSysTime], [ExpiryDate], [Processed], [suser_name]) VALUES (2, CAST(N'2018-05-25T08:02:13.9590361' AS DateTime2), 2, N'MDS Station Changes', N' Number of New Records : 0,   Number of Updated Records : 1673', N'https://app-reports-dev01/reports/report/MDSIntegration/MasterStationAlertDetails?LoadId=0', CAST(N'2018-05-25T08:28:07.1404348' AS DateTime2), CAST(N'2018-05-27T00:00:00.0000000' AS DateTime2), 1, N'SQLProxyBIDev@prsformusic.com')
GO
SET IDENTITY_INSERT [notification].[Notification] OFF
GO
SET IDENTITY_INSERT [notification].[recipient] ON 

GO
INSERT [notification].[recipient] ([recipientID], [recipientName], [recipientEmail], [friendlyName]) VALUES (1, N'Tony Wilkinson', N'tony.wilkinson@prsformusic.com', N'Tony')
GO
INSERT [notification].[recipient] ([recipientID], [recipientName], [recipientEmail], [friendlyName]) VALUES (2, N'Senay Yilmaz', N'senay.yilmaz@prsformusic.com', N'Senay')
GO
INSERT [notification].[recipient] ([recipientID], [recipientName], [recipientEmail], [friendlyName]) VALUES (3, N'Ian Norman', N'ian.norman@prsformusic.com', N'Ian')
GO
SET IDENTITY_INSERT [notification].[recipient] OFF
GO
SET IDENTITY_INSERT [notification].[template] ON 

GO
INSERT [notification].[template] ([templateID], [templateName], [category], [enabled], [profileName], [greeting], [bodyText], [signature]) VALUES (1, N'Notification Service Test Email', N'INFO', 1, N'AZI-MS-SQL-T001 SQL Database Mail', N'Hi %recipientList%,', N'This is test body text', N'Regards, PRS BI Team')
GO
INSERT [notification].[template] ([templateID], [templateName], [category], [enabled], [profileName], [greeting], [bodyText], [signature]) VALUES (2, N'MDS Station Changes', N'INFO', 1, N'AZI-MS-SQL-T001 SQL Database Mail', N'Hi %recipientList%,', NULL, N'Regards, PRS BI Team')
GO
SET IDENTITY_INSERT [notification].[template] OFF
GO
INSERT [notification].[templateRecipient] ([templateID], [recipientID]) VALUES (1, 1)
GO
INSERT [notification].[templateRecipient] ([templateID], [recipientID]) VALUES (2, 1)
GO
INSERT [notification].[templateRecipient] ([templateID], [recipientID]) VALUES (2, 2)
GO
INSERT [notification].[templateRecipient] ([templateID], [recipientID]) VALUES (2, 3)
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
/****** Object:  StoredProcedure [notification].[uspGetNotificationFromQueue]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspGetNotificationFromQueue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspGetNotificationFromQueue] AS' 
END
GO

ALTER PROCEDURE [Notification].[uspGetNotificationFromQueue]
	@notificationId int
AS

   SELECT    
      
	     n.[recipientList],
		 n.[notificationSubject],
		(n.[greeting] + char(13)
					  + n.[notificationBody] + char(13)
					  + '  ' + n.[reportLinkText] + char(13)
					  + n.[signature] ) as notificationBody,
		  n.[profileName]
	FROM [notification].[vNotification] n
	WHERE  n.[Processed]=0 and n.[enabled]=1  and n.[notificationID] = @notificationId
	





GO
/****** Object:  StoredProcedure [notification].[uspProcessNotification]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspProcessNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspProcessNotification] AS' 
END
GO

ALTER PROCEDURE [Notification].[uspProcessNotification]
  @notificationId int
AS
BEGIN

		update [notification].[notification]
		set [processSysTime]=sysutcdatetime(),
		     Processed = 1
		where [notificationID] = @notificationID
	
END



GO
/****** Object:  StoredProcedure [notification].[uspProcessQueue]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspProcessQueue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspProcessQueue] AS' 
END
GO
ALTER PROCEDURE [Notification].[uspProcessQueue]
as
begin
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
				,@body = n.[greeting] + char(13)
						 + n.[notificationBody] + char(13)
						 + ' ' + n.[reportLinkText] + char(13)
						 + n.[signature]
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
	end
end




GO
/****** Object:  StoredProcedure [notification].[uspRequestNotification]    Script Date: 25/05/2018 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[notification].[uspRequestNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [notification].[uspRequestNotification] AS' 
END
GO

ALTER PROCEDURE [Notification].[uspRequestNotification]
	@notificationTemplate varchar(100),
	@notificationSubject nvarchar(255),
	@notificationBody nvarchar(max),
	@reportLink varchar(1000) = null,
	@notificationExpiryDate varchar(8) = null
as
	declare @retval int = 0

	if exists (select templateID from [notification].[template] where [templateName]=@notificationTemplate)
	begin
	insert [notification].[notification]([templateID],[notificationSubject],[notificationBody],[reportLink],[ExpiryDate],[Processed],[suser_name])
	select	[templateID]
			,@notificationSubject
			,@notificationBody
			,@reportLink
			,ISNULL(@notificationExpiryDate, convert(varchar(8),dateadd(day,2,getdate()),112))
			,0
			,suser_name()
	from	[notification].[template]
	where	[templateName]=@notificationTemplate
	if (@@rowcount=1) select @retval = 1
	end
	return @retval



GO
