CREATE TABLE [staging].[AudienceReachRAJAR] (
    [StationGroup]    NVARCHAR (250)  NOT NULL,
    [StationId]       NVARCHAR (200)  NULL,
    [YearQuarter]     VARCHAR (7)     NOT NULL,
    [SurveyPeriod]    NVARCHAR (3)    NOT NULL,
    [Population000s]  NUMERIC (18, 6) NULL,
    [Reach000s]       NUMERIC (18, 6) NULL,
    [TotalHours000s]  NUMERIC (18, 6) NULL,
    [InsertTimeStamp] DATETIME        CONSTRAINT [DF_AudienceReachRAJAR_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    [InsertLoadId]    INT             NOT NULL
);



