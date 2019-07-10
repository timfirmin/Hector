CREATE PROCEDURE [staging].[uspMergeUDC]
  @pLoadId				int,
  @pUserName			varchar(100),
  @pInsertedRowCount	bigint OUT
AS
BEGIN

--the stagng table may contain station-udc mappings that are unusable by abacus
--CTE: ValidStationUDCMappings filters out invalid mappngs that should not be added to the MasterUDC table
with ValidStationUDCMappings as (
	select	[StationID]
			,[UsedForPurpose]
			,[MappedTimeBand][TimeBand]
			,[UDCCode]
			,[UDCDescription]
	from [staging].[vStationUDCMapping]
	where StationUDCMappingIsValid = 1 --this UDC is still mapped to the station at source
	and	MappedTimeBandIsValid = 1 --the supplied UDC TimeBand can be mapped to an Abacus TimeBand
	and UsedForPurposeIsValid = 1 --the supplied UsedForPurpose is a known value
	and UDCUniqueCount = 1 -- only 1 Station-UDC mapping is provided for each [UsedForPurpose],[TimeBand]
)				 
	
merge [FPV].[MasterUDC] t
using ValidStationUDCMappings s
on t.[StationID] = s.[StationID] 
and t.[UsedForPurposeDesc] = s.[UsedForPurpose]
and t.[TimeBand]=s.[TimeBand]

when not matched by target then
insert ([StationID],[UDCCode],[UDCDescription],[UsedForPurposeDesc],[TimeBand],[UpdatedBy],[UpdateComment])
values (s.[StationID],s.[UDCCode],s.[UDCDescription],s.[UsedForPurpose],s.[TimeBand],@pUserName,'Insert from Abacus Data Hub')


when MATCHED  
		   AND (
				isnull(t.UDCCode,'') != isnull(s.UDCCode,'') 
				OR
				isnull(t.[UDCDescription],'')!=isnull(s.[UDCDescription],'')
				)
THEN UPDATE
		 SET 
		    [UDCDescription]=isnull(s.[UDCDescription],'')
		   ,[UDCCode]=isnull(s.[UDCCode],'')
		   ,[UpdatedBy]= @pUserName
		   ,[UpdateComment]='Update from Abacus Data Hub'

when not matched by source then delete;


 /* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT

 END
GO

