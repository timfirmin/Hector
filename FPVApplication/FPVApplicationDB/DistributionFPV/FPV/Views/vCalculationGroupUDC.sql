CREATE view [FPV].[vCalculationGroupUDC]
as
select 
	  CAST(HashBytes('SHA1',[DistributionGroupCode] + [DistributionCode] + [Society] + [StationID] + [UsedForPurposeDesc] + [TimeBand]) AS bigint) CalculationGroupUDCKey
	  ,[DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[UDCCode]
      ,[UDCDescription]
      ,[UsedForPurposeDesc]
      ,[TimeBand]
      ,[PeakSplitPercent]

		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,1 [IsCurrent]

from [FPV].[CalculationGroupUDC]
union
select 
	  CAST(HashBytes('SHA1',[DistributionGroupCode] + [DistributionCode] + [Society] + [StationID] + [UsedForPurposeDesc] + [TimeBand]) AS bigint) CalculationGroupUDCKey
	  ,[DistributionGroupCode]
      ,[DistributionCode]
      ,[Society]
      ,[StationID]
      ,[UDCCode]
      ,[UDCDescription]
      ,[UsedForPurposeDesc]
      ,[TimeBand]
      ,[PeakSplitPercent]

		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,dateadd(ms,-1,[SysEndTime])[SysEndTime]
		,0 [IsCurrent]
from [FPV].[CalculationGroupUDCHistory]
GO

