/*
Deployment script for FinanceStage

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "FinanceStage"
:setvar DefaultFilePrefix "FinanceStage"
:setvar DefaultDataPath "F:\SQLServerDatabases\"
:setvar DefaultLogPath "G:\SQLServerXLogs\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];
GO

PRINT N'Creating [DDIstaging]...';


GO
CREATE SCHEMA [DDIstaging]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [DDItransform]...';


GO
CREATE SCHEMA [DDItransform]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [DDIstaging].[FileLog]...';


GO
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



GO
PRINT N'Creating [DDIstaging].[FileType]...';


GO
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

GO
PRINT N'Creating [DDIstaging].[DistributionMissingMinutes]...';


GO
PRINT N'Creating [DDIstaging].[DistributionMissingMinutes].[IX_DistributionMissingMinutes]...';

CREATE TABLE [DDIstaging].[DistributionMissingMinutes] (
    [DistributionGroupCode] VARCHAR (150) NULL,
    [DistributionCode]      VARCHAR (150) NULL,
    [CompanyCode]           VARCHAR (150) NULL,
    [StationCode]           VARCHAR (150) NULL,
    [StationName]           VARCHAR (150) NULL,
    [MinutesMissingData]    VARCHAR (150) NULL,
    [MinutesCarryForwards]  VARCHAR (150) NULL,
    [MinutesTotal]          VARCHAR (150) NULL,
    [RevenueMissingData]    VARCHAR (150) NULL,
    [RevenueCarryForwards]  VARCHAR (150) NULL,
    [RevenueTotal]          VARCHAR (150) NULL,
    [Comment]               VARCHAR (500) NULL,
    [StagingRowValidFlag]   VARCHAR (1)   CONSTRAINT [DF_DistributionMissingMinutes_StagingRowValidFlag] DEFAULT ('Y') NULL,
    [FileLogKey]            INT           NULL,
    [InsertTimeStamp]       DATETIME2 (2) CONSTRAINT [DF_DistributionMissingMinutes_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]          INT           NULL,
    [InsertBy]              VARCHAR (150) CONSTRAINT [DF_DistributionMissingMinutes_InsertBy] DEFAULT (suser_sname()) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DistributionMissingMinutes]
    ON [DDIstaging].[DistributionMissingMinutes]([DistributionGroupCode] ASC, [CompanyCode] ASC, [DistributionCode] ASC, [StationCode] ASC) WITH (IGNORE_DUP_KEY = ON);


GO
PRINT N'Creating [DDIstaging].[DistributionMusicMinutes].[IX_DistributionMusicMinutes]...';
CREATE TABLE [DDIstaging].[DistributionMusicMinutes] (
    [DistributionGroupCode]       VARCHAR (150) NULL,
    [DistributionCode]            VARCHAR (150) NULL,
    [CompanyCode]                 VARCHAR (150) NULL,
    [StationCode]                 VARCHAR (150) NULL,
    [StationName]                 VARCHAR (150) NULL,
    [SongsProgrammeForecast]      VARCHAR (150) CONSTRAINT [DF_DistributionMusicMinutes_ProgrammeForecast] DEFAULT ((0)) NULL,
    [NonSongNonProgrammeForecast] VARCHAR (150) CONSTRAINT [DF_DistributionMusicMinutes_NonProgrammeForecast] DEFAULT ((0)) NULL,
    [CommercialForecast]          VARCHAR (150) CONSTRAINT [DF_DistributionMusicMinutes_CommercialForecast] DEFAULT ((0)) NULL,
    [TotalInPeriodForecast]       VARCHAR (150) NULL,
    [LateDataForecast]            VARCHAR (150) NULL,
    [TotalForecast]               VARCHAR (150) NULL,
    [HighPeakPercent]             VARCHAR (150) NULL,
    [LowPeakPercent]              VARCHAR (150) NULL,
    [NonPeakPercent]              VARCHAR (150) NULL,
    [Comment]                     VARCHAR (500) NULL,
    [StagingRowValidFlag]         VARCHAR (1)   CONSTRAINT [DF_DistributionMusicMinutes_StagingRowValidFlag] DEFAULT ('Y') NULL,
    [FileLogKey]                  INT           NULL,
    [InsertTimeStamp]             DATETIME2 (2) CONSTRAINT [DF_DistributionMusicMinutes_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]                INT           NULL,
    [InsertBy]                    VARCHAR (150) CONSTRAINT [DF_DistributionMusicMinutes_InsertBy] DEFAULT (suser_sname()) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DistributionMusicMinutes]
    ON [DDIstaging].[DistributionMusicMinutes]([DistributionGroupCode] ASC, [CompanyCode] ASC, [DistributionCode] ASC, [StationCode] ASC) WITH (IGNORE_DUP_KEY = ON);



GO
PRINT N'Creating [DDIstaging].[ErrorLog]...';


GO
CREATE TABLE [DDIstaging].[ErrorLog] (
    [ErrorLogUniqueKey]    INT           IDENTITY (1, 1) NOT NULL,
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



GO
PRINT N'Creating [DDIstaging].[DistributionPublicReception]...';


GO
CREATE TABLE [DDIstaging].[DistributionPublicReception] (
    [DistributionGroupCode] VARCHAR (150) NULL,
    [DistributionCode]      VARCHAR (150) NULL,
    [CompanyCode]           VARCHAR (150) NULL,
    [StationCode]           VARCHAR (150) NULL,
    [StationName]           VARCHAR (150) NULL,
    [Comment]               VARCHAR (500) NULL,
    [TotalPRAllocation]     VARCHAR (150) NULL,
    [StagingRowValidFlag]   VARCHAR (1)   CONSTRAINT [DF_DistributionPublicReception_StagingRowValidFlag] DEFAULT ('Y') NULL,
    [FileLogKey]            INT           NULL,
    [InsertTimeStamp]       DATETIME2 (2) CONSTRAINT [DF_DistributionPublicReception_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]          INT           NULL,
    [InsertBy]              VARCHAR (150) CONSTRAINT [DF_DistributionPublicReception_InsertBy] DEFAULT (suser_sname()) NULL
);


GO
PRINT N'Creating [DDItransform].[vDistributionMusicMinutes]...';
GO

CREATE VIEW [DDItransform].[vDistributionMusicMinutes]
AS

SELECT 
	   CAST(HashBytes('SHA1', ISNULL(dmm.[DistributionGroupCode], 'Unknown') + ISNULL(dmm.[DistributionCode], 'Unknown') + ISNULL(dmm.[CompanyCode], 'Unknown') + ISNULL(dmm.[StationCode], 'Unknown')) AS bigint) as DistributionMusicMinutesKey
	  ,CAST(ISNULL(dmm.[DistributionGroupCode], 'Unknown')				AS varchar(50))	as [DistributionGroupCode]
	  ,CAST(ISNULL(dmm.[DistributionCode], 'Unknown')				AS varchar(50))	as [DistributionCode]
	  ,CAST(ISNULL(dmm.[CompanyCode], 'Unknown')					AS varchar(50))	as [CompanyCode]
	  ,CAST(ISNULL(dmm.[StationCode], 'Unknown')					AS varchar(50))	as [StationCode]
	  ,CAST(ISNULL(dmm.[StationName], 'Unknown')					AS varchar(100))	as [StationName]	
	 -- ,ms.Code as MasterStationId	    
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([SongsProgrammeForecast],' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([SongsProgrammeForecast],' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as [SongsProgrammeForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([NonSongNonProgrammeForecast],' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([NonSongNonProgrammeForecast],' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as		[NonSongNonProgrammeForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([CommercialForecast],' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([CommercialForecast],' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as [CommercialForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([TotalInPeriodForecast],' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([TotalInPeriodForecast],' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as [TotalInPeriodForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([LateDataForecast],' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([LateDataForecast],' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as [LateDataForecast]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace([TotalForecast],' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace([TotalForecast],' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as [TotalForecast]
 	 
		,(CASE WHEN	ISNUMERIC(ltrim(rtrim(replace(replace(replace(HighPeakPercent,' ',''),'-','0'),'�','')))) = 1 
		THEN 
		(CASE WHEN charindex('%',HighPeakPercent,1) > 0 then
		CAST(ltrim(rtrim(replace(replace(replace(HighPeakPercent,' ',''),'-','0'),'�','')))/100 as decimal(12,5))
		ELSE
		CAST(ltrim(rtrim(replace(replace(replace(HighPeakPercent,' ',''),'-','0'),'�',''))) as decimal(12,5))
		END 
		)
		ELSE 0 END) as HighPeakPercent

				,(CASE WHEN	ISNUMERIC(ltrim(rtrim(replace(replace(replace(LowPeakPercent,' ',''),'-','0'),'�','')))) = 1 
		THEN 
		(CASE WHEN charindex('%',LowPeakPercent,1) > 0 then
		CAST(ltrim(rtrim(replace(replace(replace(LowPeakPercent,' ',''),'-','0'),'�','')))/100 as decimal(12,5))
		ELSE
		CAST(ltrim(rtrim(replace(replace(replace(LowPeakPercent,' ',''),'-','0'),'�',''))) as decimal(12,5))
		END 
		)
		ELSE 0 END) as LowPeakPercent	

		,(CASE WHEN	ISNUMERIC(ltrim(rtrim(replace(replace(replace(NonPeakPercent,' ',''),'-','0'),'�','')))) = 1 
		THEN 
		(CASE WHEN charindex('%',NonPeakPercent,1) > 0 then
		CAST(ltrim(rtrim(replace(replace(replace(NonPeakPercent,' ',''),'-','0'),'�','')))/100 as decimal(12,5))
		ELSE
		CAST(ltrim(rtrim(replace(replace(replace(NonPeakPercent,' ',''),'-','0'),'�',''))) as decimal(12,5))
		END 
		)
		ELSE 0 END) as NonPeakPercent
		 
	  ,CAST(ISNULL(dmm.[Comment], '')					AS varchar(255))	as [Comment]
      
	  
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([SongsProgrammeForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as [SongsProgrammeForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([NonSongNonProgrammeForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y'  ELSE 'N'  END) as		[NonSongNonProgrammeForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([CommercialForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y'ELSE 'N'  END) as [CommercialForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalInPeriodForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N'  END) as [TotalInPeriodForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([LateDataForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N'  END) as [LateDataForecastValidYN]
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N'  END) as [TotalForecastValidYN]
	  
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([SongsProgrammeForecast],''),0),' ',''),'-','0'),'�','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([NonSongNonProgrammeForecast],''),0),' ',''),'-','0'),'�','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([CommercialForecast],''),0),' ',''),'-','0'),'�','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalInPeriodForecast],''),0),' ',''),'-','0'),'�','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([LateDataForecast],''),0),' ',''),'-','0'),'�','')))) = 1 
		AND ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif([TotalForecast],''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N'  END) as [StagingRowValidFlag]

      ,dmm.[FileLogKey]
	  --,CONVERT(datetime2, ISNULL(el2.adddate, '31/12/2999'), 103)						AS [xxxDate]	
      ,dmm.[InsertTimeStamp]
      ,dmm.[InsertLoadId]
      ,dmm.[InsertBy]
  FROM [DDIstaging].[DistributionMusicMinutes] dmm

GO
PRINT N'Creating [DDItransform].[vDistributionMissingMinutes]...';


GO

 
CREATE VIEW [DDItransform].[vDistributionMissingMinutes]
AS	

SELECT 
	   CAST(HashBytes('SHA1', ISNULL(dmm.[DistributionGroupCode], 'Unknown') + ISNULL(dmm.[DistributionCode], 'Unknown') + ISNULL(dmm.[CompanyCode], 'Unknown') + ISNULL(dmm.[StationCode], 'Unknown')) AS bigint) as DistributionMissingMinutesKey
	  ,CAST(ISNULL(dmm.[DistributionGroupCode], 'Unknown')				AS varchar(50))	as [DistributionGroupCode]
	  ,CAST(ISNULL(dmm.[DistributionCode], 'Unknown')				AS varchar(50))	as [DistributionCode]
	  ,CAST(ISNULL(dmm.[CompanyCode], 'Unknown')					AS varchar(50))	as [CompanyCode]
	  ,CAST(ISNULL(dmm.[StationCode], 'Unknown')					AS varchar(50))	as [StationCode]
	  ,CAST(ISNULL(dmm.[StationName], 'Unknown')					AS varchar(100))	as [StationName]	 
	--  ,ms.Code as MasterStationId
	  
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(MinutesMissingData,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(MinutesMissingData,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as MinutesMissingData
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(MinutesCarryForwards,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(MinutesCarryForwards,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as MinutesCarryForwards
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(MinutesTotal,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(MinutesTotal,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as MinutesTotal
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(RevenueMissingData,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(RevenueMissingData,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as RevenueMissingData
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(RevenueCarryForwards,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(RevenueCarryForwards,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as RevenueCarryForwards
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(RevenueTotal,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(RevenueTotal,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as RevenueTotal
 
 	  ,CAST(ISNULL(dmm.[Comment], '')					AS varchar(255))	as [Comment]


	  	,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesMissingData,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as MinutesMissingDataValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesCarryForwards,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as MinutesCarryForwardsValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesTotal,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as MinutesTotalValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueMissingData,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as RevenueMissingDataValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueCarryForwards,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as RevenueCarryForwardsValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueTotal,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as RevenueTotalValidYN

	  	,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesMissingData,''),0),' ',''),'-','0'),'�','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesCarryForwards,''),0),' ',''),'-','0'),'�','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesTotal,''),0),' ',''),'-','0'),'�','')))) = 1 
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueMissingData,''),0),' ',''),'-','0'),'�','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueCarryForwards,''),0),' ',''),'-','0'),'�','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueTotal,''),0),' ',''),'-','0'),'�','')))) = 1 
		THEN 'Y' ELSE 'N' END) 	As [StagingRowValidFlag]
      ,dmm.[FileLogKey]
	  --,CONVERT(datetime2, ISNULL(el2.adddate, '31/12/2999'), 103)	AS [xxxDate]	
      ,dmm.[InsertTimeStamp]
      ,dmm.[InsertLoadId]
      ,dmm.[InsertBy]												
  FROM [DDIstaging].[DistributionMissingMinutes] dmm

GO
PRINT N'Creating [DDItransform].[vDistributionPublicReception]...';


GO

CREATE VIEW [DDItransform].[vDistributionPublicReception]
AS	
--granularity now at [CustomerCode]
SELECT 
	   CAST(HashBytes('SHA1', ISNULL(dpr.[DistributionGroupCode], 'Unknown') + ISNULL(dpr.[DistributionCode], 'Unknown') + ISNULL(dpr.[CompanyCode], 'Unknown') + ISNULL(dpr.[StationCode], 'Unknown')) AS bigint) as DistributionPublicReceptionKey
	  ,CAST(ISNULL(dpr.[DistributionGroupCode], 'Unknown')				AS varchar(50))	as [DistributionGroupCode]
	  ,CAST(ISNULL(dpr.[DistributionCode], 'Unknown')				AS varchar(50))	as [DistributionCode]
	  ,CAST(ISNULL(dpr.[CompanyCode], 'Unknown')					AS varchar(50))	as [CompanyCode]
	  ,CAST(ISNULL(dpr.[StationCode], 'Unknown')					AS varchar(50))	as [StationCode]
	  ,CAST(ISNULL(dpr.[StationName], 'Unknown')					AS varchar(100))	as [StationName]	 		  
	--,ms.Code as MasterStationId
	   
 
 		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(TotalPRAllocation,' ',''),'-','0'),'�','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(TotalPRAllocation,' ',''),'-','0'),'�',''))) as decimal(18,3)) ELSE 0 END) as TotalPRAllocation
 	  ,CAST(ISNULL(dpr.[Comment], '')					AS varchar(255))	as [Comment]
 
  		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(TotalPRAllocation,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as TotalPRAllocationValidYN


      ,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(TotalPRAllocation,''),0),' ',''),'-','0'),'�','')))) = 1 THEN 'Y' ELSE 'N' END) as [StagingRowValidFlag]
      ,dpr.[FileLogKey]
	  --,CONVERT(datetime2, ISNULL(el2.adddate, '31/12/2999'), 103)						AS [xxxDate]	
      ,dpr.[InsertTimeStamp]
      ,dpr.[InsertLoadId]
      ,dpr.[InsertBy]
  FROM [DDIstaging].[DistributionPublicReception] dpr

GO
PRINT N'Creating [DDIstaging].[NotificationLog]...';
GO

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


GO
PRINT N'Creating [DDItransform].[vNotificationLogFull]...';
GO

CREATE VIEW [DDItransform].[vNotificationLogFull]
AS
SELECT 
		nl.[NotificationUniqueKey]
		,nl.NotificationFileLogKey
		,fl.DerivedFileType
		,fl.FileName
		,fl.FileSourcePath
		,fl.DerivedDistributionCode
		,fl.DerivedCompany
		,fl.DerivedDistributionGroupCode
		,nl.[NotificationPackageName]
		,nl.[NotificationTaskName]
		,nl.[NotificationFieldName]
		,nl.[NotificationFieldCode]
		,nl.[NotificationFieldDescription]
		,nl.[InsertTimeStamp]
		,nl.[InsertBy]
		,fl.LoadId
  FROM [DDIstaging].[NotificationLog] nl
  JOIN [DDIstaging].[FileLog] fl on nl.[NotificationFileLogKey]  = fl.FileLogUniqueKey

GO
PRINT N'Update complete.';
