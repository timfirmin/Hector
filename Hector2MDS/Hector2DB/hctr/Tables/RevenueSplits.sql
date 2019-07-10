CREATE TABLE [hctr].[RevenueSplits] (
    [RevenueSplitKey]  INT          NULL,
    [DistributionCode] VARCHAR (50) NULL,
    [EL2CustomerCode]  VARCHAR (50) NULL,
    [PeriodFrom]       VARCHAR (50) NULL,
    [PeriodTo]         VARCHAR (50) NULL,
    [Group]            VARCHAR (50) NULL,
    [CodaAccount]      VARCHAR (50) NULL,
    [StationCode]      VARCHAR (50) NULL,
    [Channel]          VARCHAR (50) NULL,
    [PercentageSplits] VARCHAR (50) NULL,
    [GrossRevenue]     VARCHAR (50) NULL,
    [InsertLoadId]     INT          NULL,
    [InsertTimeStamp]  DATETIME     NULL
);

