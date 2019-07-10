CREATE TABLE [Control].[NotificationType] (
    [NotificationTypeId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]               VARCHAR (100)  NULL,
    [Description]        VARCHAR (2000) NULL,
    [Recipients]         NVARCHAR (MAX) NULL,
    CONSTRAINT [pkcNotificationTypeId] PRIMARY KEY CLUSTERED ([NotificationTypeId] ASC)
);

