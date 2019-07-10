CREATE TABLE [Control].[NotificationSubscribers] (
    [NotificationSubscriberID]  INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]                 BIT            NULL,
    [FirstName]                 NVARCHAR (25)  NOT NULL,
    [LastName]                  NVARCHAR (25)  NULL,
    [EmailId]                   NVARCHAR (255) NOT NULL,
    [TextMessageNumber]         VARCHAR (20)   NULL,
    [InstantMessageID]          NVARCHAR (50)  NULL,
    [NotificationMessageTypeId] INT            NULL,
    CONSTRAINT [pkcNotificationSubscribers] PRIMARY KEY CLUSTERED ([NotificationSubscriberID] ASC)
);

