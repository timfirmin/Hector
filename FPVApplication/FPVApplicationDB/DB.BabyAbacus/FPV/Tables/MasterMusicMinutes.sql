CREATE TABLE [FPV].[MasterMusicMinutes] (
    [StationID]             VARCHAR (20)                                NOT NULL,
    [ProgrammeForecast]     DECIMAL (18, 3)                             NULL,
    [NonProgrammeForecast]  DECIMAL (18, 3)                             NULL,
    [CommercialForecast]    DECIMAL (18, 3)                             NULL,
    [TotalInPeriodForecast] DECIMAL (18, 3)                             NULL,
    [LateDataForecast]      DECIMAL (18, 3)                             NULL,
    [TotalForecast]         DECIMAL (18, 3)                             NULL,
    [UpdatedBy]             VARCHAR (100)                               NULL,
    [UpdateComment]         VARCHAR (255)                               NULL,
    [SysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
    [SysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   NOT NULL,
    [DistributionGroupCode] VARCHAR (50)                                NOT NULL,
    [DistributionCode]      VARCHAR (50)                                NOT NULL,
    [Society]               VARCHAR (50)                                NOT NULL,
    [HighPeakPercent]       DECIMAL (12, 5)                             CONSTRAINT [MMM_HighPeakPercent] DEFAULT ((0)) NULL,
    [LowPeakPercent]        DECIMAL (12, 5)                             CONSTRAINT [MMM_LowPeakPercent] DEFAULT ((0)) NULL,
    [NonPeakPercent]        DECIMAL (12, 5)                             CONSTRAINT [MMM_NonPeakPercent] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MasterMusicMinutes] PRIMARY KEY CLUSTERED ([StationID] ASC, [DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[MasterMusicMinutesHistory], DATA_CONSISTENCY_CHECK=ON));

