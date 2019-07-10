CREATE TABLE [Secure].[Configurations] (
    [ConfigurationId] INT IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (100) NOT NULL,
    [Description]     VARCHAR (250) NOT NULL,
    [Value]           VARCHAR (250) NOT NULL, 
    [CreatedAt]		  DATETIME NOT NULL,
	[Value_Enc]       VARCHAR (250) NULL
);