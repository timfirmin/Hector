CREATE PROCEDURE [Reporting].[ObtainChagingStationReportSummary]
    @LoadId bigint,
	@MDSDomainName varchar(50),
	@MDS_BroadcasterName varchar(250)
AS


;WITH Summary as 
(SELECT 
       action,
       Count(*) as NumberOfRecords
  FROM [Transform].[MasterStationAlerts]
  WHERE [ParentLoadId] =@LoadId  
    --and ([MDS_DomainName] = @MDSDomainName OR @MDSDomainName = '<All>' )
    and ([MDS_BroadcasterName] = @MDS_BroadcasterName  OR @MDS_BroadcasterName  = '<All>') 
GROUP BY  Action
)

SELECT  ' Number of New Records : ' +  cast(ISNULL(CASE WHEN Action = 'New' Then NumberOfRecords Else 0 END ,0) as varchar) New,
        ' Number of Updated Records : ' +  cast(ISNULL(CASE WHEN Action like  'Upd%' Then NumberOfRecords Else 0 END ,0) as varchar) Updated
FROM Summary
GO

