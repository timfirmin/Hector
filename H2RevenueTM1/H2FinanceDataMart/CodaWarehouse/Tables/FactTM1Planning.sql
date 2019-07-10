CREATE TABLE [CodaWarehouse].[FactTM1Planning] (
    [TM1PlanningKey]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyKey]               BIGINT        NULL,
    [DocumentKey]              BIGINT        NULL,
    [AccountKey_EL1]           BIGINT        NULL,
    [AccountCode_EL1]          VARCHAR (150) NULL,
    [AccountKey_EL2]           BIGINT        NULL,
    [AccountCode_EL2]          VARCHAR (150) NULL,
    [TM1CostRevenue]           VARCHAR (150) NULL,
    [TM1Class]                 VARCHAR (150) NOT NULL,
    [TM1Level4]                VARCHAR (150) NOT NULL,
    [TM1Level3]                VARCHAR (150) NOT NULL,
    [TM1Level2]                VARCHAR (150) NOT NULL,
    [TM1Level1]                VARCHAR (150) NOT NULL,
    [CodaFiscalDate]           DATETIME      NULL,
    [BudgetValue]              MONEY         NOT NULL,
    [ForecastQ1Value]          MONEY         NOT NULL,
    [ForecastQ2Value]          MONEY         NOT NULL,
    [ForecastQ3Value]          MONEY         NOT NULL,
    [SourcePlanningFileLogKey] INT           NULL,
    [InsertLoadId]             INT           NULL,
    [InsertTimestamp]          DATETIME      CONSTRAINT [DF_FactTM1Planning_InsertTimestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_FactTM1Planning] PRIMARY KEY CLUSTERED ([TM1PlanningKey] ASC)
);
GO

