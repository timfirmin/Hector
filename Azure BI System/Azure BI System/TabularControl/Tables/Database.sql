CREATE TABLE [TabularControl].[Database] (
    [DatabaseId]				TINYINT			IDENTITY (1, 1) NOT NULL,
    [Name]						VARCHAR (128)	NOT NULL,
	[ServerConnectionString]	VARCHAR(512)	NOT NULL,
	[DataSourceName]			VARCHAR(128)	NOT NULL,
    CONSTRAINT [pkTabularControlDatabase] PRIMARY KEY CLUSTERED ([DatabaseId] ASC)
);

