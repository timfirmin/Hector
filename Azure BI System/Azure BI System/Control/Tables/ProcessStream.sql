CREATE TABLE [Control].[ProcessStream] (
    [ProcessStreamId]    TINYINT        IDENTITY (1, 1) NOT NULL,
    [Code]               CHAR (12)      NOT NULL,
    [Name]               VARCHAR (100)  NULL,
    [Description]        VARCHAR (2000) NULL,
    [ProcessStreamOrder] TINYINT        NOT NULL,
    [DateColumnName]     VARCHAR (25)   NULL
);

