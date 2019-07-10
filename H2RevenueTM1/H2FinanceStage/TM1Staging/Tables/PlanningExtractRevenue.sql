CREATE TABLE [TM1Staging].[PlanningExtractRevenue] (
    [PlanningExtractKey]  INT           IDENTITY (1, 1) NOT NULL,
    [PlanningFileTypeKey] INT           NULL,
    [PlanningScenarioKey] INT           NULL,
    [FileLogUniqueKey]    INT           NULL,
    [Company]             VARCHAR (50)  NULL,
    [Class]               VARCHAR (150) NULL,
    [Level4]              VARCHAR (150) NULL,
    [Level3]              VARCHAR (150) NULL,
    [Level2]              VARCHAR (150) NULL,
    [Level1]              VARCHAR (150) NULL,
    [EL1Description]      VARCHAR (150) NULL,
    [EL1Code]             VARCHAR (150) NULL,
    [EL2Description]      VARCHAR (150) NULL,
    [EL2Code]             VARCHAR (150) NULL,
    [PlanningPeriod]      VARCHAR (50)  NULL,
    [PlanningYear]        VARCHAR (50)  NULL,
    [PlanningScenario]    VARCHAR (50)  NULL,
    [ValueGBP]            FLOAT (53)    NULL,
    [InsertTimeStamp]     DATETIME2 (2) CONSTRAINT [DF_PlanningExtractRevenue_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]        INT           CONSTRAINT [DF_PlanningExtractRevenue_InsertLoadId] DEFAULT ((12345)) NULL,
    CONSTRAINT [PK_PlanningExtractRevenue] PRIMARY KEY CLUSTERED ([PlanningExtractKey] ASC)
);







