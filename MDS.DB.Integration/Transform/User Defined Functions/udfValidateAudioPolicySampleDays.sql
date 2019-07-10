CREATE FUNCTION [Transform].[udfValidateAudioPolicySampleDays] ()

RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,'Commercial SampleDays-AudioPolicy' as MainCommercial
		,CommercialSampleDays as SampleDays
		,AudioPolicyCommercial as AudioPolicy
		,1 [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
where AudioPolicyCommercial = 'Census' and CommercialSampleDays < 365
or AudioPolicyCommercial = 'Sampled' and CommercialSampleDays = 365

union

select   Code
		,Name
		,'Main SampleDays-AudioPolicy' as MainCommercial
		,NonCommercialSampleDays as SampleDays
		,AudioPolicy as AudioPolicy
		,1 [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
where AudioPolicy = 'Census' and NonCommercialSampleDays < 365
or AudioPolicy = 'Sampled' and NonCommercialSampleDays = 365
)