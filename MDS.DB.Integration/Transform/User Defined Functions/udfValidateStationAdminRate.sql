CREATE FUNCTION [Transform].[udfValidateStationAdminRate] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,StationAdminRate
		,case when StationAdminRate IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where StationAdminRate IS NULL
)

GO
