
-- exec [Reporting].[ObtainChagingStationEmailSummary] 59199

CREATE PROCEDURE [Reporting].[ObtainChagingStationEmailSummary]
	@LoadId bigint
AS

--Declare @LoadId bigint --set  @LoadId = 59199
DECLARE @table  NVARCHAR(MAX) 


;WITH Summary as 
(
SELECT SUM(NewStations)   as NewStations, SUM(UpdatedStations) as UpdatedStations,MAX(NDate) as NDate
FROM
(
  SELECT 
       ISNULL(Count(*),0) as  NewStations,
	    0 as  UpdatedStations,
	   convert(varchar,Max(SysStartTime),103) as NDate
  FROM [Transform].[MasterStationAlerts]
  WHERE [ParentLoadId] =@LoadId  and  Action = 'New'
  UNION ALL
  SELECT 
         0 as  NewStations,
	    ISNULL(Count(*),0)  as  UpdatedStations,
	   convert(varchar,Max(SysStartTime),103) as NDate
  FROM [Transform].[MasterStationAlerts]
  WHERE [ParentLoadId] =@LoadId  and  Action like 'Up%'
)s
)



 SELECT  @table =
      (SELECT     
	         *
        FROM Summary
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  @table as  [table]

