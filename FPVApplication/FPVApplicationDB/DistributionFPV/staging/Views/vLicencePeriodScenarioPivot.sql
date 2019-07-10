CREATE view   staging.vLicencePeriodScenarioPivot
as
/** [LicencePeriod01] **/
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 0, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 0, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 0, LicensingStartDate)),3) as PlanningPeriod
	  ,1 as PlanningPeriodInt
      ,[LicencePeriod01] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod02] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 1, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 1, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 1, LicensingStartDate)),3) as PlanningPeriod
	  ,2 as PlanningPeriodInt
      ,[LicencePeriod02] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
  /** [LicencePeriod03] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 2, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 2, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 2, LicensingStartDate)),3) as PlanningPeriod
	  ,3 as PlanningPeriodInt
      ,[LicencePeriod03] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod04] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 3, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 3, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 3, LicensingStartDate)),3) as PlanningPeriod
	  ,4 as PlanningPeriodInt
      ,[LicencePeriod04] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod05] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 4, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 4, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 4, LicensingStartDate)),3) as PlanningPeriod
	  ,5 as PlanningPeriodInt
      ,[LicencePeriod05] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod06] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 5, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 5, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 5, LicensingStartDate)),3) as PlanningPeriod
	  ,6 as PlanningPeriodInt
      ,[LicencePeriod06] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod07] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 6, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 6, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 6, LicensingStartDate)),3) as PlanningPeriod
	  ,7 as PlanningPeriodInt
      ,[LicencePeriod07] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod08] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 7, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 7, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 7, LicensingStartDate)),3) as PlanningPeriod
	  ,8 as PlanningPeriodInt
      ,[LicencePeriod08] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod09] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 8, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 8, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 8, LicensingStartDate)),3) as PlanningPeriod
	  ,9 as PlanningPeriodInt
      ,[LicencePeriod09] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod10] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 9, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 9, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 9, LicensingStartDate)),3) as PlanningPeriod
	  ,10 as PlanningPeriodInt
      ,[LicencePeriod10] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod11] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 10, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 10, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 10, LicensingStartDate)),3) as PlanningPeriod
	  ,11 as PlanningPeriodInt
      ,[LicencePeriod11] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode
/** [LicencePeriod12] **/
UNION
SELECT lps.[Society]
      ,lps.[DistributionGroup]
      ,lps.[DistributionCode]
	  ,dateadd(MONTH, 11, LicensingStartDate) as MonthStartDate
	  ,year(dateadd(MONTH, 11, LicensingStartDate)) as PlanningYear
	  ,left(DATENAME(month, dateadd(MONTH, 11, LicensingStartDate)),3) as PlanningPeriod
	  ,12 as PlanningPeriodInt
      ,[LicencePeriod12] as PlanningScenario
  FROM [staging].[LicencePeriodScenarios] lps
  JOIN [staging].[vDistributionGroupCodeStartEnd] dgcse 
  on lps.[DistributionGroup] = dgcse.DistributionGroup and lps.[DistributionCode] = dgcse.DistributionCode