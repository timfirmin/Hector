CREATE TABLE [Metadata].[Object] (
    [ObjectId]          INT            IDENTITY (1, 1) NOT NULL,
    [Title]             VARCHAR (50)   NULL,
    [Subject]           VARCHAR (500)  NULL,
    [Description]       VARCHAR (4000) NULL,
    [TypeId]            INT            NULL,
    [SourceId]          INT            NULL,
    [Creator]           NVARCHAR (150) NULL,
    [Publisher]         NVARCHAR (150) NULL,
    [ModifiedDate]      DATETIME       NULL,
    [SourceKey]         NVARCHAR (10)  NULL,
    [ObjectContainerId] INT            NULL,
    CONSTRAINT [pkObjectId] PRIMARY KEY CLUSTERED ([ObjectId] ASC)
);
GO

ALTER TABLE [Metadata].[Object] WITH NOCHECK
    ADD CONSTRAINT [fkObject_ObjectType] FOREIGN KEY ([TypeId]) REFERENCES [Metadata].[ObjectType] ([ObjectTypeId]);


GO

ALTER TABLE [Metadata].[Object] WITH NOCHECK
    ADD CONSTRAINT [fkObject_Source] FOREIGN KEY ([SourceId]) REFERENCES [Metadata].[Source] ([SourceId]);


GO