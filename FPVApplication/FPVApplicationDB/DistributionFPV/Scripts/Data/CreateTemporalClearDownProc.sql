

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
alter table [FPV].[CalculationGroupLicenceGroup] set (system_versioning=off)
alter table [FPV].[LicenceGroup] set (system_versioning=off)
alter table [FPV].[CalculationGroupUDC] set (system_versioning=off)
alter table [FPV].[MasterUDC] set (system_versioning=off)
alter table [FPV].[MasterAudienceReach] set (system_versioning=off)
alter table [FPV].[CalculationGroupAudienceReach] set (system_versioning=off);

create proc [admin].[uspResetCalculationGroup]
@DistributionGroupCode varchar(20),
@DistributionCode varchar(20),
@Society varchar(20)
as
begin

delete [FPV].[CalculationGroupLicenceGroup] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupLicenceGroupHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[FPVCalculationHistory] where [FPVCalculationEventID] in (select [FPVCalculationEventID] 
																		from [FPV].[FPVCalculationEvent] 																	
																		where [DistributionGroupCode]=@DistributionGroupCode
																		and	[DistributionCode]=@DistributionCode
																		and [Society]=@Society
																		)

delete [FPV].[FPVCalculation] where [FPVCalculationEventID] in (select [FPVCalculationEventID] 
																		from [FPV].[FPVCalculationEvent] 																	
																		where [DistributionGroupCode]=@DistributionGroupCode
																		and	[DistributionCode]=@DistributionCode
																		and [Society]=@Society)

delete [FPV].[FPVCalculationEvent] where [DistributionGroupCode]=@DistributionGroupCode
									and	[DistributionCode]=@DistributionCode
									and [Society]=@Society

delete [FPV].[CalculationGroupMissingMinutesHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupMissingMinutes] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupMusicMinutesHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupMusicMinutes] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupPublicReceptionHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupPublicReception] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupRevenueHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupRevenue] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupStationHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupStation] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupMissingMinutesHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupUDC] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupUDCHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

--Remove Temporal Master History
delete [FPV].[MasterMissingMinutesHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[MasterMusicMinutesHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[MasterPublicReceptionHistory] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

--delete [FPV].[MasterUDCHistory] where [DistributionGroupCode]=@DistributionGroupCode
--													and	[DistributionCode]=@DistributionCode
--													and [Society]=@Society

delete [FPV].[MasterRevenueHistory] where [DistributionGroupCode]=@DistributionGroupCode
and	[DistributionCode]=@DistributionCode
and [Society]=@Society

delete [FPV].LicenceGroupHistory where [DistributionGroupCode]=@DistributionGroupCode

end

GO

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
alter table [FPV].[CalculationGroupLicenceGroup] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupLicenceGroupHistory]) )
alter table [FPV].[LicenceGroup] set (system_versioning=on (HISTORY_TABLE = [FPV].[LicenceGroupHistory]) )
alter table [FPV].[CalculationGroupUDC] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupUDCHistory]) )
alter table [FPV].[MasterUDC] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterUDCHistory]) )
alter table [FPV].[MasterAudienceReach] set (system_versioning=on (HISTORY_TABLE = [FPV].[MasterAudienceReachHistory]) )
alter table [FPV].[CalculationGroupAudienceReach] set (system_versioning=on (HISTORY_TABLE = [FPV].[CalculationGroupAudienceReachHistory]) )
