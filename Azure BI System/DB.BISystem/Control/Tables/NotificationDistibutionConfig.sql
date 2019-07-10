CREATE TABLE [Control].[NotificationDistibutionConfig] (
    [NotificationDistibutionConfigId] INT IDENTITY (1, 1) NOT NULL,
    [IsDeleted]                       BIT NULL,
    [NotificationGroupID]             INT NULL,
    [NotificationSubscriberID]        INT NULL,
    [NotificationSeverityId]          INT NOT NULL,
    [IsGroupMessage]                  BIT NOT NULL,
    CONSTRAINT [pkcNotificationDistibutionConfigId] PRIMARY KEY CLUSTERED ([NotificationDistibutionConfigId] ASC),
    CONSTRAINT [fkNotificationDistibutionConfig_NotificationGroupID] FOREIGN KEY ([NotificationGroupID]) REFERENCES [Control].[NotificationGroups] ([NotificationGroupID]),
    CONSTRAINT [fkNotificationDistibutionConfig_NotificationSeverityID] FOREIGN KEY ([NotificationSeverityId]) REFERENCES [Control].[NotificationSeverity] ([NotificationSeverityId]),
    CONSTRAINT [fkNotificationDistibutionConfig_NotificationSubscriberID] FOREIGN KEY ([NotificationSubscriberID]) REFERENCES [Control].[NotificationSubscribers] ([NotificationSubscriberID])
);

