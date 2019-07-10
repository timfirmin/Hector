CREATE FUNCTION [Transform].[udfValidatePublicReceptionAdminRate] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,PublicReceptionAdminRate
		,case when PublicReceptionAdminRate IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where PublicReceptionAdminRate IS NULL
)

GO
