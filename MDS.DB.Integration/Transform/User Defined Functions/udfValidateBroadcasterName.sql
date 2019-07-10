CREATE FUNCTION [Transform].[udfValidateBroadcasterName] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,case when Name Is Null then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where Name Is Null
)

GO
