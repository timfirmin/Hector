/*
 * Tim Firmin 2019OCT11 - Update-Merge MasterRevenueGroup table from MDS
 * Update 2018OCT17 Bring in CodaCustomerCode for Revenue Apportionment
 * Update 2019FEB16 Bring in RA Methods	
 * Test: EXEC [staging].[uspMergeRevenueGroup] @pLoadId = 321, @pUserName = 'tjf',  @pInsertedRowCount = 0
 */ 
CREATE PROCEDURE [staging].[uspMergeRevenueGroup]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

merge [FPV].[RevenueGroup] t
using [staging].[vRevenueGroup] s
on (t.[RevenueGroupCode]) = (s.[RevenueGroupCode])

when not matched by target then
insert ([RevenueGroupCode] ,[DistributionGroupCode] ,[RevenueGroupName] ,[SocietySplitPercent] ,[RevenueApportionment] ,[CodaCustomerCode], [HedgedRate], [IsExcluded], [RevenueApportionmentMethodPRS], [RevenueApportionmentMethodMCPS])
values (s.[RevenueGroupCode] ,s.[DistributionGroupCode] ,s.[RevenueGroupName] ,s.[SocietySplitPercent] ,s.[RevenueApportionment] ,s.[CodaCustomerCode], s.[HedgedRate], s.[IsExcluded], s.[RevenueApportionmentMethodPRS], s.[RevenueApportionmentMethodMCPS])

when MATCHED  
		   AND isnull(t.[RevenueGroupCode],0)!=isnull(s.[RevenueGroupCode],0)
			OR isnull(t.[DistributionGroupCode],0)!=isnull(s.[DistributionGroupCode],0)
			OR isnull(t.[RevenueGroupName],0)!=isnull(s.[RevenueGroupName],0)
			OR isnull(t.[SocietySplitPercent],0)!=isnull(s.[SocietySplitPercent],0)
			OR isnull(t.[RevenueApportionment],0)!=isnull(s.[RevenueApportionment],0)
			OR isnull(t.[RevenueApportionmentMethodPRS],0)!=isnull(s.[RevenueApportionmentMethodPRS],0)
			OR isnull(t.[RevenueApportionmentMethodMCPS],0)!=isnull(s.[RevenueApportionmentMethodMCPS],0)
			OR isnull(t.[CodaCustomerCode],0)!=isnull(s.[CodaCustomerCode],0)
			OR isnull(t.[HedgedRate],0)!=isnull(s.[HedgedRate],0)
			OR isnull(t.[IsExcluded],0)!=isnull(s.[IsExcluded],0)
THEN UPDATE
		 SET 
			 [RevenueGroupCode]=s.[RevenueGroupCode]
			,[DistributionGroupCode]=s.[DistributionGroupCode]
			,[RevenueGroupName]=s.[RevenueGroupName]
			,[SocietySplitPercent]=s.[SocietySplitPercent]
			,[RevenueApportionment]=s.[RevenueApportionment]
			,[CodaCustomerCode]=s.[CodaCustomerCode]
			,[HedgedRate]=s.[HedgedRate]
			,[IsExcluded]=s.[IsExcluded]
			,[RevenueApportionmentMethodPRS]=s.[RevenueApportionmentMethodPRS]
			,[RevenueApportionmentMethodMCPS]=s.[RevenueApportionmentMethodMCPS]

when not matched by source then delete;

/* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT

END
GO

