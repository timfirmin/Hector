CREATE TABLE [Reporting].[StatusCodes] (
    [StatusCode] INT           IDENTITY (100, 1) NOT NULL,
    [Status]     NVARCHAR (40) NOT NULL,
    CONSTRAINT [PK_StatusCode] PRIMARY KEY CLUSTERED ([StatusCode] ASC)
);

