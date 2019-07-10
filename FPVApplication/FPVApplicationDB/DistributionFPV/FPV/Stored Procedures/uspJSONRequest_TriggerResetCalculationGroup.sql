CREATE proc [FPV].[uspJSONRequest_TriggerResetCalculationGroup]
@RequestID int
as
begin
declare @DistributionGroupCode varchar(20)
declare @DistributionCode varchar(20)
declare @Society varchar(20)

/************************************************************************************
START:DISABLE SYSTEM VERSIONING
************************************************************************************/
alter table [FPV].[FPVCalculation] set (system_versioning=off)
alter table [FPV].[CalculationGroupMissingMinutes] set (system_versioning=off)
alter table [FPV].[CalculationGroupMusicMinutes] set (system_versioning=off)
alter table [FPV].[CalculationGroupPublicReception] set (system_versioning=off)
alter table [FPV].[CalculationGroupRevenue] set (system_versioning=off)
alter table [FPV].[CalculationGroupStation] set (system_versioning=off)
alter table [FPV].[MasterMissingMinutes] set (system_versioning=off)
alter table [FPV].[MasterMusicMinutes] set (system_versioning=off)
alter table [FPV].[MasterPublicReception] set (system_versioning=off)
alter table [FPV].[MasterRevenue] set (system_versioning=off)
alter table [FPV].[CalculationGroupRevenueGroup] set (system_versioning=off)
alter table [FPV].[RevenueGroup] set (system_versioning=off)
alter table [FPV].[CalculationGroupUDC] set (system_versioning=off)
alter table [FPV].[MasterUDC] set (system_versioning=off)
alter table [FPV].[MasterAudienceReach] set (system_versioning=off)
alter table [FPV].[CalculationGroupAudienceReach] set (system_versioning=off)
/************************************************************************************
END:DISABLE SYSTEM VERSIONING
************************************************************************************/

/************************************************************************************
START: DELETE DATA
************************************************************************************/
select	@DistributionGroupCode=DistributionGroupCode
		,@DistributionCode=DistributionCode
		,@Society=Society
from FPV.vRequestFilters
where RequestID=@RequestID

exec [admin].[uspResetCalculationGroup] @DistributionGroupCode,@DistributionCode,@Society
/************************************************************************************
END: DELETE DATA
************************************************************************************/

/************************************************************************************
START: ENABLE SYSTEM VERSIONING
************************************************************************************/
alter table [FPV].[FPVCalculation] set (system_versioning=on (HISTORY_TABLE = [FPV].[FPVCalculationHistory]))
alter table [FPV].[CalculationGroupStation] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupStationHistory]))
alter table [FPV].[CalculationGroupRevenue] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupRevenueHistory]))
alter table [FPV].[CalculationGroupPublicReception] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupPublicReceptionHistory]))
alter table [FPV].[CalculationGroupMusicMinutes] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupMusicMinutesHistory]))
alter table [FPV].[CalculationGroupMissingMinutes] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupMissingMinutesHistory]) )
alter table [FPV].[MasterMissingMinutes] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterMissingMinutesHistory]) )
alter table [FPV].[MasterMusicMinutes] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterMusicMinutesHistory]) )
alter table [FPV].[MasterPublicReception] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterPublicReceptionHistory]) )
alter table [FPV].[MasterRevenue] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterRevenueHistory]) )
alter table [FPV].[CalculationGroupRevenueGroup] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupRevenueGroupHistory]) )
alter table [FPV].[RevenueGroup] set (system_versioning=on (HISTORY_TABLE = [FPV].[RevenueGroupHistory]) )
alter table [FPV].[CalculationGroupUDC] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupUDCHistory]) )
alter table [FPV].[MasterUDC] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterUDCHistory]) )
alter table [FPV].[MasterAudienceReach] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterAudienceReachHistory]) )
alter table [FPV].[CalculationGroupAudienceReach] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupAudienceReachHistory]) )
/************************************************************************************
END: ENABLE SYSTEM VERSIONING
************************************************************************************/


/************************************************************************************
START: LOG RESPONSE
************************************************************************************/
INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
VALUES (@RequestID,'success','CalculationGroup Reset',1)
/************************************************************************************
END: LOG RESPONSE
************************************************************************************/
end
GO

