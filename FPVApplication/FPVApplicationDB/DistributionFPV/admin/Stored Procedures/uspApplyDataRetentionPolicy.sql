CREATE proc [admin].[uspApplyDataRetentionPolicy]
as
/*****************************************************
ApplicationRequest table
*****************************************************/
delete r
from [FPV].[ApplicationRequest] r,[FPV].[ReferenceData] d
where d.[RefDataCategory]='DataRetention' and d.[RefDataGroup]='ApplicationRequest'
and [RequestSysTime] < dateadd(d,-cast(d.[RefDataValue] as int),sysutcdatetime())

/*****************************************************
ApplicationResponse table
*****************************************************/
delete r
from [FPV].[ApplicationResponse] r,[FPV].[ReferenceData] d
where d.[RefDataCategory]='DataRetention' and d.[RefDataGroup]='ApplicationResponse'
and [SysResponseTime] < dateadd(d,-cast(d.[RefDataValue] as int),sysutcdatetime())