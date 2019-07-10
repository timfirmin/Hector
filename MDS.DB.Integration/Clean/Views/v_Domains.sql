
CREATE VIEW [Clean].[v_Domains]
AS

SELECT
	  CHECKSUM(NAME) as DomainKey,
	  NAME	as DomainCode, 
	  NAME as DomainName

FROM [Clean].[Domains] WHERE RejectRow_YN = 'N'

