
/*
 * Tony Wilkinson 2019MAY11 - Update-Merge MasterStation table from MDS / staging
 * Update Tim Firmin 2018SEP17 Additional Columns Audio Policy
 * Update Tim Firmin 2019FEB13 Additional Regional Weighting Columns RegionalParentStationFlag, RegionalParentStationId, RegionalWeightingPRS, RegionalWeightingMCPS 
 * Update Tim Firmin 2019APR29 Add RightTypeCompany
 * Test: EXEC [staging].[uspMergeMasterStations] @pLoadId = 321, @pUserName = 'tjf',  @pInsertedRowCount = 0
 */ 
CREATE PROCEDURE [staging].[uspMergeMasterStations]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

merge [FPV].[MasterStation] t
using [staging].[vStation] s
on upper(t.[StationID]) = upper(s.[StationID])

when not matched by target then
insert ([StationID],[DistributionGroupCode],[StationName],[StationStatus],[AudioPolicyMain] ,[AudioPolicyCommercial] ,[CommercialSampleDays] ,[NonCommercialSampleDays] ,[TotalSampleDays],[GroupAdminRate],[HedgePercent],[HedgePercentMCPS],[PRAdminRate],[IsExcluded],CodaCustomerCode,MinimumFee, RegionalParentStationFlag, RegionalParentStationId, RegionalWeightingPRS, RegionalWeightingMCPS, RightTypeCompany )
values (upper(s.[StationID]),s.[DistributionGroupCode],s.[StationName],s.[StationStatus],s.[AudioPolicyMain] ,s.[AudioPolicyCommercial] ,s.[CommercialSampleDays] ,s.[NonCommercialSampleDays] ,s.[TotalSampleDays],s.[GroupAdminRate],s.[HedgePercent],s.[HedgePercentMCPS],s.[PRAdminRate],s.[IsExcluded], s.CodaCustomerCode,s.MinimumFee, S.RegionalParentStationFlag, S.RegionalParentStationId, S.RegionalWeightingPRS, S.RegionalWeightingMCPS, S.RightTypeCompany )

when MATCHED  
		   AND isnull(t.[StationStatus],0)!=isnull(s.[StationStatus],0)
			OR isnull(t.[GroupAdminRate],0)!=isnull(s.[GroupAdminRate] ,0)
			OR isnull(t.[HedgePercent],0)!=isnull(s.[HedgePercent] ,0)
			OR isnull(t.[HedgePercentMCPS],0)!=isnull(s.[HedgePercentMCPS] ,0)
			OR isnull(t.[PRAdminRate],0)!=isnull(s.[PRAdminRate] ,0)
			OR isnull(t.[IsExcluded],0)!=isnull(s.[IsExcluded],0)
			OR isnull(t.[StationName],0)!=isnull(s.[StationName],0)

			OR isnull(t.[AudioPolicyMain],0)!=isnull(s.[AudioPolicyMain],0)
			OR isnull(t.[AudioPolicyCommercial],0)!=isnull(s.[AudioPolicyCommercial],0)
			OR isnull(t.[CommercialSampleDays],0)!=isnull(s.[CommercialSampleDays],0)
			OR isnull(t.[NonCommercialSampleDays],0)!=isnull(s.[NonCommercialSampleDays],0)
			OR isnull(t.[TotalSampleDays],0)!=isnull(s.[TotalSampleDays],0)

			OR isnull(t.CodaCustomerCode,0)!=isnull(s.CodaCustomerCode,0)

			--OR isnull(t.DistributionGroupCode,0)!=isnull(s.DistributionGroupCode,0)

			OR isnull(t.MinimumFee,0)!=isnull(s.MinimumFee,0)

			OR isnull(t.RegionalParentStationFlag,0)!=isnull(s.RegionalParentStationFlag,0)
			OR isnull(t.RegionalParentStationId,0)!=isnull(s.RegionalParentStationId,0)
			OR isnull(t.RegionalWeightingPRS,0)!=isnull(s.RegionalWeightingPRS,0)
			OR isnull(t.RegionalWeightingMCPS,0)!=isnull(s.RegionalWeightingMCPS,0)

			OR isnull(t.RightTypeCompany,0)!=isnull(s.RightTypeCompany,0)
			--RegionalParentStationFlag, RegionalParentStationId, RegionalWeightingPRS, RegionalWeightingMCPS 
THEN UPDATE
		 SET [StationStatus]=s.[StationStatus]
			,[GroupAdminRate]=s.[GroupAdminRate] 
			,[HedgePercent]=s.[HedgePercent] 
			,[HedgePercentMCPS]=s.[HedgePercentMCPS] 
			,[PRAdminRate]=s.[PRAdminRate] 
			,[IsExcluded]=s.[IsExcluded]
			,[StationName]=s.[StationName]
			,CodaCustomerCode=s.CodaCustomerCode
			--Added Following Testing 2018JUL19
			--,DistributionGroupCode=s.DistributionGroupCode
	
			--Added 2018 SEP 04
			,[AudioPolicyMain]=s.[AudioPolicyMain]
			,[AudioPolicyCommercial]=s.[AudioPolicyCommercial]
			,[CommercialSampleDays]=s.[CommercialSampleDays]
			,[NonCommercialSampleDays]=s.[NonCommercialSampleDays]
			,[TotalSampleDays]=s.[TotalSampleDays]

			,[MinimumFee]=s.[MinimumFee]
		 
			,RegionalParentStationFlag=s.RegionalParentStationFlag
			,RegionalParentStationId=s.RegionalParentStationId
			,RegionalWeightingPRS=s.RegionalWeightingPRS
			,RegionalWeightingMCPS=s.RegionalWeightingMCPS

			,RightTypeCompany=s.RightTypeCompany
			
when not matched by source then delete;

/* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT

END


GO


