CREATE TABLE [staging].[AudienceReachBARB] (
    [StationId]                NVARCHAR (200)  NULL,
    [DateKey]                  INT             NULL,
    [WeeklyReach]              NUMERIC (18, 3) NULL,
    [WeeklyViewingHours]       NUMERIC (33, 7) NULL,
    [TotalWeeklyAudienceHours] NUMERIC (38, 6) NULL,
    [InsertTimeStamp]          DATETIME        CONSTRAINT [DF_AudienceReachBARB_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    [InsertLoadId]             INT             NOT NULL
);



