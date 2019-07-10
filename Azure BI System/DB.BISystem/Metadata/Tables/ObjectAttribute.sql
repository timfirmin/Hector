CREATE TABLE [Metadata].[ObjectAttribute] (
    [ObjectAttritributeId] INT            IDENTITY (1, 1) NOT NULL,
    [ObjectId]             INT            NOT NULL,
    [Name]                 VARCHAR (50)   NOT NULL,
    [Value]                NVARCHAR (100) NOT NULL,
    CONSTRAINT [pkObjectAttribute] PRIMARY KEY CLUSTERED ([ObjectAttritributeId] ASC),
    CONSTRAINT [fkObjectAttribute_Object] FOREIGN KEY ([ObjectId]) REFERENCES [Metadata].[Object] ([ObjectId])
);

