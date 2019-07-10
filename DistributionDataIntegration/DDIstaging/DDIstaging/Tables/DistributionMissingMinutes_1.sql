CREATE TABLE [DDIstaging].[DistributionMissingMinutes] (
    [DistributionGroupCode] VARCHAR (150) NULL,
    [DistributionCode]      VARCHAR (150) NULL,
    [CompanyCode]           VARCHAR (150) NULL,
    [StationCode]           VARCHAR (150) NULL,
    [StationName]           VARCHAR (150) NULL,
    [MinutesMissingData]    VARCHAR (150) NULL,
    [MinutesCarryForwards]  VARCHAR (150) NULL,
    [MinutesTotal]          VARCHAR (150) NULL,
    [RevenueMissingData]    VARCHAR (150) NULL,
    [RevenueCarryForwards]  VARCHAR (150) NULL,
    [RevenueTotal]          VARCHAR (150) NULL,
    [Comment]               VARCHAR (500) NULL,
    [StagingRowValidFlag]   VARCHAR (1)   CONSTRAINT [DF_DistributionMissingMinutes_StagingRowValidFlag] DEFAULT ('Y') NULL,
    [FileLogKey]            INT           NULL,
    [InsertTimeStamp]       DATETIME2 (2) CONSTRAINT [DF_DistributionMissingMinutes_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]          INT           NULL,
    [InsertBy]              VARCHAR (150) CONSTRAINT [DF_DistributionMissingMinutes_InsertBy] DEFAULT (suser_sname()) NULL
);








GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DistributionMissingMinutes]
    ON [DDIstaging].[DistributionMissingMinutes]([DistributionGroupCode] ASC, [CompanyCode] ASC, [DistributionCode] ASC, [StationCode] ASC) WITH (IGNORE_DUP_KEY = ON);

