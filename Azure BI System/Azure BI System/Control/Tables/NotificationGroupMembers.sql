CREATE TABLE [Control].[NotificationGroupMembers] (
    [NotificationGroupMemberID] INT IDENTITY (1, 1) NOT NULL,
    [IsDeleted]                 BIT NULL,
    [NotificationGroupID]       INT NOT NULL,
    [NotificationSubscriberID]  INT NOT NULL,
    CONSTRAINT [pkcNotificationGroupMemberID] PRIMARY KEY CLUSTERED ([NotificationGroupMemberID] ASC),
    CONSTRAINT [fkNotificationGroupMembers_NotificationGroupID] FOREIGN KEY ([NotificationGroupID]) REFERENCES [Control].[NotificationGroups] ([NotificationGroupID]),
    CONSTRAINT [fkNotificationGroupMembers_NotificationSubscriberID] FOREIGN KEY ([NotificationSubscriberID]) REFERENCES [Control].[NotificationSubscribers] ([NotificationSubscriberID])
);

