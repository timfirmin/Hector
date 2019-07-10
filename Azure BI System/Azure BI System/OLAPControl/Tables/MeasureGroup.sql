CREATE TABLE [OLAPControl].[MeasureGroup] (
    [MeasureGroupId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [CubeId]           TINYINT       NOT NULL,
    [MeasureGroupName] VARCHAR (128) NOT NULL,
    [CreatedBy]        [sysname]     DEFAULT (suser_sname()) NOT NULL,
    CONSTRAINT [pkcMeasureGroup] PRIMARY KEY CLUSTERED ([MeasureGroupId] ASC),
    CONSTRAINT [fkMeasureGroupCube] FOREIGN KEY ([CubeId]) REFERENCES [OLAPControl].[Cube] ([CubeId])
);

