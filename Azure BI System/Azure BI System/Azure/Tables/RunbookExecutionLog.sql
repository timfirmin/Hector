CREATE TABLE [Azure].[RunbookExecutionLog](
	[RunbookExecutionLogId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Status] [smallint] NULL,
	[CreatedAt] [datetime2](7) NOT NULL
)
