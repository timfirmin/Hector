CREATE TABLE [FPV].[MasterRevenueHistory] (
    [DistributionGroupCode]   VARCHAR (20)    NOT NULL,
    [DistributionCode]        VARCHAR (20)    NOT NULL,
    [Society]                 VARCHAR (10)    NOT NULL,
    [CodaCustomerCode]        VARCHAR (20)    NOT NULL,
    [CodaCustomerDescription] VARCHAR (100)   NULL,
    [Scenario]                VARCHAR (50)    NOT NULL,
    [PlanningPeriod]          INT             NOT NULL,
    [PlanningYear]            INT             NOT NULL,
    [LatestScenarioFlag]      VARCHAR (1)     NULL,
    [Revenue]                 DECIMAL (18, 3) NULL,
    [UpdatedBy]               VARCHAR (100)   NOT NULL,
    [UpdateComment]           VARCHAR (255)   NULL,
    [SysStartTime]            DATETIME2 (7)   NOT NULL,
    [SysEndTime]              DATETIME2 (7)   NOT NULL,
    [PreferenceScenarioFlag]  VARCHAR (1)     CONSTRAINT [MRh_PreferenceScenarioFlag] DEFAULT ('N') NULL,
    [ActiveScenarioFlag]      VARCHAR (1)     CONSTRAINT [MRh_ActiveScenarioFlag] DEFAULT ('N') NULL
);


















GO
CREATE CLUSTERED INDEX [ix_MasterRevenueHistory]
    ON [FPV].[MasterRevenueHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);





