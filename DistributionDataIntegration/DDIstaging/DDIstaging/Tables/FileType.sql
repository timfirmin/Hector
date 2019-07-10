CREATE TABLE [DDIstaging].[FileType] (
    [FileTypeUniqueKey]            INT           IDENTITY (1, 1) NOT NULL,
    [FileTypeName]                 VARCHAR (50)  NOT NULL,
    [FileTypeDescription]          VARCHAR (250) NOT NULL,
    [FileTypeNameMask]             VARCHAR (250) NOT NULL,
    [FileTypeImportFolderName]     VARCHAR (50)  NULL,
    [FileTypeFailedFolderName]     VARCHAR (50)  NULL,
    [FileTypeProcessedFolderName]  VARCHAR (50)  NULL,
    [FileTypeQuarantineFolderName] VARCHAR (50)  NULL,
    [FileTypeArchiveFolderName]    VARCHAR (50)  NULL,
    [FileTypeStagingTable]         VARCHAR (50)  NULL,
    [FileTypeFormat]               VARCHAR (50)  CONSTRAINT [DF_DDAFileType_DDAFileTypeFormat] DEFAULT ('CSV') NULL,
    [FileTypeDelimiter]            VARCHAR (50)  CONSTRAINT [DF_DDAFileType_DDAFileTypeDelimiter] DEFAULT (',') NULL,
    [FileTypeValueCheckColumn]     VARCHAR (50)  NULL,
    [FileTypeProcessFlag]          VARCHAR (1)   CONSTRAINT [DF_DDAFileType_DDAFileTypeValidFlag1] DEFAULT ('Y') NULL,
    [FileTypeRetentionDays]        INT           CONSTRAINT [DF_ImportFileType_RevenueFileRetentionDays] DEFAULT ((30)) NULL,
    [InsertTimeStamp]              DATETIME2 (2) CONSTRAINT [DF_DDAFileType_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    [InsertLoadId]                 INT           CONSTRAINT [DF_ImportFileType_InsertLoadId] DEFAULT ((99999)) NULL,
    [InsertedBy]                   VARCHAR (50)  CONSTRAINT [DF_FileType_InsertedBy] DEFAULT (suser_sname()) NULL
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_FileType]
    ON [DDIstaging].[FileType]([FileTypeName] ASC) WITH (IGNORE_DUP_KEY = ON);

