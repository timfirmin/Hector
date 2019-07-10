CREATE TABLE [OLAPControl].[MeasureGroupDimension] (
    [MeasureGroupDimensionId] SMALLINT IDENTITY (1, 1) NOT NULL,
    [DimensionId]             SMALLINT NOT NULL,
    [MeasureGroupId]          SMALLINT NOT NULL,
    CONSTRAINT [pkcMeasureGroupDimension] PRIMARY KEY CLUSTERED ([MeasureGroupDimensionId] ASC),
    CONSTRAINT [fkMeasureGroupDimensionDimension] FOREIGN KEY ([DimensionId]) REFERENCES [OLAPControl].[Dimension] ([DimensionId]),
    CONSTRAINT [fkMeasureGroupDimensionMeasureGroup] FOREIGN KEY ([MeasureGroupId]) REFERENCES [OLAPControl].[MeasureGroup] ([MeasureGroupId])
);

