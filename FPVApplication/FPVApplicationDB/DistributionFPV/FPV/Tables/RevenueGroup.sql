CREATE TABLE [FPV].[RevenueGroup] (
    [RevenueGroupCode]               VARCHAR (20)                                NOT NULL,
    [DistributionGroupCode]          VARCHAR (20)                                NULL,
    [RevenueGroupName]               VARCHAR (100)                               NULL,
    [SocietySplitPercent]            DECIMAL (18, 3)                             NULL,
    [RevenueApportionment]           VARCHAR (1)                                 NULL,
    [IsExcluded]                     BIT                                         NULL,
    [SysStartTime]                   DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_LicenceGroup_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                     DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_LicenceGroup_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [CodaCustomerCode]               VARCHAR (100)                               CONSTRAINT [LG_CodaCustomerCode] DEFAULT ('unknown') NULL,
    [HedgedRate]                     VARCHAR (100)                               CONSTRAINT [LG_HedgedRate] DEFAULT ('unknown') NULL,
    [RevenueApportionmentMethodPRS]  VARCHAR (100)                               CONSTRAINT [LG_RevenueApportionmentMethod] DEFAULT ('Unknown') NULL,
    [RevenueApportionmentMethodMCPS] VARCHAR (100)                               CONSTRAINT [LG_RevenueApportionmentMethodMCPS] DEFAULT ('Unknown') NULL,
    PRIMARY KEY CLUSTERED ([RevenueGroupCode] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[RevenueGroupHistory], DATA_CONSISTENCY_CHECK=ON));





GO


GO


GO


GO


GO


GO


GO


