
CREATE view [staging].[vDistributionGroupCodeStartEnd]
as
--Created in order to provide a grouping/mapping from MDS core Distribution Data through TM1 Revenues
--through to the FPV Application Data
with cte_DGbyLP --Distribution Group by Licence Period
as
(
SELECT [Name]   as DistributionGroup
      ,isnull([LicensingPeriod], 'January to December')  as [LicensingPeriod]
      ,isnull([LicensingPeriodStart], 'January')  as [LicensingPeriodStart]
     ,DATEPART(MM,isnull([LicensingPeriodStart], 'January') + ' 1 2999') as LicensingPeriodStartInt
      ,isnull([LicensingPeriodEnd],'December') as [LicensingPeriodEnd]
	  ,DATEPART(MM,isnull([LicensingPeriodEnd], 'December') + ' 1 2999') as LicensingPeriodEndInt
	  ,case 
			when DATEPART(MM,isnull([LicensingPeriodStart], 'January') + ' 1 2999') < DATEPART(MM,isnull([LicensingPeriodEnd], 'December') + ' 1 2999') 
			then 'N' 
			else 'Y' 
		end as LicensePeriodStartPriorYearFlag

  FROM [staging].[MasterDistributionGroup]
  WHERE HectorInScope = 'Y'
)
	  select  
		cte_DGbyLP.DistributionGroup	
		,DP.Code as DistributionCode
		,cte_DGbyLP.LicensingPeriodStart as LicensingStartPeriod
		,case 
			when cte_DGbyLP.LicensePeriodStartPriorYearFlag = 'Y' 
			then year(EndDate) -1
			else year(EndDate)
		end as LicensingStartYear
		,CONVERT(datetime,CONCAT('1/',cte_DGbyLP.LicensingPeriodStart,'/',case when cte_DGbyLP.LicensePeriodStartPriorYearFlag = 'Y' then year(EndDate) -1 else year(EndDate) end)) as LicensingStartDate
		,cte_DGbyLP.LicensingPeriodEnd as LicensingEndPeriod
		,year(EndDate) as LicensingEndYear
		,dateadd(DAY,-1,dateadd(MONTH,1,CONVERT(datetime,CONCAT('1/',cte_DGbyLP.LicensingPeriodEnd,'/',year(EndDate))))) as LicensingEndDate
		--,MPS.PlanningScenario as LatestPlanningScenario
  from [staging].[MasterDistributionPeriod] DP
  cross join cte_DGbyLP 
  WHERE MainMini = 'Main' 