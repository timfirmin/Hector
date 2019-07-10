CREATE TABLE [HectorStaging].[PlanningExtractRevenue] (
    [PlanningExtractKey] INT          IDENTITY (1, 1) NOT NULL,
    [FileLogUniqueKey]   INT          NULL,
    [Company]            VARCHAR (50) NULL,
    [Class]              VARCHAR (50) NULL,
    [Level4]             VARCHAR (50) NULL,
    [Level3]             VARCHAR (50) NULL,
    [Level2]             VARCHAR (50) NULL,
    [Level1]             VARCHAR (50) NULL,
    [EL1Description]     VARCHAR (50) NULL,
    [EL1Code]            VARCHAR (50) NULL,
    [EL2Description]     VARCHAR (50) NULL,
    [EL2Code]            VARCHAR (50) NULL,
    [PlanningPeriod]     VARCHAR (50) NULL,
    [PlanningYear]       VARCHAR (50) NULL,
    [PlanningScenario]   VARCHAR (50) NULL,
    [ValueGBP]           MONEY        NULL,
    [InsertTimeStamp]    DATETIME     CONSTRAINT [DF_PlanningExtractRevenue_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]       INT          CONSTRAINT [DF_PlanningExtractRevenue_InsertLoadId] DEFAULT ((12345)) NULL,
    CONSTRAINT [PK_PlanningExtractRevenue] PRIMARY KEY CLUSTERED ([PlanningExtractKey] ASC)
);

