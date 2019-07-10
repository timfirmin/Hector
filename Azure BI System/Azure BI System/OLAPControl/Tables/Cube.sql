CREATE TABLE [OLAPControl].[Cube] (
    [CubeId]     TINYINT       IDENTITY (1, 1) NOT NULL,
    [DatabaseId] TINYINT       NOT NULL,
    [CubeName]   VARCHAR (128) NOT NULL,
	[RequiresProcess]  BIT           NULL,
	[AnalyticsProcess] BIT           NULL,	
    CONSTRAINT [pkcCube] PRIMARY KEY CLUSTERED ([CubeId] ASC),
    CONSTRAINT [fkCubeDatabase] FOREIGN KEY ([DatabaseId]) REFERENCES [OLAPControl].[Database] ([DatabaseId])
);

