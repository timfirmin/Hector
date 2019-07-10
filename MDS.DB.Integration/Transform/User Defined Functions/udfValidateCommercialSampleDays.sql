CREATE FUNCTION [Transform].[udfValidateCommercialSampleDays] ()
RETURNS TABLE 
AS
RETURN 
(
--Sample Days must be between 0 and 365 to pass validation
select   Code
		,Name
		,CommercialSampleDays
		,AudioPolicyCommercial
		,case when (CommercialSampleDays NOT BETWEEN 0 and 365) OR CommercialSampleDays is null then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where (CommercialSampleDays NOT BETWEEN 0 and 365) OR CommercialSampleDays is null
)
GO

