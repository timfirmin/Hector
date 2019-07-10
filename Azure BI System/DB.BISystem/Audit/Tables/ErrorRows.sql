CREATE TABLE [Audit].[ErrorRows] (
    [ErrorRowId]       INT              IDENTITY (1, 1) NOT NULL,
    [LoadId]           INT              NULL,
    [RowId]            BIGINT           NULL,
    [RowNumber]        INT              NULL,
    [EntityId]         INT              NULL,
    [TaskId]           UNIQUEIDENTIFIER NULL,
    [TaskName]         VARCHAR (200)    NULL,
    [PackageId]        UNIQUEIDENTIFIER NULL,
    [PackageName]      VARCHAR (200)    NULL,
    [ErrorCode]        INT              NULL,
    [ErrorDescription] VARCHAR (2000)   NULL,
    [XmlRow]           XML              NULL,
    [CreatedBy]        [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]      DATETIME         DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]        [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]      DATETIME         DEFAULT (getdate()) NOT NULL,
    [RowVersion]       ROWVERSION       NOT NULL,
    CONSTRAINT [pkcErrorRows] PRIMARY KEY CLUSTERED ([ErrorRowId] ASC)
);

