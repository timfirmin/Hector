CREATE TABLE [Control].[LoadStatusType] (
    [LoadStatusTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]             VARCHAR (50)  NOT NULL,
    [Description]      VARCHAR (100) NOT NULL,
    [ShortName]        VARCHAR (10)  NULL,
    [UpdateUser]       VARCHAR (150) NULL,
    [UpdateTime]       DATETIME      NULL,
    CONSTRAINT [pkcLoadStatusType] PRIMARY KEY CLUSTERED ([LoadStatusTypeId] ASC)
);

