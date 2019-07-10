CREATE TABLE [FPV].[CalculationGroupMissingMinutes] (
    [DistributionGroupCode] VARCHAR (20)                                NOT NULL,
    [DistributionCode]      VARCHAR (20)                                NOT NULL,
    [Society]               VARCHAR (20)                                NOT NULL,
    [StationID]             VARCHAR (20)                                NOT NULL,
    [MissingMinutes]        INT                                         NULL,
    [CarryForwardsMinutes]  INT                                         NULL,
    [TotalMinutesToHold]    INT                                         NULL,
    [MissingRevenue]        DECIMAL (18, 3)                             NULL,
    [CarryForwardsRevenue]  DECIMAL (18, 3)                             NULL,
    [TotalRevenueToHold]    DECIMAL (18, 3)                             NULL,
    [UpdatedBy]             VARCHAR (100)                               NOT NULL,
    [UpdateComment]         VARCHAR (255)                               NULL,
    [SysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroupMissingMinutes_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_CalculationGroupMissingMinutes_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupMissingMinutesHistory], DATA_CONSISTENCY_CHECK=ON));







