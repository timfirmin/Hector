﻿CREATE TABLE [Reporting].[ExecutionLogs] (
    [ExecutionLogID]             UNIQUEIDENTIFIER NOT NULL,
    [ReportKey]                  INT              NOT NULL,
    [UserKey]                    INT              NOT NULL,
    [MachineKey]                 INT              NOT NULL,
    [RequestType]                INT              NOT NULL,
    [FormatType]                 INT              NOT NULL,
    [StatusCode]                 INT              NOT NULL,
    [SourceType]                 INT              NOT NULL,
    [TimeStart]                  DATETIME         NOT NULL,
    [TimeEnd]                    DATETIME         NOT NULL,
    [TimeDataRetrieval]          INT              NOT NULL,
    [TimeProcessing]             INT              NOT NULL,
    [TimeRendering]              INT              NOT NULL,
    [ByteCount]                  BIGINT           NOT NULL,
    [RowCount]                   BIGINT           NOT NULL,
    [ExecutionID]                NVARCHAR (64)    NOT NULL,
    [TotalExecTime]              INT              NOT NULL,
    [ActionType]                 INT              NOT NULL,
    [ScalabilityTime_Paging]     INT              NOT NULL,
    [ScalabilityTime_Processing] INT              NOT NULL,
    [EstMemoryKB_Paging]         INT              NOT NULL,
    [EstMemoryKB_Processing]     INT              NOT NULL,
    CONSTRAINT [PK__ExecutionLogs] PRIMARY KEY CLUSTERED ([ExecutionLogID] ASC) ON [PRIMARY]
);

GO

ALTER TABLE [Reporting].[ExecutionLogs]
    ADD CONSTRAINT [DF__Execution__Execu__22AA2996] DEFAULT (newid()) FOR [ExecutionLogID];

GO