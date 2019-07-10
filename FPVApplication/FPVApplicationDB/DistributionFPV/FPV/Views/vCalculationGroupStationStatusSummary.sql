
CREATE view [FPV].[vCalculationGroupStationStatusSummary]
as
with status_summary as (
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[SysStartTime]
		,[In Progress]
		,[Pending Approval]
		,[Approved]
		,[Rejected]
from (select [DistributionGroupCode],[DistributionCode],[Society],[StationID],[FPVStatus],[SysStartTime] from [FPV].[CalculationGroupStation]) d
pivot (count([StationID]) for [FPVStatus] in ([In Progress],[Pending Approval],[Approved],[Rejected])) p
union
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[SysStartTime]
		,[In Progress]
		,[Pending Approval]
		,[Approved]
		,[Rejected]
from (select [DistributionGroupCode],[DistributionCode],[Society],[StationID],[FPVStatus],[SysStartTime] from [FPV].[CalculationGroupStationHistory]) d
pivot (count([StationID]) for [FPVStatus] in ([In Progress],[Pending Approval],[Approved],[Rejected])) p
)
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[SysStartTime]
		,[In Progress]
		,[Pending Approval]
		,[Approved]
		,[Rejected]
from status_summary