CREATE TABLE [Control].[PartitionLoad] (
    [PartitionLoadId]   INT          IDENTITY (1, 1) NOT NULL,
    [Source]            VARCHAR (50) NULL,
    [PartitionFunction] VARCHAR (50) NULL,
    [PartitionLoadDate] DATETIME     NULL,
    [MinLoadDate]       INT          NULL,
    [MaxLoadDate]       INT          NULL,
    [PartitionsCreated] INT          NULL,
    [LoadSuccessful]    BIT          NULL,
    [LoadId]            INT          NULL,
    CONSTRAINT [pkcPartitionLoad] PRIMARY KEY CLUSTERED ([PartitionLoadId] ASC)
);

