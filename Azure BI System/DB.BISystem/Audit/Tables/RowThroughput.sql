CREATE TABLE [Audit].[RowThroughput] (
    [RowThroughputId] INT           IDENTITY (1, 1) NOT NULL,
    [ExecutionId]     INT           NULL,
    [ExecutableId]    INT           NULL,
    [EnvironmentId]   INT           NULL,
    [EntityId]        INT           NULL,
    [LoadProcess]     VARCHAR (20)  NULL,
    [TaskName]        VARCHAR (100) NULL,
    [ProcessStream]   VARCHAR (50)  NULL,
    [ExtractedRows]   INT           NULL,
    [InsertedRows]    INT           NULL,
    [UpdatedRows]     INT           NULL,
    [DeletedRows]     INT           NULL,
    [FailedRows]      INT           NULL,
    [ArchivedRows]    INT           NULL,
    [BadRows]         INT           NULL,
    [LoadId]          INT           NOT NULL,
    [CreatedBy]       [sysname]     DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]     DATETIME      DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]       [sysname]     DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]     DATETIME      DEFAULT (getdate()) NOT NULL,
    [RowVersion]      ROWVERSION    NOT NULL,
    [ApplicationId]   SMALLINT      NULL,
    [SourceFileName]  VARCHAR (100) NULL,
    [EntityTypeTable] VARCHAR (100) NULL
);


GO
GRANT INSERT
    ON OBJECT::[Audit].[RowThroughput] TO [prs_subscribed_application]
    AS [dbo];

