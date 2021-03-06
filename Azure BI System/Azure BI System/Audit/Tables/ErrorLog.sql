﻿CREATE TABLE [Audit].[ErrorLog] (
    [ErrorLogId]            INT              DEFAULT (NEXT VALUE FOR [Audit].[seqErrorLogId]) NOT NULL,
    [QueueTaskId]           INT              NULL,
    [EventType]             VARCHAR (50)     NULL,
    [EventName]             VARCHAR (100)    NULL,
    [ErrorCount]            INT              NULL,
    [StatusId]              TINYINT          NULL,
    [EntityId]              INT              NULL,
    [RowNumber]             INT              NULL,
    [RowId]                 BIGINT           NULL,
    [Technology]            VARCHAR (100)    NULL,
    [Component]             VARCHAR (100)    NULL,
    [Version]               VARCHAR (100)    NULL,
    [ProcessStream]         VARCHAR (100)    NULL,
    [MachineName]           VARCHAR (100)    NULL,
    [PackageId]             UNIQUEIDENTIFIER NULL,
    [ExecutionInstanceGUID] UNIQUEIDENTIFIER NULL,
    [CreatedDate]           DATETIME         DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             INT              DEFAULT ((-1)) NOT NULL,
    [UpdatedBy]             [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]           DATETIME         DEFAULT (getdate()) NOT NULL,
    [RowVersion]            ROWVERSION       NOT NULL,
    PRIMARY KEY CLUSTERED ([ErrorLogId] ASC),
    CONSTRAINT [fkErrorLog_Entity] FOREIGN KEY ([EntityId]) REFERENCES [Control].[Entity] ([EntityId]),
    CONSTRAINT [fkErrorLog_Status] FOREIGN KEY ([StatusId]) REFERENCES [Control].[Status] ([StatusId])
);

