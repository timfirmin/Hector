CREATE TABLE [Control].[FileTypeGroup] (
    [FileTypeGroupId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (100)  NULL,
    [Code]            VARCHAR (5)    NULL,
    [Description]     VARCHAR (2000) NULL,
    PRIMARY KEY CLUSTERED ([FileTypeGroupId] ASC)
);

