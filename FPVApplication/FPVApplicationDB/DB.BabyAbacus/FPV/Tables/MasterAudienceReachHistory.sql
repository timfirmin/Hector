CREATE TABLE [FPV].[MasterAudienceReachHistory] (
    [DistributionGroupCode]          VARCHAR (20)    NOT NULL,
    [DistributionCode]               VARCHAR (20)    NOT NULL,
    [Society]                        VARCHAR (20)    NOT NULL,
    [StationID]                      VARCHAR (20)    NOT NULL,
    [WeeklyViewingHoursTotal52Weeks] DECIMAL (18, 3) NULL,
    [WeeklyReach]                    DECIMAL (18, 3) NULL,
    [WeeklyViewingHours]             DECIMAL (18, 3) NULL,
    [TotalWeeklyAudienceHours]       DECIMAL (18, 3) NULL,
    [PopulationAverage]              DECIMAL (12, 3) NULL,
    [Reach1000sAverage]              DECIMAL (12, 3) NULL,
    [HoursPerListenerAverage]        DECIMAL (12, 3) NULL,
    [HoursPerHeadAverage]            DECIMAL (12, 3) NULL,
    [TotalHours1000sAverage]         DECIMAL (12, 3) NULL,
    [UpdatedBy]                      VARCHAR (100)   NOT NULL,
    [UpdateComment]                  VARCHAR (255)   NULL,
    [SysStartTime]                   DATETIME2 (7)   NOT NULL,
    [SysEndTime]                     DATETIME2 (7)   NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_AudienceReachHistory]
    ON [FPV].[MasterAudienceReachHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

