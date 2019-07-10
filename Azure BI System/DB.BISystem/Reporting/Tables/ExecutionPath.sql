CREATE TABLE [Reporting].[ExecutionPath] (
    [ExecutionLogID]             UNIQUEIDENTIFIER NOT NULL,
    [ExecutionID]                NVARCHAR (64)    NULL,
    [ActionType]                 INT              NULL,
    [FormatType]                 INT              NULL,
    [StatusCode]                 INT              NULL,
    [TimeStart]                  DATETIME         NULL,
    [TimeEnd]                    DATETIME         NULL,
    [TimeDataRetrieval]          INT              NULL,
    [TimeProcessing]             INT              NULL,
    [TimeRendering]              INT              NULL,
    [ByteCount]                  BIGINT           NULL,
    [RowCount]                   BIGINT           NULL,
    [TotalExecTime]              INT              NULL,
    [ScalabilityTime_Paging]     INT              NULL,
    [ScalabilityTime_Processing] INT              NULL,
    [EstMemoryKB_Paging]         INT              NULL,
    [EstMemoryKB_Processing]     INT              NULL,
    CONSTRAINT [PK__Execution] PRIMARY KEY CLUSTERED ([ExecutionLogID] ASC)
);

