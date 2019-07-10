CREATE TABLE [FPV].[CalculationGroupUDC] (
    [DistributionGroupCode] VARCHAR (20)                                NOT NULL,
    [DistributionCode]      VARCHAR (20)                                NOT NULL,
    [Society]               VARCHAR (20)                                NOT NULL,
    [StationID]             VARCHAR (20)                                NOT NULL,
    [UDCCode]               VARCHAR (20)                                NOT NULL,
    [UDCDescription]        VARCHAR (100)                               NOT NULL,
    [UsedForPurposeDesc]    VARCHAR (50)                                NOT NULL,
    [TimeBand]              VARCHAR (50)                                NOT NULL,
    [PeakSplitPercent]      DECIMAL (12, 5)                             NULL,
    [UpdatedBy]             VARCHAR (100)                               NOT NULL,
    [UpdateComment]         VARCHAR (255)                               NULL,
    [SysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_UDCG_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_UDCG_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC, [UsedForPurposeDesc] ASC, [TimeBand] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupUDCHistory], DATA_CONSISTENCY_CHECK=ON));







