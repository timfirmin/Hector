








CREATE VIEW [FPV].[vApplicationRevenueGroupView]
AS
 --=============================================
-- Last Change By: TJF 2019APR24 : Removed Seed,Prev,Current and 'i' to 'master'
-- Last Change By: TJF 2019APR25 : Removed Calculation fields + others
-- =============================================
WITH intervals AS (
select	[DistributionGroupCode],[DistributionCode],[Society],[RevenueGroupCode],[SysStartTime][intervalSysStartTime] from [FPV].[vCalculationGroupMasterRevenueGroup]
union
select	[DistributionGroupCode],[DistributionCode],[Society],[CodaCustomerCode],[SysStartTime][intervalSysStartTime] from [FPV].[vCalculationGroupRevenueGroup]
)
,CombinedStations AS (
SELECT m.[DistributionGroupCode][masterDistributionGroupCode]
	  ,m.[DistributionCode][masterDistributionCode]
      ,m.[Society][masterSociety]
     
      ,m.[RevenueGroupCode][masterRevenueGroupCode]
      ,m.[RevenueGroupName][masterRevenueGroupName]
      ,m.[SocietySplitPercent][masterSocietySplitPercent]
	  ,m.[CodaCustomerCode][masterCodaCustomerCode]
	  ,m.[HedgedRate][masterHedgedRate]
      ,m.[IsExcluded][masterIsExcluded]
 
	  ,m.RevenueApportionmentMethodPRS[masterRevenueApportionmentMethodPRS]
	  ,m.RevenueApportionmentMethodMCPS[masterRevenueApportionmentMethodMCPS]
   
   ,m.[MasterRevenue]

	  ,m.[MasterRevenueGroupIsCurrent]

	  ,s.[Society]
	  ,s.[DistributionGroupCode]
	  ,s.[DistributionCode]
	  
	  ,m.[CalculationPeriodStatus]
	  ,m.[CalculationPeriodStart]
	  ,m.[CalculationPeriodEnd]
	  ,m.[CalculationGroupIsCurrent]

	  ,s.[CodaCustomerCode]
      ,s.[RevenueGroupName]
      ,s.[SocietySplitPercent]
      ,s.[IsExcluded]
	  ,s.[EstimatedPoints]
	  ,s.[EstimatedRevenue]
	  ,s.[HedgedRevenue]
	  ,s.[HedgePercent]
	  ,s.[RevenueApportionmentMethodPRS]
	  ,s.[RevenueApportionmentMethodMCPS]

	  --Added 2019MAR05
      ,s.[RingFenceValue]

      ,m.[SysStartTime] as [masterSysStartTime]
      ,m.[SysEndTime] as [masterSysEndTime]

	  ,s.[UpdatedBy]
      ,s.[UpdateComment]

	  ,s.[FPVStatus]

	  ,ISNULL(s.[IsCurrent],1)[CalculationGroupRevenueGroupIsCurrent]
	  ,i.[intervalSysStartTime]

FROM  intervals i 
LEFT JOIN [FPV].[vCalculationGroupMasterRevenueGroup] m on	m.[DistributionGroupCode]=i.[DistributionGroupCode]
										and
										m.[DistributionCode]=i.[DistributionCode]
										and
										m.[Society]=i.[Society]
										and
										m.[RevenueGroupCode] = i.[RevenueGroupCode]
										and
										i.[intervalSysStartTime] between m.[SysStartTime] and m.[SysEndTime]
LEFT JOIN [FPV].[vCalculationGroupRevenueGroup] s ON i.[DistributionGroupCode]=s.[DistributionGroupCode]
												and
												i.[DistributionCode]=s.[DistributionCode]
												and
												i.[Society]=s.[Society]
												and
												i.[RevenueGroupCode]=s.[CodaCustomerCode]
												and
												i.[intervalSysStartTime] between s.[SysStartTime] and s.[SysEndTime]
)
SELECT 
	 [masterSociety][Society]
	,[masterDistributionGroupCode][DistributionGroupCode]
	,[masterDistributionCode][DistributionCode]
	--,[CalculationPeriodStatus]
	--,[CalculationPeriodStart]
	--,[CalculationPeriodEnd]
	,[masterDistributionGroupCode]

	,masterCodaCustomerCode	
	,masterRevenueGroupName	
	,masterSocietySplitPercent	
	,masterHedgedRate
	,[masterRevenueApportionmentMethodPRS]
	,[masterRevenueApportionmentMethodMCPS]
	,masterIsExcluded	
	,[MasterRevenue]
	,CalculationGroupIsCurrent	
	--Removed as Master-Working data should be transposed by App
	,[CodaCustomerCode]
	,[RevenueGroupName]
	,SocietySplitPercent	
	,IsExcluded	
	--,[EstimatedPoints]
	,[EstimatedRevenue]
	,[HedgedRevenue]
	,[HedgePercent]
	,[RevenueApportionmentMethodPRS]
	,[RevenueApportionmentMethodMCPS]

	,[RingFenceValue]
	
	--,intervalSysStartTime

      , [masterSysStartTime]
      , [masterSysEndTime]
	  	  
	,[UpdatedBy]
	,FPV.udfRemoveStringCharacters([UpdateComment])[UpdateComment]

	,[intervalSysStartTime][SysStartTime]
	,coalesce(lead([intervalSysStartTime]) over (partition by [masterDistributionGroupCode],[masterDistributionCode],[masterSociety],[masterRevenueGroupCode] order by [intervalSysStartTime]),'31 DEC 9999')[SysEndTime]
	  ,[MasterRevenueGroupIsCurrent] as [masterIsCurrent]
	  --,[CalculationGroupRevenueGroupIsCurrent]
	  ,case
		when coalesce(lead([intervalSysStartTime]) over (partition by [masterDistributionGroupCode],[masterDistributionCode],[masterSociety],[masterRevenueGroupCode] order by [intervalSysStartTime]),'31 DEC 9999')='31 DEC 9999' then 1
		else 0
	  end [IsCurrent]

FROM	CombinedStations
GO

