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
	[requestSource] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO

ALTER TABLE [notification].[Notification] ADD  CONSTRAINT [df_queue_queueSysTime]  DEFAULT (sysutcdatetime()) FOR [queueSysTime]
GO
