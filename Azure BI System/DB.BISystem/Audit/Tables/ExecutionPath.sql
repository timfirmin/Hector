﻿CREATE TABLE [Audit].[ExecutionPath] (
    [ExecutionLogId]            UNIQUEIDENTIFIER NOT NULL,
    [ExecutionId]               NVARCHAR (64)    NULL,
    [ActionType]                INT              NULL,
    [FormatType]                INT              NULL,
    [StatusCode]                INT              NULL,
    [TimeStart]                 DATETIME         NULL,
    [TimeEnd]                   DATETIME         NULL,
    [TimeDataRetrieval]         INT              NULL,
    [TimeProcessing]            INT              NULL,
    [TimeRendering]             INT              NULL,
    [ByteCount]                 BIGINT           NULL,
    [RowCount]                  BIGINT           NULL,
    [TotalExecTime]             INT              NULL,
    [ScalabilityTimePaging]     INT              NULL,
    [ScalabilityTimeProcessing] INT              NULL,
    [EstMemoryKBPaging]         INT              NULL,
    [EstMemoryKBProcessing]     INT              NULL,
    [CreatedBy]                 [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]               DATETIME         DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]                 [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]               DATETIME         DEFAULT (getdate()) NOT NULL,
    [RowVersion]                ROWVERSION       NOT NULL,
    CONSTRAINT [pkcExecutionPath] PRIMARY KEY CLUSTERED ([ExecutionLogId] ASC)
);
