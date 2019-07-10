CREATE TABLE [FPV].[MasterMissingMinutes] (
    [DistributionGroupCode]      VARCHAR (50)                                CONSTRAINT [MiM_DistributionGroupCode] DEFAULT ('Unknown') NOT NULL,
    [DistributionCode]           VARCHAR (50)                                CONSTRAINT [MiM_DistributionCode] DEFAULT ('Unknown') NOT NULL,
    [Society]                    VARCHAR (50)                                CONSTRAINT [MiM_Society] DEFAULT ('Unknown') NOT NULL,
    [StationID]                  VARCHAR (20)                                NOT NULL,
    [MissingMinutes]             INT                                         NULL,
    [CarryForwardsMinutes]       INT                                         NULL,
    [TotalMinutesToHold]         INT                                         NULL,
    [MissingRevenue]             DECIMAL (18, 3)                             NULL,
    [CarryForwardsRevenue]       DECIMAL (18, 3)                             NULL,
    [TotalRevenueToHold]         DECIMAL (18, 3)                             NULL,
    [UpdatedBy]                  VARCHAR (100)                               NOT NULL,
    [UpdateComment]              VARCHAR (255)                               NULL,
    [SysStartTime]               DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_MasterMissingMinutes_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                 DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_MasterMissingMinutes_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [StationName]                VARCHAR (50)                                CONSTRAINT [MM_StationName] DEFAULT ('Unknown') NOT NULL,
    [CalculationGroupStationKey] AS                                          (CONVERT([bigint],hashbytes('SHA1',(([DistributionGroupCode]+[DistributionCode])+[Society])+[StationID]))),
    CONSTRAINT [PK_MasterMissingMinutes] PRIMARY KEY NONCLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[MasterMissingMinutesHistory], DATA_CONSISTENCY_CHECK=ON));












GO
CREATE NONCLUSTERED INDEX [IX_MasterMissingMinutes]
    ON [FPV].[MasterMissingMinutes]([CalculationGroupStationKey] ASC);

