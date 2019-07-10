CREATE TABLE [TM1Control].[ImportFileType] (
    [PlanningFileTypeUniqueKey]           INT           IDENTITY (1, 1) NOT NULL,
    [PlanningFileTypeName]                VARCHAR (50)  NOT NULL,
    [PlanningFileTypeDescription]         VARCHAR (250) NOT NULL,
    [PlanningFileTypePrefixChars]         VARCHAR (250) NOT NULL,
    [PlanningFileTypeValidLoadChars]      VARCHAR (250) NULL,
    [PlanningFileTypeImportFolderName]    VARCHAR (50)  NOT NULL,
    [PlanningFileTypeFailedFolderName]    VARCHAR (50)  NULL,
    [PlanningFileTypeProcessedFolderName] VARCHAR (50)  NULL,
    [PlanningFileTypeArchiveFolderName]   VARCHAR (50)  NULL,
    [PlanningFileTypeStagingTable]        VARCHAR (50)  NOT NULL,
    [PlanningFileTypeFormat]              VARCHAR (50)  CONSTRAINT [DF_RevenueFileType_RevenueFileTypeFormat] DEFAULT ('CSV') NOT NULL,
    [PlanningFileTypeDelimiter]           VARCHAR (50)  CONSTRAINT [DF_RevenueFileType_RevenueFileTypeDelimiter] DEFAULT (',') NOT NULL,
    [PlanningFileTypeProcessFlag]         VARCHAR (1)   CONSTRAINT [DF_RevenueFileType_RevenueFileTypeValidFlag1] DEFAULT ('Y') NOT NULL,
    [PlanningFileTypeRowCheckField]       VARCHAR (50)  NOT NULL,
    [PlanningFileRetentionDays]           INT           CONSTRAINT [DF_ImportFileType_RevenueFileRetentionDays] DEFAULT ((30)) NULL,
    [InsertTimeStamp]                     DATETIME2 (2) CONSTRAINT [DF_RevenueFileType_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    [InsertLoadId]                        INT           CONSTRAINT [DF_ImportFileType_InsertLoadId] DEFAULT ((99999)) NULL,
    CONSTRAINT [PK_RevenueFileTypeLog] PRIMARY KEY CLUSTERED ([PlanningFileTypeUniqueKey] ASC)
);










GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ImportFileType]
    ON [TM1Control].[ImportFileType]([PlanningFileTypeName] ASC) WITH (IGNORE_DUP_KEY = ON);



