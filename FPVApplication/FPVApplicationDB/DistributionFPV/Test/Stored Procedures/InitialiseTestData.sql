CREATE proc [Test].[InitialiseTestData]
as
declare @startdate datetime
declare @enddate datetime

--remove any previous test data
exec [Test].[CleanUpTestData]

--distribution groups
if not exists(select [DistributionGroupCode] from [FPV].[DistributionGroup] where [DistributionGroupCode]='TEST')
begin
	insert [FPV].[DistributionGroup]([DistributionGroupCode],[Comment])
	values ('TEST',cast(getdate() as varchar(255)))
end

--distributions
if not exists (select [DistributionCode] from [FPV].[Distribution] where [DistributionCode]='DTEST')
begin
	select @startdate = cast('01 ' + datename(M,getdate()) + ' ' + datename(YYYY,getdate()) as datetime)
	select @enddate = dateadd(s,-1,dateadd(M,3,@startdate))
	insert [FPV].[Distribution]([DistributionCode],[DistributionStartDate],[DistributionEndDate])
	values ('DTEST',@startdate,@enddate)
end

--calculation groups
;with CalculationGroupTestData as (
select [DistributionGroupCode],[DistributionCode],[Society],[CalculationGroupStatus],[CalculationPeriodStart],[CalculationPeriodEnd],[UpdatedBy],[UpdateComment]
from (VALUES('TEST','DTEST','PRS','IN PROGRESS','AUTOMATED TEST','')
			,('TEST','DTEST','MCPS','IN PROGRESS','AUTOMATED TEST','')) s ([DistributionGroupCode],[DistributionCode],[Society],[CalculationGroupStatus],[UpdatedBy],[UpdateComment])
CROSS APPLY (SELECT [DistributionStartDate],[DistributionEndDate] FROM [FPV].[Distribution] WHERE [DistributionCode]=s.[DistributionCode]) d ([CalculationPeriodStart],[CalculationPeriodEnd])
)
merge [FPV].[CalculationGroup] t
using CalculationGroupTestData s
on t.[DistributionGroupCode]=s.[DistributionGroupCode]
	and t.[DistributionCode]=s.[DistributionCode]
	and t.[Society]=s.[Society]

	when not matched then
	insert ([DistributionGroupCode],[DistributionCode],[Society],[CalculationGroupStatus],[CalculationPeriodStart],[CalculationPeriodEnd],[UpdatedBy],[UpdateComment])
	values (s.[DistributionGroupCode],s.[DistributionCode],s.[Society],s.[CalculationGroupStatus],s.[CalculationPeriodStart],s.[CalculationPeriodEnd],s.[UpdatedBy],s.[UpdateComment])

	when matched then
	update	set [CalculationGroupStatus]=s.[CalculationGroupStatus]
				,[CalculationPeriodStart]=s.[CalculationPeriodStart]
				,[CalculationPeriodEnd]=s.[CalculationPeriodEnd];
																			
