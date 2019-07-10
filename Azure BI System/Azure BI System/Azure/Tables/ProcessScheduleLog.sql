CREATE TABLE [Azure].[ProcessScheduleLog] (
    [ProcessId] INT  NOT NULL,
    [Date]      DATE NOT NULL,
    [Status]    INT NOT NULL DEFAULT (0),
	[CreatedAt]	DATETIME2 NOT NULL DEFAULT (SYSDATETIME()),
	[UpdatedAt] DATETIME2 NULL,
	CONSTRAINT PK_ProcessScheduleLog PRIMARY KEY CLUSTERED ([ProcessId],[Date]),
	CONSTRAINT FK_ProcessScheduleLog_Process_ProcessId FOREIGN KEY ([ProcessId]) REFERENCES [Azure].[Process](ProcessId)
);

