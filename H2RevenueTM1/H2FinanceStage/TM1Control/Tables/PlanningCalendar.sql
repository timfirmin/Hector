CREATE TABLE [TM1Control].[PlanningCalendar] (
    [PlanningCalendarUniqueKey]      INT           IDENTITY (1, 1) NOT NULL,
    [PlanningScenarioKey]            INT           NULL,
    [PlanningFileType]               VARCHAR (50)  NULL,
    [PlanningFileTypeKey]            INT           NULL,
    [PlanningYear]                   VARCHAR (50)  NULL,
    [PlanningScenario]               VARCHAR (50)  NULL,
    [PlanningScenarioValidFrom]      DATETIME2 (2) NULL,
    [PlanningScenarioExpected]       VARCHAR (1)   NULL,
    [ScenarioFirstArrivedDate]       DATETIME2 (2) NULL,
    [ScenarioFirstArrivedFileLogKey] INT           NULL,
    [ScenarioLastUpdatedDate]        DATETIME2 (2) NULL,
    [ScenarioLastUpdatedFileLogKey]  INT           NULL,
    [ScenarioLastUpdatedPeriodFrom]  INT           NULL,
    [ScenarioLastUpdatedPeriodTo]    INT           NULL,
    [InsertDateTime]                 DATETIME2 (2) CONSTRAINT [DF_PlanningCalendar_InsertDateTime] DEFAULT (getdate()) NULL,
    [InsertLoadId]                   INT           NULL,
    CONSTRAINT [PK_PlanningCalendar] PRIMARY KEY CLUSTERED ([PlanningCalendarUniqueKey] ASC)
);








GO
CREATE UNIQUE NONCLUSTERED INDEX [Unique_PlanningCalendar]
    ON [TM1Control].[PlanningCalendar]([PlanningScenario] ASC, [PlanningFileType] ASC, [PlanningYear] ASC) WITH (IGNORE_DUP_KEY = ON);






GO


