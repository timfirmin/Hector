
CREATE proc [admin].[uspResetCalculationGroup]
@DistributionGroupCode varchar(20),
@DistributionCode varchar(20),
@Society varchar(20)
as
begin

delete [FPV].[CalculationGroupRevenueGroup] where [DistributionGroupCode]=@DistributionGroupCode
													and	[DistributionCode]=@DistributionCode
													and [Society]=@Society

delete [FPV].[CalculationGroupRevenueGroupHistory] where [DistributionGroupCode]=@DistributionGroupCode
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

delete [FPV].[CalculationGroupAudienceReach] where [DistributionGroupCode]=@DistributionGroupCode
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

delete [FPV].[MasterAudienceReachHistory] where [DistributionGroupCode]=@DistributionGroupCode
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

delete [FPV].RevenueGroupHistory where [DistributionGroupCode]=@DistributionGroupCode

end
GO

