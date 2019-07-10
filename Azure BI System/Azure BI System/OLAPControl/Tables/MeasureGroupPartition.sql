CREATE TABLE [OLAPControl].[MeasureGroupPartition] (
    [MeasureGroupPartitionId] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [MeasureGroupId]          SMALLINT     NOT NULL,
    [PartitionID]             VARCHAR (20) NOT NULL,
    [PartitionDefinitionId]   TINYINT      NOT NULL,
    [FromDateId]              INT          NOT NULL,
    [ToDateId]                INT          NOT NULL,
    [PartitionSliceDimension] VARCHAR (50) NULL,
    [PartitionSliceAttribute] VARCHAR (50) NULL,
    [PartitionSliceKey]       INT          NULL,
    [Active]                  BIT          NOT NULL,
    [Dirty]                   BIT          NOT NULL,
    CONSTRAINT [pkcMeasureGroupPartition] PRIMARY KEY CLUSTERED ([MeasureGroupPartitionId] ASC),
    CONSTRAINT [fkMeasureGroupPartition_MeasureGroup] FOREIGN KEY ([MeasureGroupId]) REFERENCES [OLAPControl].[MeasureGroup] ([MeasureGroupId])
);

