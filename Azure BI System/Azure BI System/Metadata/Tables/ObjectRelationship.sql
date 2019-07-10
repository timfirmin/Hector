CREATE TABLE [Metadata].[ObjectRelationship] (
    [ObjectectRelationshipId] INT IDENTITY (1, 1) NOT NULL,
    [RelationshipTypeId]      INT NOT NULL,
    [FromObjectId]            INT NOT NULL,
    [ToObjectId]              INT NOT NULL,
    CONSTRAINT [pkcObjectRelationshipId] PRIMARY KEY CLUSTERED ([ObjectectRelationshipId] ASC)
);

GO

ALTER TABLE [Metadata].[ObjectRelationship] WITH NOCHECK
    ADD CONSTRAINT [fkObjectRelationship_Object] FOREIGN KEY ([FromObjectId]) REFERENCES [Metadata].[Object] ([ObjectId]);


GO

ALTER TABLE [Metadata].[ObjectRelationship] WITH NOCHECK
    ADD CONSTRAINT [fkObjectRelationship_Object1] FOREIGN KEY ([ToObjectId]) REFERENCES [Metadata].[Object] ([ObjectId]);


GO
ALTER TABLE [Metadata].[ObjectRelationship] WITH NOCHECK
    ADD CONSTRAINT [fkObjectRelationship_RelationshipType] FOREIGN KEY ([RelationshipTypeId]) REFERENCES [Metadata].[RelationshipType] ([RelationshipTypeId]);


GO