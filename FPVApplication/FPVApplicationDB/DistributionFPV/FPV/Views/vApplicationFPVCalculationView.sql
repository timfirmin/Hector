﻿
CREATE view [FPV].[vApplicationFPVCalculationView]
as
with Calcs as (
select	e.[DistributionGroupCode]
		,e.[DistributionCode]
		,e.[Society]
		,c.[StationID]
		,e.[SysDateTime][EventSysDateTime]
		,e.[Comment][EventComment]
		,d.[CalculationName][CalculationDef]
		,c.[CalculationValue]
		,c.[CalculationStatus]
		,c.[SysCalcTime]
		,c.[UpdateComments]
		,c.[UpdatedBy]
		,c.[SysStartTime]
		,c.[SysEndTime]
		,row_number() over (partition by e.[DistributionGroupCode],e.[DistributionCode],e.[Society],c.[StationID],c.[FPVCalculationDefID] order by  [SysStartTime] desc)[Recency]
from	[FPV].[FPVCalculationEvent] e
join	[FPV].[FPVCalculation] c on c.[FPVCalculationEventID]=e.[FPVCalculationEventID]
join	[FPV].[FPVCalculationDef] d on d.[FPVCalculationDefID]=c.[FPVCalculationDefID]
)
select	[DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[EventSysDateTime]
		,[EventComment]
		,[CalculationDef]
		,[CalculationValue]
		,[CalculationStatus]
		,[SysCalcTime]
		,[UpdateComments]
		,[UpdatedBy]
		,[SysStartTime]
		,[SysEndTime]
		,case when [Recency]=1 then [Recency] else 0 end [IsCurrent]
from Calcs