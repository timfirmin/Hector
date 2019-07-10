CREATE TABLE [Metadata].[ObjectIdentifier] (
    [IdentifierId] INT             NOT NULL,
    [ObjectId]     INT             NOT NULL,
    [Title]        VARCHAR (50)    NOT NULL,
    [Value]        NVARCHAR (4000) NOT NULL,
    CONSTRAINT [pkcIdentifier] PRIMARY KEY CLUSTERED ([IdentifierId] ASC)
);
GO

ALTER TABLE [Metadata].[ObjectIdentifier] WITH NOCHECK
    ADD CONSTRAINT [fkObject] FOREIGN KEY ([ObjectId]) REFERENCES [Metadata].[Object] ([ObjectId]);


GO