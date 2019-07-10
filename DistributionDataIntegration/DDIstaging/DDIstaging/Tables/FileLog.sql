CREATE TABLE [DDIstaging].[FileLog] (
    [FileLogUniqueKey]             INT           IDENTITY (1, 1) NOT NULL,
    [FileRawRowCount]              INT           NOT NULL,
    [FileCreatedTimeStamp]         VARCHAR (255) NOT NULL,
    [FileModifiedTimeStamp]        VARCHAR (255) NOT NULL,
    [FileProcessPath]              VARCHAR (255) NOT NULL,
    [FileSourcePath]               VARCHAR (255) NULL,
    [FileName]                     VARCHAR (255) NOT NULL,
    [FileTypeKey]                  INT           NULL,
    [FileNameBatchCount]           INT           NULL,
    [TotalFilesInBatch]            INT           CONSTRAINT [DF_FileLog_TotalFilesInBatch] DEFAULT ((0)) NULL,
    [FileValidFlag]                VARCHAR (1)   CONSTRAINT [DF_FileLog_FileValidFlag] DEFAULT ('N') NULL,
    [FileValidationComment]        VARCHAR (255) NULL,
    [DerivedFileType]              VARCHAR (255) NULL,
    [DerivedDistributionCode]      AS            (case when charindex([FileValidationComment],'Invalid File Name Format',(1))>(0) then '' else left([FileName],(4)) end),
    [DerivedCompany]               AS            (case when charindex([FileValidationComment],'Invalid File Name Format',(1))>(0) then '' else replace(substring([FileName],(6),(4)),'_','') end),
    [DerivedDistributionGroupCode] AS            (case when charindex([FileValidationComment],'Invalid File Name Format',(1))>(0) then '' else replace(substring(replace([FileName],'MCPS','MCP'),(9),(4)),'_','') end),
    [FileSize]                     VARCHAR (255) NULL,
    [SourceFileID]                 VARCHAR (50)  CONSTRAINT [DF_ImportFileLog_SourceFileID] DEFAULT ((0)) NULL,
    [SourceFileInsertTimeStamp]    DATETIME2 (2) NULL,
    [StagingTimeStamp]             DATETIME2 (2) NULL,
    [StagingTotalRows]             INT           NULL,
    [StagingValidValue]            FLOAT (53)    NULL,
    [StagingValidStatus]           AS            (case when [StagingTotalRows]>(0) AND [StagingTotalRows]=[FileRawRowCount] AND [FileValidFlag]='Y' then 'Y' else 'N' end),
    [TransformTimeStamp]           DATETIME2 (2) NULL,
    [TransformTotalRows]           INT           NULL,
    [TransformValidValue]          FLOAT (53)    NULL,
    [TransformValidStatus]         AS            (case when [StagingTotalRows]=[FileRawRowCount] AND [StagingValidValue]=[TransformValidValue] AND [FileValidFlag]='Y' then 'Y' else 'N' end),
    [FileMovedAtSourceFlag]        VARCHAR (1)   CONSTRAINT [DF_FileLog_FileMovedAtSourceFlag] DEFAULT ('N') NULL,
    [FileMovedActionTaken]         VARCHAR (255) NULL,
    [FileMovedTimeStamp]           DATETIME2 (2) NULL,
    [FileMovedDestinationFolder]   VARCHAR (255) NULL,
    [FileDeletedLoadId]            INT           NULL,
    [FileDeletedTimeStamp]         DATETIME2 (2) NULL,
    [LoadId]                       INT           NULL,
    [LoadTimeStamp]                DATETIME2 (2) CONSTRAINT [DF_RevenueFilesLog_LoadTimeStamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ImportFileLog] PRIMARY KEY CLUSTERED ([FileLogUniqueKey] ASC)
);







