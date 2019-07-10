CREATE VIEW [Clean].[v_MCPSLicenceTypes]
AS
SELECT 
  CHECKSUM(NAME,DESCRIPTION) as MCPSLicenceKey,
  LEFT(RTRIM(LTRIM(NAME)),10) as MCPSLicenceCode, 
  LEFT(RTRIM(LTRIM(NAME)),10) as MCPSLicenceName ,
  RTRIM(LTRIM(DESCRIPTION)) as Description 

FROM  [Clean].[MCPS_Licence_Types]
WHERE RejectRow_YN = 'N'
