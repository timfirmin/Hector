CREATE TABLE [TM1Control].[ImportFileLog] (
    [FileLogUniqueKey]           INT           IDENTITY (1, 1) NOT NULL,
    [FileRawRowCount]            INT           NOT NULL,
    [FileCreatedTimeStamp]       VARCHAR (255) NOT NULL,
    [FileModifiedTimeStamp]      VARCHAR (255) NOT NULL,
    [FilePath]                   VARCHAR (255) NOT NULL,
    [FileName]                   VARCHAR (255) NOT NULL,
    [FileSource]                 VARCHAR (255) CONSTRAINT [DF_RevenueFilesLog_FileSource] DEFAULT ('TM1Prod') NOT NULL,
    [FileStartPeriodString]      AS            (replace(replace(ltrim(substring(replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),(1))+(2),(7))),'t',''),'_','')),
    [FileEndPeriodString]        AS            (replace(replace(replace(ltrim(substring(replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),(1))+(5))+(2),(8))),'T',''),'_',''),'M','')),
    [FileStartPeriodSeq]         AS            (CONVERT([int],right(replace(replace(ltrim(substring(replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),(1))+(2),(7))),'t',''),'_',''),(4)))*(12)+CONVERT([int],replace(left(replace(replace(ltrim(substring(replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),(1))+(2),(7))),'t',''),'_',''),(2)),'-',''))),
    [FileEndPeriodSeq]           AS            (CONVERT([int],right(rtrim(replace(replace(replace(ltrim(substring(replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),(1))+(5))+(2),(8))),'T',''),'_',''),'M','')),(4)))*(12)+CONVERT([int],replace(left(replace(replace(replace(ltrim(substring(replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),charindex('Pd',replace([FileName],' ',''),(1))+(5))+(2),(8))),'T',''),'_',''),'M',''),(2)),'-',''))),
    [FileTypeKey]                INT           NULL,
    [DerivedFileType]            AS            (case left([FileName],(2)) when '01' then 'Costs' when '02' then 'Revenue' else 'Unknown' end),
    [FileSize]                   VARCHAR (255) NULL,
    [SourceFileID]               VARCHAR (50)  CONSTRAINT [DF_ImportFileLog_SourceFileID] DEFAULT ((0)) NULL,
    [SourceFileInsertTimeStamp]  DATETIME2 (2) NULL,
    [StagingValidToLoadFlag]     VARCHAR (1)   CONSTRAINT [DF_ImportFileLog_StagingValidToLoadFlag] DEFAULT ('N') NOT NULL,
    [StagingStartPeriodSeq]      INT           NULL,
    [StagingEndPeriodSeq]        INT           NULL,
    [StagingTotalRows]           INT           NULL,
    [StagingValidValue]          FLOAT (53)    NULL,
    [StagingValidStatus]         AS            (case when [StagingTotalRows]>(0) AND [StagingTotalRows]=[FileRawRowCount] then 'Y' else 'N' end),
    [StagingTimeStamp]           DATETIME2 (2) NULL,
    [TransformTimeStamp]         DATETIME2 (2) NULL,
    [TransformValidValue]        FLOAT (53)    NULL,
    [TransformValidRows]         INT           NULL,
    [TransformValidStatus]       AS            (case when [TransformValidRows]=[StagingTotalRows] AND CONVERT([bigint],[StagingValidValue])=CONVERT([bigint],[TransformValidValue]) then 'Y' else case when [TransformTimeStamp] IS NULL AND [StagingValidToLoadFlag]='Y' then 'X' else 'N' end end),
    [ExtractFDMTimeStamp]        DATETIME2 (2) NULL,
    [ExtractFDMValue]            FLOAT (53)    NULL,
    [ExtractFDMRows]             INT           NULL,
    [ExtractFPVTimeStamp]        DATETIME2 (2) NULL,
    [ExtractFPVValue]            FLOAT (53)    NULL,
    [ExtractFPVRows]             INT           NULL,
    [ExtractValidStatus]         AS            (case when [TransformValidRows]=[StagingTotalRows] AND CONVERT([bigint],[StagingValidValue])=CONVERT([bigint],[TransformValidValue]) AND [ExtractFDMRows]>(100) then 'Y' else case when [TransformTimeStamp] IS NULL AND [StagingValidToLoadFlag]='Y' then 'X' else 'N' end end),
    [FileMovedAtSourceFlag]      VARCHAR (1)   NULL,
    [FileMovedActionTaken]       VARCHAR (255) NULL,
    [FileMovedTimeStamp]         DATETIME2 (2) NULL,
    [FileMovedDestinationFolder] VARCHAR (255) NULL,
    [FileDeletedLoadId]          INT           NULL,
    [FileDeletedTimeStamp]       DATETIME2 (2) NULL,
    [LoadId]                     INT           NULL,
    [LoadTimeStamp]              DATETIME2 (2) CONSTRAINT [DF_RevenueFilesLog_LoadTimeStamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ImportFileLog] PRIMARY KEY CLUSTERED ([FileLogUniqueKey] ASC)
);












GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ImportFileLog]
    ON [TM1Control].[ImportFileLog]([FileName] ASC, [LoadId] ASC) WITH (IGNORE_DUP_KEY = ON);



