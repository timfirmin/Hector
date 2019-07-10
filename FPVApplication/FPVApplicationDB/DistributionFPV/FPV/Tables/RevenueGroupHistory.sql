CREATE TABLE [FPV].[RevenueGroupHistory] (
    [RevenueGroupCode]               VARCHAR (20)    NOT NULL,
    [DistributionGroupCode]          VARCHAR (20)    NULL,
    [RevenueGroupName]               VARCHAR (100)   NULL,
    [SocietySplitPercent]            DECIMAL (18, 3) NULL,
    [RevenueApportionment]           VARCHAR (1)     NULL,
    [IsExcluded]                     BIT             NULL,
    [SysStartTime]                   DATETIME2 (7)   NOT NULL,
    [SysEndTime]                     DATETIME2 (7)   NOT NULL,
    [CodaCustomerCode]               VARCHAR (100)   CONSTRAINT [LGh_CodaCustomerCode] DEFAULT ('unknown') NULL,
    [HedgedRate]                     VARCHAR (100)   CONSTRAINT [LGh_HedgedRate] DEFAULT ('unknown') NULL,
    [RevenueApportionmentMethodPRS]  VARCHAR (100)   CONSTRAINT [LGh_RevenueApportionmentMethod] DEFAULT ('Unknown') NULL,
    [RevenueApportionmentMethodMCPS] VARCHAR (100)   CONSTRAINT [LGh_RevenueApportionmentMethodMCPS] DEFAULT ('Unknown') NULL
);





GO


GO


GO


GO


GO


