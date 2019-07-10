--------------------------------------------------------------------------
--Created By : TJF 2019MAR15 ~ MDS Update Validation
--Retrieves Metadata to test if Rows Validated/Updates Correctly
--Test001 SingleUser : EXEC [Transform].[spUpdateMasterStationMDSValidation] @LoadId=179080
--------------------------------------------------------------------------
CREATE PROCEDURE [Transform].[spUpdateMasterStationMDSValidation]
 @LoadId int
AS

BEGIN

update 
	msa
set 
	[MDSValidationIssue]  = 'Y'
	,[MDSValidationErrorMessage] = err.[ErrorDescription]
from [Transform].[MasterStationAlerts] msa join
[$(MDS)].[stg].[viw_Master_MasterStation_MemberErrorDetails] err on msa.BroadcasterCode = err.Code
where msa.ParentLoadId = @LoadId

update 
	msa
set 
	MDSRowInsert  = case when actual.EnterDateTime > msa.SysStartTime then 'Y' else 'N' end
	,MDSRowUpdate =  case when actual.LastChgDateTime > msa.SysStartTime then 'Y' else 'N' end
	,MDSEnterDateTime	= case when actual.EnterDateTime > msa.SysStartTime then actual.EnterDateTime else '' end
	,MDSLastChgDateTime =  case when actual.LastChgDateTime > msa.SysStartTime then actual.LastChgDateTime else '' end

from [Transform].[MasterStationAlerts] msa join
[$(MDS)].[mdm].[Master_v_MasterStation] actual on msa.BroadcasterCode = actual.Code
where msa.ParentLoadId = @LoadId
  
END
GO

