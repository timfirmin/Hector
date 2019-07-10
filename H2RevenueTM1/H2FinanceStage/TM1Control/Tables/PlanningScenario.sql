CREATE TABLE [TM1Control].[PlanningScenario] (
    [PlanningScenarioUniqueKey] INT           IDENTITY (1, 1) NOT NULL,
    [PlanningScenario]          VARCHAR (255) NULL,
    [PlanningScenarioValidFDM]  VARCHAR (1)   NULL,
    [PlanningScenarioValidFPV]  VARCHAR (1)   NULL,
    [InsertTimeStamp]           DATETIME2 (2) CONSTRAINT [DF_PlanningScenario_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]              INT           NULL,
    CONSTRAINT [PK_PlanningScenario] PRIMARY KEY CLUSTERED ([PlanningScenarioUniqueKey] ASC)
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PlanningScenario]
    ON [TM1Control].[PlanningScenario]([PlanningScenario] ASC) WITH (IGNORE_DUP_KEY = ON);

