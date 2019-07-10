CREATE TABLE [FPV].[MasterRevenue] (
    [DistributionGroupCode]   VARCHAR (20)                                NOT NULL,
    [DistributionCode]        VARCHAR (20)                                NOT NULL,
    [Society]                 VARCHAR (10)                                NOT NULL,
    [CodaCustomerCode]        VARCHAR (20)                                NOT NULL,
    [CodaCustomerDescription] VARCHAR (100)                               CONSTRAINT [MR_CodaCustomerDescription] DEFAULT ('unknown') NULL,
    [Scenario]                VARCHAR (50)                                CONSTRAINT [DF_Scenario] DEFAULT ('Unknown') NOT NULL,
    [PlanningPeriod]          INT                                         CONSTRAINT [MR_PlanningPeriod] DEFAULT ((0)) NOT NULL,
    [PlanningYear]            INT                                         CONSTRAINT [MR_PlanningYear] DEFAULT ((0)) NOT NULL,
    [LatestScenarioFlag]      VARCHAR (1)                                 CONSTRAINT [MR_LatestScenarioFlag] DEFAULT ('N') NULL,
    [Revenue]                 DECIMAL (18, 3)                             NULL,
    [UpdatedBy]               VARCHAR (100)                               NOT NULL,
    [UpdateComment]           VARCHAR (255)                               NULL,
    [SysStartTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_MasterRevenue_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]              DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_MasterRevenue_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [PreferenceScenarioFlag]  VARCHAR (1)                                 CONSTRAINT [MR_PreferenceScenarioFlag] DEFAULT ('N') NULL,
    [ActiveScenarioFlag]      VARCHAR (1)                                 CONSTRAINT [MR_ActiveScenarioFlag] DEFAULT ('N') NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [CodaCustomerCode] ASC, [PlanningPeriod] ASC, [Scenario] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[MasterRevenueHistory], DATA_CONSISTENCY_CHECK=ON));















