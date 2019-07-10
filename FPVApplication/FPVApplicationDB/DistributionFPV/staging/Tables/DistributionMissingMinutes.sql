CREATE TABLE [staging].[DistributionMissingMinutes] (
    [DistributionGroupCode] VARCHAR (50)    NULL,
    [DistributionCode]      VARCHAR (50)    NULL,
    [Society]               VARCHAR (50)    NULL,
    [StationId]             VARCHAR (50)    NULL,
    [MasterStationId]       VARCHAR (50)    NULL,
    [MinutesMissingData]    DECIMAL (18, 3) NULL,
    [MinutesCarryForwards]  DECIMAL (18, 3) NULL,
    [MinutesTotal]          DECIMAL (18, 3) NULL,
    [RevenueMissingData]    DECIMAL (18, 3) NULL,
    [RevenueCarryForwards]  DECIMAL (18, 3) NULL,
    [RevenueTotal]          DECIMAL (18, 3) NULL,
    [Comment]               VARCHAR (255)   NULL,
    [InsertTimeStamp]       DATETIME2 (2)   CONSTRAINT [DF_DistributionMissingMinutes_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]          INT             NULL
);





