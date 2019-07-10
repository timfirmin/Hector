CREATE TABLE [OLAPControl].[Dimension] (
    [DimensionId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [DimensionName] VARCHAR (128) NOT NULL,
    CONSTRAINT [pkcDimension] PRIMARY KEY CLUSTERED ([DimensionId] ASC)
);

