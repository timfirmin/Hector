CREATE FUNCTION [Transform].[udfValidateSampleDays] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,CommercialSampleDays
		,NonCommercialSampleDays
		,1 as [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
 

where
[LicencedStatus] <> 'Ceased'
and DistributionGroup = 'AV'
and 	isnull(CommercialSampleDays,0) <> isnull(NonCommercialSampleDays,0)
)