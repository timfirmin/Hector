CREATE TABLE [FPV].[CalculationGroupMusicMinutes] (
    [DistributionGroupCode] VARCHAR (20)                                NOT NULL,
    [DistributionCode]      VARCHAR (20)                                NOT NULL,
    [Society]               VARCHAR (20)                                NOT NULL,
    [StationID]             VARCHAR (20)                                NOT NULL,
    [Category]              VARCHAR (150)                               NULL,
    [Threshold]             VARCHAR (50)                                NULL,
    [Finalised]             VARCHAR (50)                                NULL,
    [MusicMinutesCategory]  VARCHAR (50)                                NULL,
    [ProgrammeForecast]     DECIMAL (18, 3)                             NULL,
    [NonProgrammeForecast]  DECIMAL (18, 3)                             NULL,
    [CommercialForecast]    DECIMAL (18, 3)                             NULL,
    [TotalInPeriodForecast] DECIMAL (18, 3)                             NULL,
    [LateDataForecast]      DECIMAL (18, 3)                             NULL,
    [TotalForecast]         DECIMAL (18, 3)                             NULL,
    [HighPeakPercent]       DECIMAL (12, 5)                             NULL,
    [LowPeakPercent]        DECIMAL (12, 5)                             NULL,
    [NonPeakPercent]        DECIMAL (12, 5)                             NULL,
    [UpdatedBy]             VARCHAR (100)                               NULL,
    [UpdateComment]         VARCHAR (255)                               NULL,
    [SysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroupMusicMinutes_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_CalculationGroupMusicMinutes_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupMusicMinutesHistory], DATA_CONSISTENCY_CHECK=ON));













