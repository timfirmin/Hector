CREATE TABLE [OLAPControl].[Database] (
    [DatabaseId]   TINYINT       IDENTITY (1, 1) NOT NULL,
    [DatabaseName] VARCHAR (128) NOT NULL,
    CONSTRAINT [pkcDatabase] PRIMARY KEY CLUSTERED ([DatabaseId] ASC)
);

