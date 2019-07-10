CREATE TABLE [Audit].[SourceFileProcessStream] (
    [SourceFileProcessStreamId] INT          IDENTITY (1, 1) NOT NULL,
    [SourceFileId]              INT          NOT NULL,
    [ProcessStream]             VARCHAR (50) NOT NULL,
    [LoadProcess]               VARCHAR (50) NULL,
    [LoadStatusTypeId]          INT          NOT NULL,
    [LoadId]                    INT          NOT NULL,
    [CreatedBy]                 [sysname]    DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]               DATETIME     DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]                 [sysname]    DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]               DATETIME     DEFAULT (getdate()) NOT NULL,
    [RowVersion]                ROWVERSION   NOT NULL,
    CONSTRAINT [pkcSourceFileProcessStreamId] PRIMARY KEY CLUSTERED ([SourceFileProcessStreamId] ASC)
);

