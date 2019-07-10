CREATE view [FPV].[vCalculationGroupRevenueGroupStatusSummary]
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
from (select [DistributionGroupCode],[DistributionCode],[Society],[RevenueGroupCode],[FPVStatus],[SysStartTime] 
from [FPV].[CalculationGroupRevenueGroup]) d
pivot (count([RevenueGroupCode]) for [FPVStatus] in ([In Progress],[Pending Approval],[Approved],[Rejected])) p
union
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[SysStartTime]
		,[In Progress]
		,[Pending Approval]
		,[Approved]
		,[Rejected]
from (select [DistributionGroupCode],[DistributionCode],[Society],[RevenueGroupCode],[FPVStatus],[SysStartTime] 
from [FPV].[CalculationGroupRevenueGroupHistory]) d
pivot (count([RevenueGroupCode]) for [FPVStatus] in ([In Progress],[Pending Approval],[Approved],[Rejected])) p
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
GO

