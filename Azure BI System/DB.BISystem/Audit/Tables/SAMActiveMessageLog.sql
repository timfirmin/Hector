CREATE TABLE [Audit].[SAMActiveMessageLog] (
    [SAMActiveMessageLogId]        INT           IDENTITY (100000, 1) NOT NULL,
    [ApplicationLoadId]            INT           NULL,
    [ApplicationName]              VARCHAR (255) NULL,
    [ApplicationPackageName]       VARCHAR (255) NULL,
    [ApplicationSSISProjectFolder] VARCHAR (255) NULL,
    [ApplicationUserName]          VARCHAR (255) NULL,
    [ApplicationRunTime]           DATETIME      NULL,
    [SAMApplicationCode]           VARCHAR (255) NULL,
    [SAMTypeCode]                  VARCHAR (255) NULL,
    [SAMStartDate]                 DATETIME      NULL,
    [SAMEndDate]                   DATETIME      NULL,
    [SAMMessage]                   VARCHAR (255) NULL,
    [SAMTitle]                     VARCHAR (255) NULL,
    [SAMDescription]               VARCHAR (255) NULL,
    [SAMMessageID]                 INT           NULL,
    [SAMProgressYN]                VARCHAR (1)   NULL,
    [SAMProgressInt]               AS            (case when [SAMProgressYN]='Y' then (1) else (0) end),
    [InsertDateTime]               DATETIME      CONSTRAINT [DF_SAMActiveMessageLog_InsertDateTime] DEFAULT (getdate()) NOT NULL
);

