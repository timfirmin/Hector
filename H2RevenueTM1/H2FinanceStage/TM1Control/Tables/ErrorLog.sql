CREATE TABLE [TM1Control].[ErrorLog] (
    [ErrorLogUniqueKey]    INT           IDENTITY (1, 1) NOT NULL,
    [FileEnvironment]      VARCHAR (50)  NOT NULL,
    [ErrorLogPackageName]  VARCHAR (255) NULL,
    [ErrorLogTaskName]     VARCHAR (255) NULL,
    [ErrorLogUserName]     VARCHAR (255) NULL,
    [ErrorLogSummaryDescr] VARCHAR (255) NULL,
    [ErrorTableName]       VARCHAR (255) NULL,
    [ErrorFilePath]        VARCHAR (255) NOT NULL,
    [ErrorMessage]         VARCHAR (MAX) NOT NULL,
    [ErrorLogLoadId]       INT           NULL,
    [InsertTimeStamp]      DATETIME      CONSTRAINT [DF_ErrorLog_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED ([ErrorLogUniqueKey] ASC)
);

