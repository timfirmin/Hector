CREATE TABLE [Control].[NotificationMessageType] (
    [NotificationMessageTypeId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]                      VARCHAR (100)  NULL,
    [Description]               VARCHAR (2000) NULL,
    CONSTRAINT [pkcNotificationMessageTypeId] PRIMARY KEY CLUSTERED ([NotificationMessageTypeId] ASC)
);

