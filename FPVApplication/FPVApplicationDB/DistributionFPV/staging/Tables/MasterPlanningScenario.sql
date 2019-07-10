CREATE TABLE [staging].[MasterPlanningScenario] (
    [PlanningYear]                VARCHAR (50)  NULL,
    [PlanningScenario]            VARCHAR (50)  NULL,
    [ScenarioFirstArrivedDate]    DATETIME2 (2) NULL,
    [ScenarioExpectedSignOffDate] DATETIME2 (2) NULL,
    [ScenarioLatestForYearFlag]   VARCHAR (1)   NULL,
    [ScenarioLatestRank]          AS            (case [PlanningScenario] when 'Forecast Q3' then (1) when 'Forecast Q2' then (2) when 'Forecast Q1' then (3) when 'Budget' then (4) when 'Rolling' then (5) when 'Actual' then (6) else (9) end),
    [InsertLoadId]                INT           NULL,
    [InsertTimeStamp]             DATETIME2 (3) CONSTRAINT [DF_MasterPlanningScenario_InsertTimeStamp] DEFAULT (getdate()) NULL
);



