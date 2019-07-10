
CREATE FUNCTION [Transform].[udfValidateLowRevenueFlag] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		--,LowRevenue
		--,CurrentLicenceFee
		,case when ('XXX' = 'Yes' and 0 >= 5000)  OR  ('XXX' = 'NO' and 0 < 5000) then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
--Where (LowRevenue = 'Yes' and CurrentLicenceFee >= 5000)  OR  (LowRevenue = 'NO' and CurrentLicenceFee < 5000)
)
