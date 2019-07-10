CREATE TABLE [FPV].[MasterMusicMinutes] (
    [StationID]                  VARCHAR (20)                                NOT NULL,
    [ProgrammeForecast]          DECIMAL (18, 3)                             NULL,
    [NonProgrammeForecast]       DECIMAL (18, 3)                             NULL,
    [CommercialForecast]         DECIMAL (18, 3)                             NULL,
    [TotalInPeriodForecast]      DECIMAL (18, 3)                             NULL,
    [LateDataForecast]           DECIMAL (18, 3)                             NULL,
    [TotalForecast]              DECIMAL (18, 3)                             NULL,
    [UpdatedBy]                  VARCHAR (100)                               NULL,
    [UpdateComment]              VARCHAR (255)                               NULL,
    [SysStartTime]               DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_MasterMusicMinutes_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                 DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_MasterMusicMinutes_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [DistributionGroupCode]      VARCHAR (50)                                CONSTRAINT [MM_DistributionGroupCode] DEFAULT ('Unknown') NOT NULL,
    [DistributionCode]           VARCHAR (50)                                CONSTRAINT [MM_DistributionCode] DEFAULT ('Unknown') NOT NULL,
    [Society]                    VARCHAR (50)                                CONSTRAINT [MM_Society] DEFAULT ('Unknown') NOT NULL,
    [HighPeakPercent]            DECIMAL (12, 5)                             CONSTRAINT [MMM_HighPeakPercent] DEFAULT ((0)) NULL,
    [LowPeakPercent]             DECIMAL (12, 5)                             CONSTRAINT [MMM_LowPeakPercent] DEFAULT ((0)) NULL,
    [NonPeakPercent]             DECIMAL (12, 5)                             CONSTRAINT [MMM_OffPeakPercent] DEFAULT ((0)) NULL,
    [CalculationGroupStationKey] AS                                          (CONVERT([bigint],hashbytes('SHA1',(([DistributionGroupCode]+[DistributionCode])+[Society])+[StationID]))),
    CONSTRAINT [PK_MasterMusicMinutes] PRIMARY KEY CLUSTERED ([StationID] ASC, [DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[MasterMusicMinutesHistory], DATA_CONSISTENCY_CHECK=ON));
GO

CREATE NONCLUSTERED INDEX [_dta_index_MasterMusicMinutes_25_1417772108__K1_K20_K21_K22_23]
    ON [FPV].[MasterMusicMinutes]([StationID] ASC, [DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC)
    INCLUDE([HighPeakPercent]);
GO

CREATE NONCLUSTERED INDEX [_dta_index_MasterMusicMinutes_25_1417772108__K1_K20_K21_K22_23_24_26]
    ON [FPV].[MasterMusicMinutes]([StationID] ASC, [DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC)
    INCLUDE([HighPeakPercent], [LowPeakPercent], [NonPeakPercent]);
GO

CREATE NONCLUSTERED INDEX [_dta_index_MasterMusicMinutes_25_1417772108__K1_K20_K21_K22_24]
    ON [FPV].[MasterMusicMinutes]([StationID] ASC, [DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC)
    INCLUDE([LowPeakPercent]);
GO

CREATE NONCLUSTERED INDEX [_dta_index_MasterMusicMinutes_25_1417772108__K20_K22_K21_K1_23_24_26]
    ON [FPV].[MasterMusicMinutes]([DistributionGroupCode] ASC, [Society] ASC, [DistributionCode] ASC, [StationID] ASC)
    INCLUDE([HighPeakPercent], [LowPeakPercent], [NonPeakPercent]);
GO


GO
CREATE NONCLUSTERED INDEX [IX_MasterMusicMinutes]
    ON [FPV].[MasterMusicMinutes]([CalculationGroupStationKey] ASC);

