
CREATE VIEW [Transform].[v_MasterStationNew]
AS
--Large Group of Field Removals made 2019MAR27
select distinct	[BroadcasterCode] ,
        isnull([BroadcasterName],[MDS_BroadcasterName] ) as [BroadcasterName] ,
		--isnull([MDS_InitialDataSource],'REP') as InitialDataSource,
		--isnull([DomainName],[MDS_DomainName] )						[DomainName],
	    --isnull([MCPSLicenceTypeCode],[MDS_MCPSLicenceTypeCode] )	[MCPSLicenceTypeCode],
	    isnull([RightTypeCode],[MDS_RightTypeCode] )				[RightTypeCode],
	    --isnull([TerritoryCode],[MDS_TerritoryCode] )				[TerritoryCode],
		--isnull(InceptionDate,[MDS_InceptionDate] )					[InceptionDate],
		--null as LicenceGroup, -- still not sure if CRM or REP correct
		--LowRevenue,
		--CurrentLicenceFee,
		--'REP' as MDS_InitialDataSource,
		--isnull(nullif([MusicReportingGroup],'~Not Supplied'),[MDS_MusicReportingGroup]) as MusicReportingGroup,
		isnull(replace([AudioPolicyMain],'~Unknown','U'),[MDS_AudioPolicyMain]) as AudioPolicyMain,
		isnull(replace([AudioPolicyCommercial],'~Unknown','U'),[MDS_AudioPolicyCommercial]) as AudioPolicyCommercial,
		isnull(nullif([CommercialSampleDays],''),[MDS_CommercialSampleDays]) as CommercialSampleDays,
		isnull(nullif([MainSampleDays],''),[MDS_MainSampleDays]) as MainSampleDays,
	    (case when  [CommercialSampleDays] > [MainSampleDays]  then [CommercialSampleDays]  else [MainSampleDays]  end) as TotalSampleDays,
		--check Finance Code is Valid
		isnull(
		(case when CustomerAccountNo in (SELECT [Code] FROM [$(MDS)].[mdm].[Master_v_CodaCustomer]) THEN CustomerAccountNo else NULL END)
		, [MDS_CustomerAccountNo]) as [CustomerAccountNo]

FROM [Transform].[Broadcaster]
--where [BroadcasterCode] = '2020'
--Removed 2019 MAR 15 so persist deltas too.	
  where (([NewRecordFlag] = 'N' and 
  (
  isnull([BroadcasterName],[MDS_BroadcasterName]) <> isnull([MDS_BroadcasterName],[BroadcasterName]) or 
  --isnull([DomainName],[MDS_DomainName]) <> isnull([MDS_DomainName],'Unknown') or 
  --isnull([MCPSLicenceTypeCode],[MDS_MCPSLicenceTypeCode]) <> isnull([MDS_MCPSLicenceTypeCode],'Unknown') or 
  isnull([RightTypeCode],[MDS_RightTypeCode]) <> isnull([MDS_RightTypeCode],'Unknown') or 
  --isnull([TerritoryCode],[MDS_TerritoryCode]) <> isnull([MDS_TerritoryCode],'Unknown') or 
  isnull([CustomerAccountNo],[MDS_CustomerAccountNo]) <> isnull([MDS_CustomerAccountNo],'Unknown') 
  ))
  or [NewRecordFlag] = 'Y'
  )

GO

