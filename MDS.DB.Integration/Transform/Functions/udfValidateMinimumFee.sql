CREATE FUNCTION [Transform].[udfValidateMinimumFee] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,MinimumFee
		,case when MinimumFee IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where MinimumFee IS NULL
)