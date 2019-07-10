CREATE TABLE [Azure].[AutomationLogs] (
    [PId]            INT              IDENTITY (1, 1) NOT NULL,
    [LogLevel]       INT              NULL,
    [MessageDetails] NVARCHAR (MAX)   NULL,
    [RunbookName]    NVARCHAR (MAX)   NULL,
    [Timestamp]      DATETIME         NULL,
    [OperationID]    UNIQUEIDENTIFIER NULL
);


GO
CREATE CLUSTERED INDEX [AzureLogs_IDX]
    ON [Azure].[AutomationLogs]([PId] ASC);

