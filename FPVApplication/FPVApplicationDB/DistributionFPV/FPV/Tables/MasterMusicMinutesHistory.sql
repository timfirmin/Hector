CREATE TABLE [FPV].[MasterMusicMinutesHistory] (
    [StationID]                  VARCHAR (20)    NOT NULL,
    [ProgrammeForecast]          DECIMAL (18, 3) NULL,
    [NonProgrammeForecast]       DECIMAL (18, 3) NULL,
    [CommercialForecast]         DECIMAL (18, 3) NULL,
    [TotalInPeriodForecast]      DECIMAL (18, 3) NULL,
    [LateDataForecast]           DECIMAL (18, 3) NULL,
    [TotalForecast]              DECIMAL (18, 3) NULL,
    [UpdatedBy]                  VARCHAR (100)   NULL,
    [UpdateComment]              VARCHAR (255)   NULL,
    [SysStartTime]               DATETIME2 (7)   NOT NULL,
    [SysEndTime]                 DATETIME2 (7)   NOT NULL,
    [DistributionGroupCode]      VARCHAR (50)    NOT NULL,
    [DistributionCode]           VARCHAR (50)    NOT NULL,
    [Society]                    VARCHAR (50)    NOT NULL,
    [HighPeakPercent]            DECIMAL (12, 5) CONSTRAINT [MMMh_HighPeakPercent] DEFAULT ((0)) NULL,
    [LowPeakPercent]             DECIMAL (12, 5) CONSTRAINT [MMMh_LowPeakPercent] DEFAULT ((0)) NULL,
    [NonPeakPercent]             DECIMAL (12, 5) CONSTRAINT [MMMh_NonPeakPercent] DEFAULT ((0)) NULL,
    [CalculationGroupStationKey] BIGINT          CONSTRAINT [MuM_CalculationGroupStationKey] DEFAULT ((-1)) NULL
);
GO

CREATE CLUSTERED INDEX [ix_MasterMusicMinutesHistory]
    ON [FPV].[MasterMusicMinutesHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

