CREATE FUNCTION [Transform].[udfValidateCodaAccountCodeEl2] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		--,CodaAccountCodeEl2
		,case when 'XXX' IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
--Where CodaAccountCodeEl2 IS NULL
)

GO
