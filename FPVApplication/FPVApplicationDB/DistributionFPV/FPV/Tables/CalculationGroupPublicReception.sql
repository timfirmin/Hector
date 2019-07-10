CREATE TABLE [FPV].[CalculationGroupPublicReception] (
    [DistributionGroupCode] VARCHAR (20)                                NOT NULL,
    [DistributionCode]      VARCHAR (20)                                NOT NULL,
    [Society]               VARCHAR (20)                                NOT NULL,
    [StationID]             VARCHAR (20)                                NOT NULL,
    [TotalPRAllocation]     DECIMAL (18, 3)                             NULL,
    [UpdatedBy]             VARCHAR (100)                               NULL,
    [UpdateComment]         VARCHAR (255)                               NULL,
    [SysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroupPublicReception_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_CalculationGroupPublicReception_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupPublicReceptionHistory], DATA_CONSISTENCY_CHECK=ON));





