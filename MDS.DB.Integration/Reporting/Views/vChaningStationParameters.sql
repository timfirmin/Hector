

Create View [Reporting].[vChaningStationParameters]
As

SELECT 
     Distinct  
	   [ParentLoadId] as LoadId
      ,[SourceSystem]
	  ,convert(varchar(10),[SysStartTime],103) as LoadDate
	   ,convert(varchar(20),[SysStartTime],113) as LoadDateTime
      ,[action]
     
  FROM [Transform].[MasterStationAlerts]
