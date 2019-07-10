CREATE TABLE [Control].[Entity] (
    [EntityId]       INT      IDENTITY (1, 1) NOT NULL,
    [ParentEntityId] INT      NULL,
    [SourceFileId]   INT      NOT NULL,
    [EntityTypeId]   SMALLINT NOT NULL,
    [LoadId]         INT      NOT NULL,
    [ApplicationId]  SMALLINT NULL,
    CONSTRAINT [pkcEntityId] PRIMARY KEY CLUSTERED ([EntityId] ASC),
    CONSTRAINT [fkEntity_Application] FOREIGN KEY ([ApplicationId]) REFERENCES [Control].[Application] ([ApplicationId]),
    CONSTRAINT [fkEntity_EntityType] FOREIGN KEY ([EntityTypeId]) REFERENCES [Control].[EntityType] ([EntityTypeId]),
    CONSTRAINT [fkEntity_SourceFile] FOREIGN KEY ([SourceFileId]) REFERENCES [Control].[SourceFile] ([SourceFileId])
);

