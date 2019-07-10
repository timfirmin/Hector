CREATE TABLE [Audit].[ExecutionParameters] (
    [ExecutionParameterId] UNIQUEIDENTIFIER NOT NULL,
    [Name]                 NVARCHAR (2000)  NOT NULL,
    [Value]                NVARCHAR (MAX)   NOT NULL,
    [ExecutionLogId]       UNIQUEIDENTIFIER NOT NULL,
    [CreatedBy]            [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]          DATETIME         DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]          DATETIME         DEFAULT (getdate()) NOT NULL,
    [RowVersion]           ROWVERSION       NOT NULL,
    CONSTRAINT [pkcExecutionParameters] PRIMARY KEY CLUSTERED ([ExecutionParameterId] ASC)
);

