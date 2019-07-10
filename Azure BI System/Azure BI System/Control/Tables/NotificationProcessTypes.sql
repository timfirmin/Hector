CREATE TABLE [Control].[NotificationProcessTypes] (
    [NotificationProcessTypeId]   INT           IDENTITY (1, 1) NOT NULL,
    [NotificationProcessType]     NVARCHAR (25) NOT NULL,
    [NotificationProcessTypeCode] NVARCHAR (5)  NULL,
    CONSTRAINT [pkcNotificationProcessTypeId] PRIMARY KEY CLUSTERED ([NotificationProcessTypeId] ASC)
);

