﻿

CREATE view [FPV].[vCalculationGroupMissingMinutes]
as
select [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[MissingMinutes]
      ,[CarryForwardsMinutes]
      ,[TotalMinutesToHold]
      ,[MissingRevenue]
      ,[CarryForwardsRevenue]
      ,[TotalRevenueToHold]
		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,1 [IsCurrent]
from [FPV].[CalculationGroupMissingMinutes]
union
select [DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[MissingMinutes]
      ,[CarryForwardsMinutes]
      ,[TotalMinutesToHold]
      ,[MissingRevenue]
      ,[CarryForwardsRevenue]
      ,[TotalRevenueToHold]
		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,dateadd(ms,-1,[SysEndTime])[SysEndTime]
		,0 [IsCurrent]
from [FPV].[CalculationGroupMissingMinutesHistory]