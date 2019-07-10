CREATE TABLE [FPV].[CalculationGroup] (
    [DistributionGroupCode]  VARCHAR (20)                                NOT NULL,
    [DistributionCode]       VARCHAR (20)                                NOT NULL,
    [Society]                VARCHAR (10)                                NOT NULL,
    [CalculationGroupStatus] VARCHAR (20)                                NOT NULL,
    [CalculationPeriodStart] DATETIME                                    NOT NULL,
    [CalculationPeriodEnd]   DATETIME                                    NOT NULL,
    [UpdatedBy]              VARCHAR (100)                               NOT NULL,
    [UpdateComment]          VARCHAR (255)                               NULL,
    [SysStartTime]           DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroup_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]             DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_CalculationGroup_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [Enabled]                BIT                                         CONSTRAINT [CGT_Enabled] DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupHistory], DATA_CONSISTENCY_CHECK=ON));

