CREATE TABLE [Control].[NotificationStatus] (
    [NotificationStatusId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]                 NVARCHAR (50)  NOT NULL,
    [Description]          NVARCHAR (100) NULL,
    CONSTRAINT [pkcNotificationStatusId] PRIMARY KEY CLUSTERED ([NotificationStatusId] ASC)
);

