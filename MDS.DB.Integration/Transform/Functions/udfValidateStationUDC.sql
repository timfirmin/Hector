CREATE FUNCTION [Transform].[udfValidateStationUDC] ()
RETURNS TABLE 
AS
RETURN 
(
SELECT stnudc.[Name] Station_UDC
      ,stnudc.[UDCCode_Code]
      ,stnudc.[UDCCode_Name]
      ,stnudc.[MasterStationId_Code]
      ,stnudc.[MasterStationId_Name]
     -- ,stnudc.[MappingStatus_Code]
	  ,case when (nullif(mstrudc.[UDCInactiveDate],'1900-01-01 00:00:00.000') is not null and [MappingStatus_Code] = 'Yes') then 'Y' else 'N' end  as ActiveMappingInactiveUDC
	  ,case when  (stn.[LicencedStatus_Name] = 'Ceased' and [MappingStatus_Code] = 'Yes') then 'Y' else 'N' end ActiveMappingCeasedStation
  FROM [$(MDS)].[mdm].[Master_v_StationUDC] stnudc
  LEFT JOIN [$(MDS)].[mdm].[Master_v_UDC] mstrudc on stnudc.[UDCCode_Code] = mstrudc.[Code]
  LEFT JOIN [$(MDS)].[mdm].[Master_v_MasterStation] stn on stnudc.[MasterStationId_Code] = stn.Code
  WHERE 
  (nullif(mstrudc.[UDCInactiveDate],'1900-01-01 00:00:00.000') is not null and [MappingStatus_Code] = 'Yes')
  OR
  (stn.[LicencedStatus_Name] = 'Ceased' and [MappingStatus_Code] = 'Yes')
  )