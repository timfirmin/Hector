CREATE PROC [Reporting].[ObtainLoadProcessData](@Date Date)

AS

DECLARE @StartLoadID int
DECLARE @FinishLoadID int
DECLARE @StartTimeLastMonth As Date
DECLARE @LoadDate Date

--Find the beginning of the most recent load - This is Where PackageName is for example 'External to Stage Process' or 'Source to Stage Process'

SELECT @StartLoadID = MAX(LoadID) 
FROM [Audit].[PackageLoad]
WHERE PackageName LIKE '%To%Stage%Process'
AND CONVERT(Date, StartTime) <= @Date

----Find the day of the Load - we are only going to include Loads that occured on the same day, 
----this will need to be amended if ETL is running over a day.

SELECT @LoadDate = Convert(Date, StartTime)
FROM [Audit].[PackageLoad]
WHERE LoadId = @StartLoadID


--Find the End of the most recent Load

SELECT @FinishLoadID = ISNULL(MIN(LoadID),999999) 
FROM [Audit].[PackageLoad]
--WHERE PackageName LIKE '%OLAP%Process%'
WHERE PackageName LIKE '%Warehouse%Process%'
AND LoadId > @StartLoadID
AND CONVERT(Date, StartTime) = @LoadDate


--Find the start time last month, we only want to return a months worth of loads

SELECT 
	@StartTimeLastMonth = DATEADD(mm, -1, MAX(CAST(StartTime AS DATE))) 
FROM	
	Audit.PackageLoad PL
LEFT JOIN (Select Distinct package_guid From Audit.vPackage Where Name LIKE '%Process%' OR Name LIKE '%Global%Executor%') PD 
	ON PL.PackageGUID = PD.Package_GUID 
WHERE CONVERT(Date, StartTime) <= @Date


;WITH CurrentLoad AS
(
SELECT PackageName,
	   Duration,
	   LS.[Name] As LoadStatus,
	   EP.ProcessStream,
	   'Load Process: ' + PL.LoadProcess + ' Id: ' + CONVERT(CHAR,PL.LoadId) +  CHAR(13) + CHAR(10) + 'Started By: ' + CreatedBy + CHAR(13) + CHAR(10) + 'Started At: ' + CONVERT(CHAR,StartTime) AS ToolTip,
	   PL.StartTime,
	   PL.LoadId As CurrentLoadId
  FROM 
  --Add a subquery to return the latest value for each guid.
  [Audit].[PackageLoad] PL
  INNER JOIN Control.LoadStatusType LS
	ON PL.LoadStatusId = LS.LoadStatusTypeId
  LEFT JOIN Control.EntityProcessStream EP
	ON EP.LoadId = PL.LoadId
  WHERE ParentLoadId IS NULL
  AND (PackageName like '%Process%'
  OR PackageName like '%Global%Executor%')
  AND PL.LoadId >= @StartLoadID
  AND PL.LoadId <= @FinishLoadID
  AND CONVERT(Date, StartTime) = @LoadDate
)

,PreviousLoads AS
(
SELECT 
	 PL.Duration As DurationHistory
	,ISNULL(PL.LoadId,0) As HistoryLoadId
	,CL.Duration AS CurrentDuration
	,CL.LoadStatus
	,CL.PackageName
	,CL.StartTime
	,CL.ToolTip
	,CL.ProcessStream
	,CL.CurrentLoadId
FROM [Audit].[PackageLoad] PL
RIGHT JOIN CurrentLoad CL
	ON CL.PackageName = PL.PackageName
WHERE PL.StartTime > @StartTimeLastMonth
AND  CONVERT(Date, PL.StartTime) <= @Date 

)

SELECT 
	DurationHistory
	,HistoryLoadId
	,CurrentDuration
	,LoadStatus
	,PackageName 
	,ToolTip
	,StartTime
	,ProcessStream
	,CurrentLoadId
FROM PreviousLoads
ORDER BY PackageName, HistoryLoadId DESC