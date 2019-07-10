CREATE proc [Test].[ExecuteTest]
@TestID varchar(100),
@ParamString varchar(1000)=null
as
declare @requestString nvarchar(4000) = ''
declare @requestID int

;with RequestString as (
	select case @TestID
				when 'RequestInvalidJSON' then [InvalidJSON]
				when 'RequestInvalidRequest' then [InvalidRequest]
				when 'GetDistributionGroups_All' then [GetDistributionGroups_All]
				when 'GetDistributionGroups_TestOnly' then [GetDistributionGroups_TestOnly]
				when 'GetDistributionGroups_xxxxOnly' then [GetDistributionGroups_xxxxOnly]
				when 'GetDistributionGroups_DisabledOnly' then [GetDistributionGroups_DisabledOnly]
				when 'GetDistributionGroups_EnabledOnly' then [GetDistributionGroups_EnabledOnly]	
				when 'GetDistributionGroups_TestAndDisabled' then [GetDistributionGroups_TestAndDisabled]	
				when 'GetDistributionGroups_TestAndEnabled' then [GetDistributionGroups_TestAndEnabled]
				when 'GetSocieties_All' then [GetSocieties_All]
				when 'GetSocieties_PRSOnly' then [GetSocieties_PRSOnly]
				when 'GetSocieties_EnabledOnly' then [GetSocieties_EnabledOnly]
				when 'GetSocieties_DisabledOnly' then [GetSocieties_DisabledOnly]
				when 'GetDistributions_All' then [GetDistributions_All]
				when 'GetDistributions_TestOnly' then [GetDistributions_TestOnly]
				when 'GetCalculationGroups_All' then [GetCalculationGroups_All]
				when 'GetCalculationGroups_TestOnly' then [GetCalculationGroups_TestOnly]
				when 'GetStations_TEST_DTEST_MCPS_Current' then [GetStations_TEST_DTEST_MCPS_Current]
				when 'GetStations_TEST_DTEST_PRS_Current' then [GetStations_TEST_DTEST_PRS_Current]
				when 'GetStations_TEST_DTEST_PRS_Historical' then [GetStations_TEST_DTEST_PRS_Historical]
				when 'GetConfig_ALL_Current' then [GetConfig_ALL_Current]
				when 'GetConfig_ALL_Historical' then [GetConfig_ALL_Historical]
				when 'GetConfig_APP_Current' then [GetConfig_APP_Current]
				when 'GetConfig_APP_Historical' then [GetConfig_APP_Historical]
				when 'PutStations_InitialSeeding' then [PutStations_InitialSeeding]
				when 'PutStations_UpdateNoDelete' then [PutStations_UpdateNoDelete]
				when 'PutStations_NoUpdateNoDelete' then [PutStations_NoUpdateNoDelete]
				when 'PutStations_UpdateWithDelete' then [PutStations_UpdateWithDelete]
				when 'PutStations_DeleteAllFromCalculationGroup' then [PutStations_DeleteAllFromCalculationGroup]
				when 'GetRevenue_All' then [GetRevenue_All]
				when 'PutRevenue_TestStationsNoDelete' then [PutRevenue_TestStationsNoDelete]
			end [RequestString]
	from [Test].[JSONRequestStrings]
)
select @requestString = [RequestString] from RequestString
exec @requestID = [FPV_Public].[uspApplicationRequestHandler] @requestString
GO

