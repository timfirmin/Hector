CREATE FUNCTION [Transform].[udfValidateInceptionDate] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		--,InceptionDate
		,case when 'XXX' IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
--Where InceptionDate IS NULL OR ISDate(cast(InceptionDate as datetime)) =0 
)
