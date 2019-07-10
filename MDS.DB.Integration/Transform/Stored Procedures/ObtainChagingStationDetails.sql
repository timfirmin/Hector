CREATE PROCEDURE [Reporting].[ObtainChagingStationDetails]
	@LoadId bigint,
	@MDSDomainName varchar(50),
	@MDS_BroadcasterName varchar(250),
	--@SourceSystem varchar(20),
	@Action varchar(20)

AS

SELECT 
       [ParentLoadId]
      ,[SourceSystem]
	  ,[SysStartTime]
      ,[action]
      ,[BroadcasterKey]
      ,[BroadcasterCode]
      ,[BroadcasterName]
      ,[DomainName]
      ,[MCPSLicenceTypeCode]
      ,[RightTypeCode]
      ,[TerritoryCode]
      ,[MDS_BroadcasterName]
      ,[MDS_DomainName]
      ,[MDS_MCPSLicenceTypeCode]
      ,[MDS_RightTypeCode]
      ,[MDS_TerritoryCode]
  FROM [Transform].[MasterStationAlerts]
  Where [ParentLoadId]        =@LoadId  
  and ([MDS_DomainName]      = @MDSDomainName OR @MDSDomainName = '<All>' )
  and ([MDS_BroadcasterName] = @MDS_BroadcasterName  OR @MDS_BroadcasterName  = '<All>')
  --and ([SourceSystem]        = @SourceSystem  OR @SourceSystem  = '<All>')
  and ([action]              = @Action  OR @Action  = '<All>')



GO


