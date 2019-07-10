 


CREATE view [FPV].[vMasterPublicReception]
as
select 
		[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[TotalPRAllocation]
		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,[SysEndTime]
		,1 [IsCurrent]
from [FPV].[MasterPublicReception]

union
select 

		[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[TotalPRAllocation]
		,[UpdatedBy]
		,[UpdateComment]
		,[SysStartTime]
		,dateadd(ms,-1,[SysEndTime])[SysEndTime]
		,0 [IsCurrent]
from [FPV].[MasterPublicReceptionHistory]