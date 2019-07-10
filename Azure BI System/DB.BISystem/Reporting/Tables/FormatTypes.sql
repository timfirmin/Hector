CREATE TABLE [Reporting].[FormatTypes] (
    [FormatType] INT           IDENTITY (100, 1) NOT NULL,
    [Format]     NVARCHAR (26) NULL,
    CONSTRAINT [PK__FormatTypes] PRIMARY KEY CLUSTERED ([FormatType] ASC)
);

