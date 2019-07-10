CREATE TABLE [Azure].[ProcessScheduleException] 
(
	[ProcessScheduleExceptionId] INT NOT NULL IDENTITY(1,1),
    [ProcessId] INT  NOT NULL,
    [Date]      DATE NOT NULL,
    [Enabled]   BIT  NOT NULL,
	[CreatedAt]	DateTime2 NOT NULL DEFAULT (SYSDATETIME()),
	CONSTRAINT PK_ProcessScheduleException PRIMARY KEY (ProcessScheduleExceptionId),
	CONSTRAINT FK_ProcessScheduleException_Process_ProcessId FOREIGN KEY ([ProcessId]) REFERENCES [Azure].[Process](ProcessId)
);

