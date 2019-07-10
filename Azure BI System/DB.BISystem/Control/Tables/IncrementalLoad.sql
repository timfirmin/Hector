CREATE TABLE [Control].[IncrementalLoad] (
    [PackageName]      VARCHAR (100) NOT NULL,
    [LoadDate]         DATETIME      NOT NULL,
    [PreviousLoadDate] DATETIME      NULL,
    [LoadStatus]       BIT           NULL
);

