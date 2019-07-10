CREATE TABLE [Control].[Status] (
    [StatusId]    TINYINT        IDENTITY (1, 1) NOT NULL,
    [Code]        CHAR (3)       NOT NULL,
    [Name]        VARCHAR (100)  NULL,
    [Description] VARCHAR (2000) NULL,
    CONSTRAINT [pkcStatusId] PRIMARY KEY CLUSTERED ([StatusId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ixuCode]
    ON [Control].[Status]([Code] ASC);

