CREATE FUNCTION [Transform].[udfValidateEffectiveDate] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		--,EffectiveDate
		,case when 'XXX' IS NULL then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
--Where EffectiveDate IS NULL
)

GO
