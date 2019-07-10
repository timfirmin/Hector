CREATE TABLE [Reporting].[ExecutionParameters] (
    [ExecutionParameterID] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Name]                 NVARCHAR (2000)  NOT NULL,
    [Value]                NVARCHAR (MAX)   NOT NULL,
    [ExecutionLogID]       UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([ExecutionParameterID] ASC)
);

