



CREATE view [staging].[vStation]
as

--
--=============================================
-- TJF 2019APR16 Defaults Removed 
-- TJF 2019APR16 Added MDS Default Values using FPV.udfGetDGValue for DefaultPRAdminRate and DefaultStationAdminRate
-- =============================================
select	s.[Code][StationID]
		,dg.DistributionGroupCode
		,FPV.udfRemoveStringCharacters(left(s.[Name],100))[StationName]
  		,case [RightType] 
			when 'Performing' then 'PRS'
			when 'Mechanical' then 'MCPS'
			else 'Both'
		end as RightTypeCompany
		
		
		
		--Added 2018 SEP 04
		,case when s.AudioPolicy = 'U' then null else s.AudioPolicy end as AudioPolicyMain
		,case when s.AudioPolicyCommercial = 'U' then null else s.AudioPolicyCommercial end as AudioPolicyCommercial
		--,isnull(s.CommercialSampleDays,0)[CommercialSampleDays]
		--,isnull(s.NonCommercialSampleDays,0)[NonCommercialSampleDays]
		--For AV make Sample Days Match Commercial vs Non-Commercial
		,case when dg.DistributionGroupCode = 'AV' and isnull(s.CommercialSampleDays,0) <> isnull(s.NonCommercialSampleDays,0) then 
			case when isnull(s.CommercialSampleDays,0) > isnull(s.NonCommercialSampleDays,0) then isnull(s.CommercialSampleDays,0) else isnull(s.NonCommercialSampleDays,0) end
		else
			isnull(s.CommercialSampleDays,0)
		end  as [CommercialSampleDays]

		,case when dg.DistributionGroupCode = 'AV' and isnull(s.CommercialSampleDays,0) <> isnull(s.NonCommercialSampleDays,0) then 
			case when isnull(s.CommercialSampleDays,0) > isnull(s.NonCommercialSampleDays,0) then isnull(s.CommercialSampleDays,0) else isnull(s.NonCommercialSampleDays,0) end
		else
			isnull(s.NonCommercialSampleDays,0)
		end  as [NonCommercialSampleDays]

		,isnull(s.TotalSampleDays,0)[TotalSampleDays]

		--,isnull(s.[Diversity],'No')[Diversity]
		--,isnull(s.[LowRevenue],'No')[LowRevenue]
		,s.[LicencedStatus][StationStatus]
		,s.[ExcludeFromFPV][ExcludeFromFPV]
		--Add MDS Default Value
		,isnull(s.[StationAdminRate],FPV.udfGetDGValue('DefaultStationAdminRate', dg.DistributionGroupCode))[GroupAdminRate]
		,s.[PRSHedgedRate][HedgePercent]
		,s.[MCPSHedgedRate][HedgePercentMCPS]
		,isnull(s.[PublicReceptionAdminRate],FPV.udfGetDGValue('DefaultPRAdminRate', dg.DistributionGroupCode))[PRAdminRate]
		,case when isnull(s.[LicencedStatus],'U') = 'Ceased' then 1 else 0 end [IsExcluded]
		,s.CodaCustomerCode as [CodaCustomerCode]
		--,isnull(nullif(s.CashOutCode,'E9999'),'Unknown')[CashOutCode]
		,isnull(s.MinimumFee, 0)[MinimumFee]
		,[RegionalParentStationFlag] as [RegionalParentStationFlag]
		,[RegionalParentStationId] as [RegionalParentStationId]
		,[RegionalWeightingPRS]
		,[RegionalWeightingMCPS]

from	[staging].[MasterStation] s
 
join [FPV].[DistributionGroup] dg on s.DistributionGroup = dg.DistributionGroupCode

where dg.Enabled = 1 and   (isnull(s.[ExcludeFromFPV],'Yes') = 'No')
GO