;with MasterStationTestData as (
	select	[StationID]
			,[DistributionGroupCode]
			,[StationName]
			,[StationCategory]
			,[StationStatus]
			,[GroupAdminRate]
			,[HedgePercent]
			,[PRAdminRate]
			,[IsExcluded]
			--,[CensusOrSampled]
			--Change 2018SEP05 --'Census','Census',365,4,365,
			,[AudioPolicyMain]   
			,[AudioPolicyCommercial]
			,[CommercialSampleDays]
			,[NonCommercialSampleDays]
			,[TotalSampleDays]

			,[Diversity]
			,[LowRevenue]




	from (values ('TIR210G',	'TEST',	'SMOOTH READING',	'Radio',	'Census','Census',365,4,365,	'NO',	'SUB 5K',	'Licenced',	0.15,	NULL,	0.20,	0)
				,('TIR2CRG',	'TEST',	'SMOOTH RADIO (BOURNEMOUTH)',	'Radio',	'Census','Census',365,4,365,	'NO',	'SUB 5K',	'Licenced',	0.15,	NULL,	0.20,	0)
				,('TIRA1FM',	'TEST',  'STAR RADIO (103.2 FM/DARLINGTON)',	'Radio',	'Census','Census',365,4,365,	'NO',	'SUB 5K',	'Licenced',	0.15,	NULL,	0.20,	0)) s (	[StationID]
																																									,[DistributionGroupCode]
																																									,[StationName]
																																									,[StationCategory]
																																									,[AudioPolicyMain]   
																																									,[AudioPolicyCommercial]
																																									,[CommercialSampleDays]
																																									,[NonCommercialSampleDays]
																																									,[TotalSampleDays]
																																									,[Diversity]
																																									,[LowRevenue]
																																									,[StationStatus]
																																									,[GroupAdminRate]
																																									,[HedgePercent]
																																									,[PRAdminRate]
																																									,[IsExcluded])
)
merge [FPV].[MasterStation] t
using MasterStationTestData s
on t.[StationID]=s.[StationID] and t.[DistributionGroupCode]=s.[DistributionGroupCode]

when not matched then
insert ([StationID],[DistributionGroupCode],[StationName],[StationCategory],[StationStatus],[GroupAdminRate],[HedgePercent],[PRAdminRate],[IsExcluded],[AudioPolicyMain] ,[AudioPolicyCommercial] ,[CommercialSampleDays] ,[NonCommercialSampleDays] ,[TotalSampleDays],[Diversity],[LowRevenue])
values (s.[StationID],s.[DistributionGroupCode],s.[StationName],s.[StationCategory],s.[StationStatus],s.[GroupAdminRate],s.[HedgePercent],s.[PRAdminRate],s.[IsExcluded],s.[AudioPolicyMain] ,s.[AudioPolicyCommercial] ,s.[CommercialSampleDays] ,s.[NonCommercialSampleDays] ,s.[TotalSampleDays],s.[Diversity],s.[LowRevenue]);

;with MasterRevenueTestData as (
select [DistributionGroupCode]
		,[DistributionCode]
		,[Society]
		,[StationID]
		,[CodaCustomerCode]
		,[Revenue]
		,[UpdatedBy]
		,[UpdateComment]
from (values('TEST','DTEST','MCPS','TIR210G','CGMAIN',10000.00,'automated test','test data intialisation')
				,('TEST','DTEST','MCPS','TIR2CRG','CGMAIN',10000.00,'automated test','test data intialisation')
				,('TEST','DTEST','MCPS','TIRA1FM','CGMAIN',10000.00,'automated test','test data intialisation')
				,('TEST','DTEST','PRS','TIR210G','CGMAIN',10000.00,'automated test','test data intialisation')
				,('TEST','DTEST','PRS','TIR2CRG','CGMAIN',10000.00,'automated test','test data intialisation')
				,('TEST','DTEST','PRS','TIRA1FM','CGMAIN',10000.00,'automated test','test data intialisation')) s ([DistributionGroupCode]
																												,[DistributionCode]
																												,[Society]
																												,[StationID]
																												,[CodaCustomerCode]
																												,[Revenue]
																												,[UpdatedBy]
																												,[UpdateComment])
)
merge [FPV].[MasterRevenue] t
using MasterRevenueTestData s
on t.[DistributionGroupCode]=s.[DistributionGroupCode]
and t.[DistributionCode]=s.[DistributionCode]
and t.[Society]=s.[Society]
and t.[CodaCustomerCode]=s.[CodaCustomerCode]

when not matched then 
insert ([DistributionGroupCode],[DistributionCode],[Society],[CodaCustomerCode],[Revenue],[UpdatedBy],[UpdateComment])
values (s.[DistributionGroupCode],s.[DistributionCode],s.[Society],s.[CodaCustomerCode],s.[Revenue],s.[UpdatedBy],s.[UpdateComment]);
GO

