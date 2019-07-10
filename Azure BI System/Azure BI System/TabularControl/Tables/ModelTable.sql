CREATE TABLE [TabularControl].[ModelTable] (
    [ModelTableId]		SMALLINT		IDENTITY (1, 1) NOT NULL,
	[DatabaseId]		TINYINT			NOT NULL,
	[ProcessLevelId]	TINYINT			NOT NULL,
    [TableName]			VARCHAR (128)	NOT NULL,
	[IsDimensionYN]		CHAR(1)			NOT NULL,
    CONSTRAINT [pkTabularControlModelTable] PRIMARY KEY CLUSTERED ([ModelTableId] ASC),
	CONSTRAINT [fkTabularControlModelTable_TabularControlDatabase] FOREIGN KEY ([DatabaseId]) REFERENCES [TabularControl].[Database]([DatabaseId]),
	CONSTRAINT [fkTabularControlModelTable_TabularControlProcesLevel] FOREIGN KEY ([ProcessLevelId]) REFERENCES [TabularControl].[ProcessLevel]([ProcessLevelId])
);
	