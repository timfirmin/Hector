 --=============================================
-- Last Change By: TJF 2019APR24 Removed Seed,Prev,Current and 'i' to 'master'      select * from [FPV].[udfRevenueGroupData] (63388)
-- Last Change By: TJF 2019APR25 Further fields removal - Calculation fields etc
-- Last Change By: TJF 2019APR30 Added Station ID Filter Test : Select * from [FPV].[udfRevenueGroupData]  (74947)
-- =============================================
CREATE FUNCTION [FPV].[udfRevenueGroupData]
(	
	-- Add the parameters for the function here
	@RequestID int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT 
	   s.[Society]
      ,s.[DistributionGroupCode]
      ,s.[DistributionCode]
      --,s.[CalculationPeriodStatus]
      --,s.[CalculationPeriodStart]
      --,s.[CalculationPeriodEnd]
      ,s.[masterCodaCustomerCode]
      ,s.[masterRevenueGroupName]
      ,s.[masterSocietySplitPercent]
 
      ,s.[masterHedgedRate]
      ,s.[masterIsExcluded]
   
       ,s.[MasterRevenue]

      ,s.masterRevenueApportionmentMethodPRS
      ,s.masterRevenueApportionmentMethodMCPS

      ,s.[masterSysStartTime]
      ,s.[masterSysEndTime]
 
      --,s.[CalculationGroupIsCurrent]
      ,s.[CodaCustomerCode]
      ,s.[RevenueGroupName]
      ,s.[SocietySplitPercent]
      ,s.[IsExcluded]
	  --,s.[EstimatedPoints]
	  ,s.[EstimatedRevenue]
	  --,s.[HedgedRevenue]
	  --,s.[HedgePercent]
      ,s.RevenueApportionmentMethodPRS
      ,s.RevenueApportionmentMethodMCPS
	  ,s.[RingFenceValue]
   
      --,s.[intervalSysStartTime]
      ,s.[UpdatedBy]
      ,s.[UpdateComment]
      ,s.[SysStartTime]
      ,s.[SysEndTime]
      ,s.[masterIsCurrent]
	  ,'' as [masterUpdateComment]
     --,s.[CalculationGroupRevenueGroupIsCurrent]
 
      ,s.[IsCurrent]

  FROM [FPV].[vApplicationRevenueGroupView] s, [FPV].[vRequestFilters] r
  WHERE	r.RequestID=@RequestID
		AND
		--apply filters
		(
			--temporal data filter
			(
				(	
					(r.[TemporalView] IS NULL OR r.[TemporalView] ='Current')
					AND 
					(s.[IsCurrent]=1)
				)
				OR
				(
					r.[TemporalView] = 'Historical'
				)
			)
			AND
			(
				(r.[DistributionGroupCode] IS NULL OR s.[DistributionGroupCode] = r.[DistributionGroupCode])
				AND
				(r.[DistributionCode] IS NULL OR s.[DistributionCode]=r.[DistributionCode])
				AND
				(r.[Society] IS NULL OR s.[Society]=r.[Society])
			)
			AND (s.[masterCodaCustomerCode]=r.[CodaCustomerCode] OR r.[CodaCustomerCode] IS NULL)


				--APPLY Station ID Filter
	AND (	r.[StationID] IS NULL 
			OR 
			[FPV].[udfGetCodaCustomerCode]  ( r.[StationID]) = s.[masterCodaCustomerCode])
		)	
)
GO

