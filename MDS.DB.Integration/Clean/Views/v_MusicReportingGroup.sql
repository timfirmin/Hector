

CREATE VIEW [Clean].[v_MusicReportingGroup]
AS
SELECT DISTINCT 
   CHECKSUM([MusicReportingGroup]) as [MusicReportingGroupKey],
    [MusicReportingGroup]	as [MusicReportingGroupCode]	, 
    [MusicReportingGroup] as [MusicReportingGroupName]
FROM  [Clean].[v_BroadcasterAttributes]