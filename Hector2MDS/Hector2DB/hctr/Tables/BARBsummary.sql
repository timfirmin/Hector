CREATE TABLE [hctr].[BARBsummary] (
    [StationCode]                        VARCHAR (150) NULL,
    [ManuallyMatched]                    VARCHAR (1)   NULL,
    [ChannelDescr]                       VARCHAR (150) NULL,
    [WeeklyReach_Max52Weeks]             INT           NULL,
    [WeeklyViewingHours_TotalMax52Weeks] FLOAT (53)    NULL,
    [WeeklyReach]                        INT           NULL,
    [WeeklyViewingHours]                 FLOAT (53)    NULL,
    [TotalWeeklyAudienceHours]           FLOAT (53)    NULL,
    [Group]                              VARCHAR (150) NULL
);

