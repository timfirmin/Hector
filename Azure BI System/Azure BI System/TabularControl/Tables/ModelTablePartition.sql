CREATE TABLE [TabularControl].[ModelTablePartition] (
    [ModelTablePartitionId]		INT				IDENTITY (1, 1) NOT NULL,
	[ModelTableId]				SMALLINT		NOT NULL,
	[ProcessStatusId]			TINYINT			NOT NULL,
    [Name]						VARCHAR (128)	NOT NULL,
	[StatusDateTime]			DATETIME2		NOT NULL,
	[SourceSQLQuery]			VARCHAR(MAX)	NOT NULL,
    CONSTRAINT [pkTabularTablePartition] PRIMARY KEY CLUSTERED ([ModelTablePartitionId] ASC),
	CONSTRAINT [fkTabularTablePartition_TabularControlModelTable] FOREIGN KEY ([ModelTableId]) REFERENCES [TabularControl].[ModelTable]([ModelTableId]),
	CONSTRAINT [fkTabularTablePartition_TabularControlProcessStatus] FOREIGN KEY ([ProcessStatusId]) REFERENCES [TabularControl].[ProcessStatus]([ProcessStatusId])
);


