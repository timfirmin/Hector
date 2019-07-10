CREATE TABLE [Metadata].[ObjectType] (
    [ObjectTypeId] INT            IDENTITY (1, 1) NOT NULL,
    [Title]        VARCHAR (50)   NULL,
    [Description]  VARCHAR (4000) NULL,
    CONSTRAINT [pkcObjectType] PRIMARY KEY CLUSTERED ([ObjectTypeId] ASC)
);

