
CREATE VIEW [Clean].[v_LicenceGroup]
AS

SELECT
	  CHECKSUM(AccountId) as LicenceGroupKey,
	  AccountId	as LicenceGroupCode, 
	  AccountName as LicenceGroupName,
	  Name as LicenceGroupFamily,
	  pcPRS_Split_2 as PRSSocietySplitPercent
FROM [Clean].[CustomObjects1] WHERE RejectRow_YN = 'N'

