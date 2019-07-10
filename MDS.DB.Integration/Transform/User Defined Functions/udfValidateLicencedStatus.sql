CREATE FUNCTION [Transform].[udfValidateLicencedStatus] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,LicencedStatus
		,case when LicencedStatus IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where LicencedStatus IS NULL
)

GO
