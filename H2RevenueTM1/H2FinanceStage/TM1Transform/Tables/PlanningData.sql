CREATE TABLE [TM1Transform].[PlanningData] (
    [PlanningDataKey]        INT           IDENTITY (1, 1) NOT NULL,
    [PlanningScenarioKey]    INT           NULL,
    [PlanningFileLogKey]     INT           NULL,
    [PlanningFileTypeKey]    INT           NULL,
    [PlanningCalendarKey]    INT           NULL,
    [PlanningFilePeriodSeq]  INT           NULL,
    [PlanningPeriodFirstDay] DATETIME2 (2) NULL,
    [Company]                VARCHAR (50)  NULL,
    [Class]                  VARCHAR (150) NULL,
    [Level4]                 VARCHAR (150) NULL,
    [Level3]                 VARCHAR (150) NULL,
    [Level2]                 VARCHAR (150) NULL,
    [Level1]                 VARCHAR (150) NULL,
    [EL1Description]         VARCHAR (150) NULL,
    [EL1Code]                VARCHAR (150) NULL,
    [EL2Description]         VARCHAR (150) NULL,
    [EL2Code]                VARCHAR (150) NULL,
    [PlanningPeriod]         VARCHAR (50)  NULL,
    [PlanningYear]           VARCHAR (50)  NULL,
    [PlanningScenario]       VARCHAR (50)  NULL,
    [ValueGBP]               MONEY         NULL,
    [InsertTimeStamp]        DATETIME2 (2) CONSTRAINT [DF_PlanningData_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]           INT           NULL
);



