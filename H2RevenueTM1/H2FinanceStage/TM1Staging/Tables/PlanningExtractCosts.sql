CREATE TABLE [TM1Staging].[PlanningExtractCosts] (
    [PlanningExtractKey]  INT           IDENTITY (1, 1) NOT NULL,
    [PlanningFileTypeKey] INT           NULL,
    [PlanningScenarioKey] INT           NULL,
    [FileLogUniqueKey]    INT           NULL,
    [Company]             VARCHAR (50)  NULL,
    [BusinessUnit]        VARCHAR (50)  NULL,
    [SubBusinessUnit]     VARCHAR (50)  NULL,
    [Category]            VARCHAR (50)  NULL,
    [Mapping]             VARCHAR (50)  NULL,
    [PlanningAccount]     VARCHAR (50)  NULL,
    [PlanningPeriod]      VARCHAR (50)  NULL,
    [PlanningYear]        VARCHAR (50)  NULL,
    [PlanningScenario]    VARCHAR (50)  NULL,
    [ValueGBP]            FLOAT (53)    NULL,
    [InsertTimeStamp]     DATETIME2 (2) CONSTRAINT [DF_Planning_Extract_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]        INT           NULL,
    CONSTRAINT [PK_PlanningExtract] PRIMARY KEY CLUSTERED ([PlanningExtractKey] ASC)
);







