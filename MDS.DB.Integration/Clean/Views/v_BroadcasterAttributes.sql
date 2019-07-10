


CREATE VIEW [Clean].[v_BroadcasterAttributes]
AS

SELECT DISTINCT 
	   [StationId]
      ,[LicenceGroup]
      ,[MusicReportingGroup]
      ,[KeyAccountGroup]
  FROM [Staging].[BroadcasterAttributes] with (nolock)
  WHERE [DistributionCode] = (select max([DistributionCode]) from [Staging].[BroadcasterAttributes])