CREATE TABLE [Azure].[NotificationReceipient]
(
	[NotificationReceipientId] INT NOT NULL IDENTITY(1,1),
	[Name] VARCHAR (255) NOT NULL,
	[Email] VARCHAR(255) NOT NULL,
	[Enabled] BIT NOT NULL,
	[Level] TINYINT NOT NULL,
	CONSTRAINT PK_NotificationReceipient PRIMARY KEY (NotificationReceipientId)
)