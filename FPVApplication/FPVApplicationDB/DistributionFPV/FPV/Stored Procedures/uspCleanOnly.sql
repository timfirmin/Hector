
CREATE proc [FPV].[uspCleanOnly]
@WorkingDistributionGroupCode varchar(20)
,@WorkingDistributionCode varchar(20)
,@WorkingSociety varchar(20)
as
begin

-- EXEC [FPV].[uspCleanOnly] @WorkingDistributionGroupCode = 'AV' ,@WorkingDistributionCode = 'D193' ,@WorkingSociety = 'PRS'

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

--clear down data
exec [admin].[uspResetCalculationGroup] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety	 
delete from [FPV].[CalculationGroup] where  DistributionGroupCode = @WorkingDistributionGroupCode and DistributionCode = @WorkingDistributionCode and  Society =@WorkingSociety	 
--reseed calc group data
--EXEC [FPV].[uspSeedCalcGroupStation] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety	 
--EXEC [FPV].[uspSeedCalcGroupRevenueGroup] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--EXEC [FPV].[uspSeedCalcGroupAudienceReach] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--EXEC [FPV].[uspSeedCalcGroupMissingMinutes] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--EXEC [FPV].[uspSeedCalcGroupMusicMinutes] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--EXEC [FPV].[uspSeedCalcGroupPublicReception] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--EXEC [FPV].[uspSeedCalcGroupRevenue] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 
--EXEC [FPV].[uspSeedCalcGroupUDC] @DistributionGroupCode = @WorkingDistributionGroupCode ,@DistributionCode = @WorkingDistributionCode, @Society =@WorkingSociety 



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
--INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data],[datarowcount])
--VALUES (@RequestID,'success','CalculationGroup Reset',1)
/************************************************************************************
END: LOG RESPONSE
************************************************************************************/
end