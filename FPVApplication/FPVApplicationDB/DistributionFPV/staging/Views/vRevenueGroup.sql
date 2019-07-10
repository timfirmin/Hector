
CREATE view [staging].[vRevenueGroup]
as
 

SELECT lg.[Code][RevenueGroupCode]
		,dg.DistributionGroupCode
      ,lg.[Name][RevenueGroupName]
      ,lg.[SocietySplitPercent][SocietySplitPercent]
      ,left(isnull(lg.[RevenueApportionment], 0),1)[RevenueApportionment]
      ,lg.[RevenueApportionmentMethodPRS][RevenueApportionmentMethodPRS]
    ,lg.[RevenueApportionmentMethodMCPS][RevenueApportionmentMethodMCPS]
      ,lg.[DistributionGroup][DistributionGroup]
      ,lg.[CodaCustomerCode][CodaCustomerCode]
      ,lg.[HedgedRate][HedgedRate]
		,0 [IsExcluded]

  FROM [staging].[RevenueGroup] lg

join [FPV].[DistributionGroup] dg on lg.DistributionGroup = dg.DistributionGroupCode
where dg.Enabled = 1
GO

