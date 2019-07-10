
CREATE VIEW [Clean].[v_Territory]
AS
SELECT 
   CHECKSUM(ABBREV,NAME) as [TerritoryKey],
    ABBREV	as [TerritoryCode]	, 
    NAME as [TerritoryName]

FROM  [Clean].[Elementary_Territories]
WHERE RejectRow_YN = 'N'
