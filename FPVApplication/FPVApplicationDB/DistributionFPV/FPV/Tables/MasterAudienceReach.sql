CREATE TABLE [FPV].[MasterAudienceReach] (
    [DistributionGroupCode]          VARCHAR (20)                                NOT NULL,
    [DistributionCode]               VARCHAR (20)                                NOT NULL,
    [Society]                        VARCHAR (20)                                NOT NULL,
    [StationID]                      VARCHAR (20)                                NOT NULL,
    [WeeklyReachTotal52Weeks]        DECIMAL (18, 3)                             NULL,
    [WeeklyViewingHoursTotal52Weeks] DECIMAL (18, 3)                             NULL,
    [WeeklyReach]                    DECIMAL (18, 3)                             NULL,
    [WeeklyViewingHours]             DECIMAL (18, 3)                             NULL,
    [TotalWeeklyAudienceHours]       DECIMAL (18, 3)                             NULL,
    [PopulationAverage]              DECIMAL (12, 3)                             NULL,
    [HoursPerListenerAverage]        DECIMAL (12, 3)                             NULL,
    [HoursPerHeadAverage]            DECIMAL (12, 3)                             NULL,
    [UpdatedBy]                      VARCHAR (100)                               NOT NULL,
    [UpdateComment]                  VARCHAR (255)                               NULL,
    [SysStartTime]                   DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_AudienceReach_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                     DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_AudienceReach_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [AudienceAverage]                DECIMAL (18, 3)                             CONSTRAINT [MAR_AudienceAverage] DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[MasterAudienceReachHistory], DATA_CONSISTENCY_CHECK=ON));





