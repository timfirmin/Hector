CREATE TABLE [DataQuality].[Screen] (
    [ScreenId]           INT            IDENTITY (1, 1) NOT NULL,
    [ScreenName]         VARCHAR (50)   NOT NULL,
    [ScreenDescription]  VARCHAR (200)  NOT NULL,
    [ProjectId]          INT            NULL,
    [EnvironmentId]      INT            NULL,
    [ObjectId]           VARCHAR (50)   NULL,
    [ScreenSeverityID]   TINYINT        NULL,
    [ScreenSQL]          VARCHAR (3000) NULL,
    [ReportSQL]          VARCHAR (3000) NULL,
    [ScreenReferenceSQL] VARCHAR (3000) NULL,
    [ReportTableName]    VARCHAR (50)   NULL,
    [CleanseSQL]         VARCHAR (3000) NULL,
    [Domain]             VARCHAR (10)   NULL,
    CONSTRAINT [pkcScreen] PRIMARY KEY CLUSTERED ([ScreenId] ASC)
);

