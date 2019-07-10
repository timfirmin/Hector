
CREATE VIEW [FPV].[vCalculationGroupRevenueGroup]
AS
WITH Holistic AS (
SELECT [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[RevenueGroupCode][CodaCustomerCode]

      ,[RevenueGroupName]
      ,[SocietySplitPercent]
      ,[HedgePercent]
      ,[EstimatedRevenue]
      ,[EstimatedPoints]
      ,[HedgedRevenue]
      ,[SocietyRevenue]

	  --Added 2019FEB19
      ,[RevenueApportionmentMethodPRS]
      ,[RevenueApportionmentMethodMCPS]

	  --Added 2019MAR05
      ,[RingFenceValue]

      ,[FPVStatus]
      ,[IsExcluded]

      ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,[SysEndTime]
	  ,1 [IsCurrent]
  FROM [FPV].[CalculationGroupRevenueGroup]
UNION
SELECT [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[RevenueGroupCode][CodaCustomerCode]

      ,[RevenueGroupName]
      ,[SocietySplitPercent]
      ,[HedgePercent]
      ,[EstimatedRevenue]
      ,[EstimatedPoints]
      ,[HedgedRevenue]
      ,[SocietyRevenue]

	  --Added 2019FEB19
      ,[RevenueApportionmentMethodPRS]
      ,[RevenueApportionmentMethodMCPS]

	  --Added 2019MAR05
      ,[RingFenceValue]

      ,[FPVStatus]
      ,[IsExcluded]

      ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,[SysEndTime]
	  ,0 [IsCurrent]
  FROM [FPV].[CalculationGroupRevenueGroupHistory]
)
SELECT [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[CodaCustomerCode]

	  ,[RevenueGroupName]
      ,[SocietySplitPercent]
      ,[HedgePercent]
      ,[EstimatedRevenue]
      ,[EstimatedPoints]
      ,[HedgedRevenue]
      ,[SocietyRevenue]

	  --Added 2019FEB19
      ,[RevenueApportionmentMethodPRS]
      ,[RevenueApportionmentMethodMCPS]

	  --Added 2019MAR05
      ,[RingFenceValue]
      
	  ,[FPVStatus]
      ,[IsExcluded]

	  ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,dateadd(ms,-1,[SysEndTime])[SysEndTime]
	  ,[IsCurrent]
FROM Holistic
GO

