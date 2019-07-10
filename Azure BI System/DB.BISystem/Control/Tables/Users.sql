CREATE TABLE [Control].[Users] (
    [UserKey]       INT            IDENTITY (100, 1) NOT NULL,
    [UserName]      NVARCHAR (260) NOT NULL,
    [UserNameShort] NVARCHAR (260) NOT NULL,
    CONSTRAINT [pkcUsers] PRIMARY KEY CLUSTERED ([UserKey] ASC)
);

