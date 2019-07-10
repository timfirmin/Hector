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

