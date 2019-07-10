CREATE TABLE [Control].[BatchControl] (
    [GlobalLoadId]      INT              IDENTITY (1, 1) NOT NULL,
    [GlobalExecutionId] UNIQUEIDENTIFIER NULL,
    [StartTime]         DATETIME         NULL,
    [EndTime]           DATETIME         NULL,
    [SourceFileId]      INT              NULL
);

