CREATE TABLE [Control].[NotificationEmailMessageFormats] (
    [NotificationMessageFormatId] INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]                   BIT            NULL,
    [NotificationMessageTypeId]   INT            NOT NULL,
    [MessageTypeName]             NVARCHAR (200) NULL,
    [MessageHTML]                 NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [pkcNotificationMessageFormatId] PRIMARY KEY CLUSTERED ([NotificationMessageFormatId] ASC),
    CONSTRAINT [fkNotificationEmailMessageFormats_NotificationMessageTypeId] FOREIGN KEY ([NotificationMessageTypeId]) REFERENCES [Control].[NotificationMessageType] ([NotificationMessageTypeId])
);

