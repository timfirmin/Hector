CREATE TABLE [notification].[notification] (
    [notificationID]      INT            IDENTITY (1, 1) NOT NULL,
    [queueSysTime]        DATETIME2 (7)  CONSTRAINT [df_queue_queueSysTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [templateID]          INT            NOT NULL,
    [notificationSubject] NVARCHAR (255) NOT NULL,
    [notificationBody]    NVARCHAR (MAX) NOT NULL,
    [reportLink]          VARCHAR (1000) NULL,
    [processSysTime]      DATETIME2 (7)  NULL,
    [suser_name]          VARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([notificationID] ASC)
);



