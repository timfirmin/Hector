CREATE TABLE [Reporting].[Users] (
    [UserKey]       INT            IDENTITY (100, 1) NOT NULL,
    [UserName]      NVARCHAR (260) NOT NULL,
    [UserNameShort] NVARCHAR (260) NOT NULL,
    CONSTRAINT [PK__Users] PRIMARY KEY CLUSTERED ([UserKey] ASC) ON [PRIMARY]
);