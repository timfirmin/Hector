 --=============================================
-- Last Change By: TJF 2019APR24
-- Removed Seed,Prev,Current and 'i' to 'master'
-- =============================================
CREATE VIEW [FPV].[vMasterRevenueGroup]
AS
WITH Holistic AS (
SELECT [RevenueGroupCode]
      ,[DistributionGroupCode]
      ,[RevenueGroupName]
      ,[SocietySplitPercent]

      ,[RevenueApportionmentMethodPRS]
      ,[RevenueApportionmentMethodMCPS]
      ,[CodaCustomerCode]
      ,[HedgedRate]
      ,[IsExcluded]
      ,[SysStartTime]
      ,[SysEndTime]
	  ,1 [IsCurrent]
FROM [FPV].[RevenueGroup]
UNION
SELECT [RevenueGroupCode]
      ,[DistributionGroupCode]
      ,[RevenueGroupName]
      ,[SocietySplitPercent]

      ,[RevenueApportionmentMethodPRS]
      ,[RevenueApportionmentMethodMCPS]
      ,[CodaCustomerCode]
      ,[HedgedRate]
      ,[IsExcluded]
      ,[SysStartTime]
      ,[SysEndTime]
	  ,0 [IsCurrent]
FROM [FPV].[RevenueGroupHistory]
)
SELECT [DistributionGroupCode]
      ,[RevenueGroupCode]
      ,[RevenueGroupName]
      ,[SocietySplitPercent]

      ,[RevenueApportionmentMethodPRS]
      ,[RevenueApportionmentMethodMCPS]
      ,[CodaCustomerCode]
      ,[HedgedRate]
      ,[IsExcluded]
	   ,[SysStartTime]
      ,dateadd(millisecond,-1,[SysEndTime])[SysEndTime]
	  ,[IsCurrent]
FROM [Holistic]
GO

