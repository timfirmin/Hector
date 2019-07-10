CREATE TABLE [OLAPControl].[PartitionDefinition] (
    [PartitionDefinitionId]   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [PartitionDefinitionName] VARCHAR (50) NOT NULL,
    [PartitionPrefix]         VARCHAR (50) NOT NULL,
    CONSTRAINT [pkcPartitionDefinition] PRIMARY KEY CLUSTERED ([PartitionDefinitionId] ASC)
);

