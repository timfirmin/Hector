CREATE proc [Test].[CleanUpTestData]
as

--delete revenue
delete [FPV].[CalculationGroupRevenue] where [DistributionGroupCode] like 'TEST%'
delete [FPV].[MasterRevenue] where [DistributionGroupCode] like 'TEST%'

--calculation group stations
delete [FPV].[CalculationGroupStation] where [DistributionGroupCode] like 'TEST%'

--master stations
delete [FPV].[MasterStation] where [DistributionGroupCode] like 'TEST%'

--calculation groups
delete [FPV].[CalculationGroup] where [DistributionGroupCode] like 'TEST%'

--distributions
delete [FPV].[Distribution] where [DistributionCode] like 'DTEST%'

--distribution groups
delete [FPV].[DistributionGroup] where [DistributionGroupCode] like 'TEST%'
GO


