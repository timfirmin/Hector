CREATE TABLE [Metadata].[RelationshipType] (
    [RelationshipTypeId] INT            IDENTITY (1, 1) NOT NULL,
    [Title]              VARCHAR (50)   NOT NULL,
    [Description]        VARCHAR (4000) NOT NULL,
    CONSTRAINT [pkcRelationType] PRIMARY KEY CLUSTERED ([RelationshipTypeId] ASC)
);