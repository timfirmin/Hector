

CREATE VIEW [FPV].[vCalculationGroupMasterRevenueGroup]
AS
 --=============================================
-- Last Change By: TJF 2019APR24
-- Removed Seed,Prev,Current and 'i' to 'master'  added Master Revenue at Group Level
-- =============================================
SELECT 
	C.[DistributionGroupCode]
	,C.[DistributionCode]
	,C.[Society]
	,C.[CalculationGroupStatus][CalculationPeriodStatus]
	,C.[CalculationPeriodStart]
	,C.[CalculationPeriodEnd]
	,C.[IsCurrent][CalculationGroupIsCurrent]

	,S.[RevenueGroupCode]
	,S.[RevenueGroupName]
	,S.[SocietySplitPercent]
	,S.[CodaCustomerCode]
	,S.[HedgedRate]
	,S.[RevenueApportionmentMethodPRS]
	,S.[RevenueApportionmentMethodMCPS]
	,S.[IsExcluded]

	,MRCG.[Revenue] as	MasterRevenue
	,S.[IsCurrent][MasterRevenueGroupIsCurrent]

	,S.[SysStartTime]
	,S.[SysEndTime]
	,S.[IsCurrent]

FROM [FPV].[vCalculationGroup] C
CROSS APPLY ( SELECT 
		 [RevenueGroupCode]
		,[RevenueGroupName]
		,[SocietySplitPercent]
		,[CodaCustomerCode]
		,[HedgedRate]
		,[RevenueApportionmentMethodPRS]
		,[RevenueApportionmentMethodMCPS]
		,[IsExcluded]
	
		,[SysStartTime]
		,[SysEndTime]
		,[IsCurrent]
				FROM [FPV].[vMasterRevenueGroup]
				WHERE [DistributionGroupCode]=C.[DistributionGroupCode]
				--AND	[SysStartTime] BETWEEN C.[SysStartTime] AND C.[SysEndTime]
				AND [FPV].[vMasterRevenueGroup].IsCurrent = 1
				) S (
		 [RevenueGroupCode]
		,[RevenueGroupName]
		,[SocietySplitPercent]
		,[CodaCustomerCode]
		,[HedgedRate]
		,[RevenueApportionmentMethodPRS]
		,[RevenueApportionmentMethodMCPS]
		,[IsExcluded]
	
		,[SysStartTime]
		,[SysEndTime]
		,[IsCurrent])

LEFT JOIN [FPV].[vMasterRevenueCalculationGroup] MRCG
on 	C.[DistributionGroupCode] = MRCG.[DistributionGroupCode]
	and C.[DistributionCode] = MRCG.[DistributionCode]
	and C.[Society] = MRCG.[Society]
	and S.[RevenueGroupCode] = MRCG.[CodaCustomerCode]
WHERE C.[IsCurrent] = 1
GO

