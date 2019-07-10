

CREATE VIEW [FPV].[vCalculationGroupMasterStation]
AS
 --=============================================

--Abacus Response Improvements Jan 2019 Added CalculationGroupStationKey
--Changed Join Logic - was using invalid data between, now uses IsCurrent = 1
-- Last Change By: TJF 2019APR24 Removed Seed,Prev,Current and 'i' to 'master'
-- Last Change By: TJF 2019APR29 Add Filter for RightTypeCompany 
-- Last Change By: TJF 2019MAY02 Added Broadcast Hours Default FPV.udfGetDGValue('DefaultBroadcastHours', C.[DistributionGroupCode])
-- =============================================
SELECT 
		 CAST(HashBytes('SHA1', C.[DistributionGroupCode] + C.[DistributionCode] + C.[Society] + S.[StationID]) AS bigint) CalculationGroupStationKey
		,C.[DistributionGroupCode]
		,C.[DistributionCode]
		,C.[Society]
		,C.[CalculationGroupStatus][CalculationPeriodStatus]
		,C.[CalculationPeriodStart]
		,C.[CalculationPeriodEnd]
		,C.[IsCurrent][CalculationGroupIsCurrent]
		,S.[StationID]
		--Added 2018NOV23
		,S.[CodaCustomerCode]
		,S.[SysStartTime]
		,S.[SysEndTime]
		,S.[StationName]
		,S.[StationStatus]

		,S.[GroupAdminRate]
		,S.[HedgePercent]
		,S.[HedgePercentMCPS]
		,S.[PRAdminRate]
		,S.[IsExcluded]
		--Added 2018SEP04
		,S.AudioPolicyMain
		,S.AudioPolicyCommercial
		,S.CommercialSampleDays
		,S.NonCommercialSampleDays
		,S.TotalSampleDays
		--Added 2018SEP19
		,S.MinimumFee
		,FPV.udfGetDGValue('DefaultBroadcastHours', C.[DistributionGroupCode]) BroadcastHours  
		--Added 2019FEB15
		,S.RegionalParentStationFlag
		,S.RegionalParentStationId
		,S.RegionalWeightingPRS
		,S.RegionalWeightingMCPS

		,S.[IsCurrent][MasterStationIsCurrent]
FROM [FPV].[vCalculationGroup] C
	CROSS APPLY ( SELECT [StationID]
				--Added 2018NOV23
				,[CodaCustomerCode]
				,[SysStartTime]
				,[SysEndTime]
				,[StationName]
	
				  ,[StationStatus]

				  ,[GroupAdminRate]
				  ,[HedgePercent]
				  ,[HedgePercentMCPS]
				  ,[PRAdminRate]
				,MinimumFee
			
				--Added 2019FEB15
				,RegionalParentStationFlag
				,RegionalParentStationId
				,RegionalWeightingPRS
				,RegionalWeightingMCPS

				  ,[IsExcluded]


				,AudioPolicyMain
				,AudioPolicyCommercial
				,CommercialSampleDays
				,NonCommercialSampleDays
				,TotalSampleDays

			
				  ,[IsCurrent]
				FROM [FPV].[vMasterStation]

				WHERE [DistributionGroupCode]=C.[DistributionGroupCode]
				AND (RightTypeCompany=C.Society or RightTypeCompany='Both')
				AND [FPV].[vMasterStation].IsCurrent = 1) S ([StationID]
																			--Added 2018NOV23
																			,[CodaCustomerCode]
																			,[SysStartTime]
																			,[SysEndTime]
																			,[StationName]
																
																		  ,[StationStatus]
												
													
																		  ,[GroupAdminRate]
																		  ,[HedgePercent]
																		  ,[HedgePercentMCPS]
																		  ,[PRAdminRate]
																		  ,MinimumFee
																		  --,BroadcastHours
																		--Added 2019FEB15
																		,RegionalParentStationFlag
																		,RegionalParentStationId
																		,RegionalWeightingPRS
																		,RegionalWeightingMCPS
																		  ,[IsExcluded]
																															 

																		  ,AudioPolicyMain
																		,AudioPolicyCommercial
																		,CommercialSampleDays
																		,NonCommercialSampleDays
																		,TotalSampleDays

																		,[IsCurrent])
WHERE C.[IsCurrent] = 1
GO

