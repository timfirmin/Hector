
CREATE TABLE [Audit].[SAMActiveMessageLog](
	[SAMActiveMessageLogId] [int] IDENTITY(100000,1) NOT NULL,
	[ApplicationLoadId] [int] NULL,
	[ApplicationName] [varchar](255) NULL,
	[ApplicationPackageName] [varchar](255) NULL,
	[ApplicationSSISProjectFolder] [varchar](255) NULL,
	[ApplicationUserName] [varchar](255) NULL,
	[ApplicationRunTime] [datetime] NULL,
	[SAMApplicationCode] [varchar](255) NULL,
	[SAMTypeCode] [varchar](255) NULL,
	[SAMStartDate] [datetime] NULL,
	[SAMEndDate] [datetime] NULL,
	[SAMMessage] [varchar](255) NULL,
	[SAMTitle] [varchar](255) NULL,
	[SAMDescription] [varchar](255) NULL,
	[SAMMessageID] [int] NULL,
	[SAMProgressYN] [varchar](1) NULL,
	[SAMProgressInt]  AS (case when [SAMProgressYN]='Y' then (1) else (0) end),
	[InsertDateTime] [datetime] NOT NULL
)

GO
ALTER TABLE [Audit].[SAMActiveMessageLog] ADD  CONSTRAINT [DF_SAMActiveMessageLog_InsertDateTime]  DEFAULT (getdate()) FOR [InsertDateTime]
GO