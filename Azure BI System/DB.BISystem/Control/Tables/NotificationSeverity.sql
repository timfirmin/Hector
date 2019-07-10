CREATE TABLE [Control].[NotificationSeverity] (
    [NotificationSeverityId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (20) NOT NULL,
    CONSTRAINT [pkcNotificationSeverityId] PRIMARY KEY CLUSTERED ([NotificationSeverityId] ASC)
);

