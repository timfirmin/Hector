CREATE TABLE [HctrStaging].[BaseRevenueTM1] (
    [TM1BaseRevenueKey]          INT           IDENTITY (1, 1) NOT NULL,
    [CompanyCode]                VARCHAR (50)  NULL,
    [AccountCodeEL1]             VARCHAR (150) NULL,
    [AccountCodeEL2]             VARCHAR (150) NULL,
    [AccountCompanyCodeEL1]      VARCHAR (50)  NULL,
    [AccountCompanyCodeEL2]      VARCHAR (50)  NULL,
    [PlanningScenario]           VARCHAR (50)  NULL,
    [PlanningPeriod]             VARCHAR (50)  NULL,
    [PlanningYear]               VARCHAR (50)  NULL,
    [PlanningFilePeriodSeq]      INT           NULL,
    [PlanningPeriodFirstDay]     DATETIME2 (2) NULL,
    [TM1CategoryOnlineBroadcast] VARCHAR (150) NULL,
    [TM1BroadcastGroup]          VARCHAR (150) NULL,
    [ValueGBP]                   MONEY         NULL,
    [TM1PlanningFileLogKey]      INT           NULL,
    [InsertLoadId]               INT           NULL,
    [InsertTimeStamp]            DATETIME      CONSTRAINT [DF_BaseRevenueTM1_InsertTimeStamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_BaseRevenue] PRIMARY KEY CLUSTERED ([TM1BaseRevenueKey] ASC)
);

