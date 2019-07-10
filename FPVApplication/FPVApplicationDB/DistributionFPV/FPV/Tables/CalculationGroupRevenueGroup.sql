 
CREATE TABLE [FPV].[CalculationGroupRevenueGroup] (
    [DistributionGroupCode]          VARCHAR (20)                                NOT NULL,
    [DistributionCode]               VARCHAR (20)                                NOT NULL,
    [Society]                        VARCHAR (10)                                NOT NULL,
    [RevenueGroupCode]               VARCHAR (20)                                NOT NULL,
    [RevenueGroupName]               VARCHAR (100)                               NOT NULL,
    [SocietySplitPercent]            DECIMAL (18, 3)                             NULL,
    [HedgePercent]                   DECIMAL (18, 3)                             NULL,
    [EstimatedRevenue]               DECIMAL (18, 3)                             NULL,
    [EstimatedPoints]                DECIMAL (18, 3)                             NULL,
    [HedgedRevenue]                  DECIMAL (18, 3)                             NULL,
    [SocietyRevenue]                 DECIMAL (18, 3)                             NULL,
    [IsExcluded]                     BIT                                         NULL,
    [UpdatedBy]                      VARCHAR (100)                               NOT NULL,
    [UpdateComment]                  VARCHAR (255)                               NULL,
    [SysStartTime]                   DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroupLicenceGroup_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                     DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_SCalculationGroupLicenceGroup_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [FPVStatus]                      VARCHAR (20)                                CONSTRAINT [CGT_FPVStatus] DEFAULT ('PROG') NULL,
    [RingFenceValue]                 DECIMAL (18, 3)                             CONSTRAINT [CGLG_RingFenceValue] DEFAULT ('0') NULL,
    [RevenueApportionmentMethodPRS]  VARCHAR (100)                               CONSTRAINT [CGLG_RevenueApportionmentMethod] DEFAULT ('Unknown') NULL,
    [RevenueApportionmentMethodMCPS] VARCHAR (100)                               CONSTRAINT [CGLG_RevenueApportionmentMethodMCPS] DEFAULT ('Unknown') NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [RevenueGroupCode] ASC) WITH (IGNORE_DUP_KEY = ON),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupRevenueGroupHistory], DATA_CONSISTENCY_CHECK=ON));





GO


GO


GO


GO


GO


GO


GO


