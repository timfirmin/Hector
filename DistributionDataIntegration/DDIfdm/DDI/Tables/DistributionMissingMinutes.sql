CREATE TABLE [DDI].[DistributionMissingMinutes] (
    [DistributionMissingMinutesKey] BIGINT          NULL,
    [DistributionGroupCode]         VARCHAR (50)    NULL,
    [DistributionCode]              VARCHAR (50)    NULL,
    [CompanyCode]                   VARCHAR (50)    NULL,
    [StationCode]                   VARCHAR (50)    NULL,
    [StationName]                   VARCHAR (100)   NULL,
    [MasterStationId]               VARCHAR (50)    NULL,
    [MinutesMissingData]            DECIMAL (18, 3) NULL,
    [MinutesCarryForwards]          DECIMAL (18, 3) NULL,
    [MinutesTotal]                  DECIMAL (18, 3) NULL,
    [RevenueMissingData]            DECIMAL (18, 3) NULL,
    [RevenueCarryForwards]          DECIMAL (18, 3) NULL,
    [RevenueTotal]                  DECIMAL (18, 3) NULL,
    [Comment]                       VARCHAR (255)   NULL,
    [FileLogKey]                    INT             NULL,
    [InsertTimeStamp]               DATETIME2 (2)   CONSTRAINT [DF_DistributionMissingMinutes_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]                  INT             NULL,
    [InsertBy]                      VARCHAR (150)   CONSTRAINT [DF_DistributionMissingMinutes_InsertBy] DEFAULT (suser_sname()) NULL
);








GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DistributionMissingMinutes]
    ON [DDI].[DistributionMissingMinutes]([DistributionMissingMinutesKey] ASC) WITH (IGNORE_DUP_KEY = ON);



