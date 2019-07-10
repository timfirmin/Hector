CREATE TABLE [DDIstaging].[NotificationLog] (
    [NotificationUniqueKey]        INT           IDENTITY (1, 1) NOT NULL,
    [NotificationPackageName]      VARCHAR (255) NULL,
    [NotificationTaskName]         VARCHAR (255) NULL,
    [NotificationFieldName]        VARCHAR (255) NULL,
    [NotificationFieldCode]        VARCHAR (255) NULL,
    [NotificationFieldDescription] VARCHAR (255) NULL,
    [NotificationFileLogKey]       INT           NULL,
    [InsertTimeStamp]              DATETIME      CONSTRAINT [DF_NotificationLog_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    [InsertBy]                     VARCHAR (150) CONSTRAINT [DF_NotificationLog_InsertBy] DEFAULT (suser_sname()) NOT NULL,
    CONSTRAINT [PK_NotificationLog] PRIMARY KEY CLUSTERED ([NotificationUniqueKey] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_NotificationLog]
    ON [DDIstaging].[NotificationLog]([NotificationFieldName] ASC, [NotificationFieldCode] ASC, [NotificationFileLogKey] ASC) WITH (IGNORE_DUP_KEY = ON);

