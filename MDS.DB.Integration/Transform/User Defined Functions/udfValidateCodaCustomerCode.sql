CREATE FUNCTION [Transform].[udfValidateCodaCustomerCode] ()
RETURNS TABLE 
AS
RETURN 
(
select   Code
		,Name
		,CodaCustomerCode
		,case when CodaCustomerCode IS NULL OR CodaCustomerCode = 'C9999' then 1 else 0 end [ValidationResult] -- 1 validation failed , 0 - Valid Record
from [Staging].[MDS_MasterStation]
Where CodaCustomerCode IS NULL --OR CodaCustomerCode = 'C9999'
)

GO
