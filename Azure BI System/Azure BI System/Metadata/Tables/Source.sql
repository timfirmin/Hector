CREATE TABLE [Metadata].[Source] (
    [SourceId]    INT            NOT NULL,
    [Title]       VARCHAR (50)   NULL,
    [Description] VARCHAR (4000) NULL,
    CONSTRAINT [pkcSource] PRIMARY KEY CLUSTERED ([SourceId] ASC)
);