CREATE TABLE [FPV].[CalculationGroupRevenueGroupHistory](
	[DistributionGroupCode] [varchar](20) NOT NULL,
	[DistributionCode] [varchar](20) NOT NULL,
	[Society] [varchar](10) NOT NULL,
	[RevenueGroupCode] [varchar](20) NOT NULL,
	[RevenueGroupName] [varchar](100) NOT NULL,
	[SocietySplitPercent] [decimal](18, 3) NULL,
	[HedgePercent] [decimal](18, 3) NULL,
	[EstimatedRevenue] [decimal](18, 3) NULL,
	[EstimatedPoints] [decimal](18, 3) NULL,
	[HedgedRevenue] [decimal](18, 3) NULL,
	[SocietyRevenue] [decimal](18, 3) NULL,
	[IsExcluded] [bit] NULL,
	[UpdatedBy] [varchar](100) NOT NULL,
	[UpdateComment] [varchar](255) NULL,
	[SysStartTime] [datetime2](7) NOT NULL,
	[SysEndTime] [datetime2](7) NOT NULL,
	[FPVStatus] [varchar](20) NULL,
	[RingFenceValue] [decimal](18, 3) NULL,
	[RevenueApportionmentMethodPRS] [varchar](100) NULL,
	[RevenueApportionmentMethodMCPS] [varchar](100) NULL
) ON [PRIMARY]

GO

ALTER TABLE [FPV].[CalculationGroupRevenueGroupHistory] ADD  CONSTRAINT [CGTh_FPVStatus]  DEFAULT ('PROG') FOR [FPVStatus]
GO

ALTER TABLE [FPV].[CalculationGroupRevenueGroupHistory] ADD  CONSTRAINT [CGLGh_RingFenceValue]  DEFAULT ('0') FOR [RingFenceValue]
GO

ALTER TABLE [FPV].[CalculationGroupRevenueGroupHistory] ADD  CONSTRAINT [CGLGh_RevenueApportionmentMethod]  DEFAULT ('Unknown') FOR [RevenueApportionmentMethodPRS]
GO

ALTER TABLE [FPV].[CalculationGroupRevenueGroupHistory] ADD  CONSTRAINT [CGLGh_RevenueApportionmentMethodMCPS]  DEFAULT ('Unknown') FOR [RevenueApportionmentMethodMCPS]
GO


