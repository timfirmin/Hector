CREATE TABLE [Azure].[EventLog]
(
	[EventLogId] INT IDENTITY(1,1),
	[SenderName] VARCHAR(100) NOT NULL,
	[ExecutionId] VARCHAR(255) NOT NULL,
	[EventMessage] VARCHAR(MAX) NOT NULL,
	[CreatedAt] DATETIME2(0),
	[Status] INT NOT NULL
)