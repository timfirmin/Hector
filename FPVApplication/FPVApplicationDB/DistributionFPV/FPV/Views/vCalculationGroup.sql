﻿

CREATE VIEW [FPV].[vCalculationGroup]
AS
SELECT [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[CalculationGroupStatus]
      ,[CalculationPeriodStart]
      ,[CalculationPeriodEnd]
      ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,dateadd(millisecond,-1,[SysEndTime])[SysEndTime]
	  , 1 [IsCurrent]
  FROM [FPV].[CalculationGroup]
UNION
SELECT [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[CalculationGroupStatus]
      ,[CalculationPeriodStart]
      ,[CalculationPeriodEnd]
      ,[UpdatedBy]
      ,[UpdateComment]
      ,[SysStartTime]
      ,dateadd(millisecond,-1,[SysEndTime])[SysEndTime]
	  , 0 [IsCurrent]
FROM [FPV].[CalculationGroupHistory]