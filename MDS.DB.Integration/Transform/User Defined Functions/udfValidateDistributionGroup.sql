CREATE FUNCTION [Transform].[udfValidateDistributionGroup] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,DistributionGroup
		,case when DistributionGroup IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where DistributionGroup IS NULL
)

GO
