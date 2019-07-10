CREATE TABLE [tm1].[PlanningExtractCosts] (
    [PlanningExtractKey]          INT          IDENTITY (1, 1) NOT NULL,
    [PlanningExtractReferenceKey] INT          NULL,
    [Company]                     VARCHAR (50) NULL,
    [Company_KEY]                 AS           (CONVERT([bigint],hashbytes('SHA1',[Company]))),
    [BusinessUnit]                VARCHAR (50) NULL,
    [SubBusinessUnitEL2]          VARCHAR (50) NULL,
    [EL2Code]                     AS           (ltrim(substring([SubBusinessUnitEL2],charindex('-',[SubBusinessUnitEL2],(1))+(1),(10)))),
    [AccountEL2_KEY]              AS           (CONVERT([bigint],hashbytes('SHA1',([Company]+'_')+ltrim(substring([SubBusinessUnitEL2],charindex('-',[SubBusinessUnitEL2],(1))+(1),(10)))))),
    [Category]                    VARCHAR (50) NULL,
    [Mapping]                     VARCHAR (50) NULL,
    [CategoryEL1]                 VARCHAR (50) NULL,
    [EL1Code]                     AS           (rtrim(left([CategoryEL1],(6)))),
    [AccountEL1_KEY]              AS           (CONVERT([bigint],hashbytes('SHA1',([Company]+'_')+rtrim(left([CategoryEL1],(6)))))),
    [PlanningPeriod]              VARCHAR (50) NULL,
    [PlanningYear]                VARCHAR (50) NULL,
    [PlanningScenario]            VARCHAR (50) NULL,
    [ValueGBP]                    MONEY        NULL,
    [InsertTimeStamp]             DATETIME     CONSTRAINT [DF_Planning_Extract_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]                INT          NULL,
    CONSTRAINT [PK_PlanningExtract] PRIMARY KEY CLUSTERED ([PlanningExtractKey] ASC)
);

