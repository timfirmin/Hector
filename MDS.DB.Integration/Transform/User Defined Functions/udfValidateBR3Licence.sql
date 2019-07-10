CREATE FUNCTION [Transform].[udfValidateBR3Licence] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,BR3Licence
		,DistributionGroup
		,case when BR3Licence IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where BR3Licence IS NULL
AND DistributionGroup IS NULL OR DistributionGroup = 'ILR'
)

GO
