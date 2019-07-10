CREATE FUNCTION [Transform].[udfValidateRightType] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,RightType
		,case when RightType IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where RightType IS NULL
)

GO
