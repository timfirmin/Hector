
CREATE VIEW [Transform].[v_SampleDays]
AS

with cte_ValidMonths as
	(
	SELECT DISTINCT [StationId]
	,isnull(ms.DistributionGroup,'Unknown') as DistributionGroup
	,year(getdate()) as DistributionYear
	--if we know its is ILR then we can offset with Oct-Sept Licence Year
	,case when ms.DistributionGroup = 'ILR' then year(getdate()) * 100 - 90 else year(getdate()) * 100 + 1 end as StartMonthKey
	,case when ms.DistributionGroup = 'ILR' then year(getdate()) * 100 + 9 else year(getdate()) * 100 + 12 end as EndMonthKey
	,isnull(ms.[AudioPolicy],'Unknown') as MDSAudioPolicyMain
	,isnull(ms.[AudioPolicyCommercial],'Unknown') as MDSAudioPolicyCommercial
	,ms.[CommercialSampleDays] as MDSCommercialSampleDays
	,ms.[NonCommercialSampleDays] as MDSNonCommercialSampleDays
	  FROM [Clean].[SampleDays] sd
	  LEFT JOIN [Staging].[MDS_MasterStation] ms on sd.StationId  = ms.Code
	  WHERE [RejectRow_YN] = 'N' --and isnull(DistributionGroup,'~Not Supplied') <> '~Not Supplied'
	),
	cte_SampleDaysAggregate
	as
	(
	SELECT sd.[StationId]
		  ,cte.DistributionYear
		  ,cte.DistributionGroup
		  ,sd.[BroadcasterName]
		  ,sum(case when sd.[UsedForPurpose] = 'Main' then sd.[SampleDays] else 0 end) as MainSampleDays
		  ,sum(case when sd.[UsedForPurpose] = 'Commercial' then sd.[SampleDays] else 0 end) as CommercialSampleDays
		  ,cte.MDSAudioPolicyMain	
		  ,cte.MDSAudioPolicyCommercial	
		  ,cte.MDSCommercialSampleDays	
		  ,cte.MDSNonCommercialSampleDays

	  FROM [Clean].[SampleDays] sd
	  JOIN cte_ValidMonths cte 
	  on sd.StationId  = cte.[StationId]
	  and sd.[DateMonthKey] between cte.StartMonthKey   and cte.EndMonthKey
	  GROUP BY
		   sd.[StationId]
		  ,sd.[BroadcasterName]
  		  ,cte.DistributionYear
		  ,cte.DistributionGroup
		  ,cte.MDSAudioPolicyMain	
		  ,cte.MDSAudioPolicyCommercial	
		  ,cte.MDSCommercialSampleDays	
		  ,cte.MDSNonCommercialSampleDays
	),
	cte_Distributions
	as
	(
	select year(getdate()) as YearJoin, 'D' + right(cast(year(getdate()) as varchar(4)),2) + '1' as DistributionCode  
	--union select year(getdate()) as YearJoin, 'D' + right(cast(year(getdate()) as varchar(4)),2) + '2' as DistributionCode 
	--union select year(getdate()) as YearJoin, 'D' + right(cast(year(getdate()) as varchar(4)),2) + '3' as DistributionCode 
	--union select year(getdate()) as YearJoin, 'D' + right(cast(year(getdate()) as varchar(4)),2) + '4' as DistributionCode  
	)
	select 
		StationId	
		,DistributionCode
		,DistributionGroup	
		,max(BroadcasterName) as BroadcasterName
		,max(MainSampleDays) as MainSampleDays
		,max(MDSNonCommercialSampleDays) as MDSMainSampleDays
		,max(CommercialSampleDays) as CommercialSampleDays
		,max(MDSCommercialSampleDays) as MDSCommercialSampleDays
		,max(case when MainSampleDays = 365 then 'Census' else (case when MainSampleDays = 0 then 'Not Applicable' else 'Sampled' end) end) as AudioPolicyMain
		,max(MDSAudioPolicyMain) as MDSAudioPolicyMain
		,max(case when CommercialSampleDays = 365 then 'Census' else (case when CommercialSampleDays = 0 then 'Not Applicable' else 'Sampled' end) end) as AudioPolicyCommercial
		,max(MDSAudioPolicyCommercial) as MDSAudioPolicyCommercial
		,max(case when MainSampleDays > CommercialSampleDays then  MainSampleDays else CommercialSampleDays end) as TotalSampleDays

		,max(case when MainSampleDays <> MDSNonCommercialSampleDays 
			or CommercialSampleDays <> MDSCommercialSampleDays
			or (case when MainSampleDays = 365 then 'Census' else (case when MainSampleDays = 0 then 'Not Applicable' else 'Sampled' end) end) <> MDSAudioPolicyMain
			or (case when CommercialSampleDays = 365 then 'Census' else (case when CommercialSampleDays = 0 then 'Not Applicable' else 'Sampled' end) end) <> MDSAudioPolicyCommercial
		then 'Y' else 'N' end) as DeltaFlag

	 from 
		cte_SampleDaysAggregate join cte_Distributions on cte_SampleDaysAggregate.DistributionYear  = cte_Distributions.YearJoin
	group by
		 StationId	
		,DistributionCode
		,DistributionGroup
