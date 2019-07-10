CREATE TABLE [Control].[NotificationGroups] (
    [NotificationGroupID] INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]           BIT            NULL,
    [GroupName]           NVARCHAR (25)  NOT NULL,
    [GroupDescription]    NVARCHAR (200) NOT NULL,
    CONSTRAINT [pkcNotificationGroupID] PRIMARY KEY CLUSTERED ([NotificationGroupID] ASC)
);

