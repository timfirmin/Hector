CREATE PROC [Reporting].[ObtainDataThroughputData](@Date Date)

AS

DECLARE @StartLoadId int
DECLARE @FinishExecutionIdId int
DECLARE @FinishLoadId int
DECLARE @StartTimeLastMonth As Date
DECLARE @LoadDate As Date

--Find the beginning of the most recent load - This is Where PackageName = 'SourceToStageProcess'

SELECT @StartLoadID = MAX(LoadID) 
FROM [Audit].[PackageLoad]
WHERE PackageName LIKE '%SourceToStage%Process%'
AND CONVERT(Date, StartTime) <= @Date 

--Find the Execution Id for End of the most recent Load

SELECT @FinishExecutionIdID = ISNULL(Min(ExecutionId),999999) 
FROM [Audit].[PackageLoad]
--WHERE PackageName LIKE '%OLAP%Process%'
WHERE PackageName LIKE '%Analytics%Process%'
AND LoadId > @StartLoadID

--Find the last LoadId for the Load

SELECT @FinishLoadId = MAX(LoadId) 
FROM [Audit].[PackageLoad]
WHERE ExecutionId = @FinishExecutionIdID


--PRINT @FinishLoadID  

----Find the day of the Load - we are only going to include Loads that occured on the same day, 
----this will need to be amended if ETL is running over a day.

SELECT @LoadDate = Convert(Date, StartTime)
FROM [Audit].[PackageLoad]
WHERE LoadId = @StartLoadID


--Find the start time last month, we only want to return a months worth of loads

SELECT 
	@StartTimeLastMonth = DATEADD(mm, -1, MAX(CAST(StartTime AS DATE))) 
FROM	
	Audit.PackageLoad PL
LEFT JOIN (Select Distinct package_guid From Audit.vPackage Where Name LIKE '%Process%') PD 
	ON PL.PackageGUID = PD.Package_GUID 
WHERE CONVERT(Date, StartTime) <= @Date

--Obtain Current Row Counts and Statuses
;WITH CurrentLoad AS 
(
SELECT 
	 MIN(RT.LoadId) As CurrentLoadId
	,SUM(RT.InsertedRows) AS SuccessRows
	,ProcessStream + ' Success Rows' As RowDefinition
	,CASE WHEN LS.Description = 'Load Failed' THEN '#fff8f9' ELSE '#f9fff8' END As IndicatorColour 
FROM [Audit].[RowThroughput] RT
INNER JOIN [Audit].[PackageLoad] PL
	ON RT.LoadId = PL.LoadId
INNER JOIN [Control].[LoadStatusType] LS
	ON LS.LoadStatusTypeId = PL.LoadStatusId
WHERE RT.LoadId >= @StartLoadID
AND RT.ExecutableId <= @FinishExecutionIdID
AND CONVERT(Date, StartTime) <= @LoadDate
GROUP BY ProcessStream, LS.Description

UNION ALL
 
SELECT 
	 MIN(RT.LoadId) As MinLoadId
	,SUM(RT.UpdatedRows) AS UpdatedRows
	,ProcessStream + ' Updated Rows' As RowDefinition
	,CASE WHEN LS.Description = 'Load Failed' THEN '#fff8f9' ELSE '#f9fff8' END As IndicatorColour 
FROM [Audit].[RowThroughput] RT
INNER JOIN [Audit].[PackageLoad] PL
	ON RT.LoadId = PL.LoadId
INNER JOIN [Control].[LoadStatusType] LS
	ON LS.LoadStatusTypeId = PL.LoadStatusId
WHERE RT.LoadId > = @StartLoadID
AND CONVERT(Date, StartTime) <= @LoadDate
AND RT.ExecutionId <= @FinishExecutionIdID
GROUP BY ProcessStream, LS.Description

UNION ALL

SELECT 
	-2 As MinLoadId
	,COUNT(*) AS BadRows 
	,'Bad Rows' As RowDefinition
	,CASE WHEN COUNT(*) > 0 THEN '#fff8f9' ELSE '#f9fff8' END As IndicatorColour
FROM Audit.EventFact EF
INNER JOIN Audit.PackageLoad PL
	ON Ef.LoadId = PL.LoadId
WHERE EF.LoadId > = @StartLoadID AND ScreenId IS NULL
AND CONVERT(Date, StartTime) <= @LoadDate
AND EF.LoadId <=  @FinishLoadId

UNION ALL

SELECT 
	-1 As MinLoadId
	,COUNT(*) AS BadRows 
	,'Rows Failed Data Quality' As RowDefinition
	,CASE WHEN COUNT(*) > 0 THEN '#fff8f9' ELSE '#f9fff8' END As IndicatorColour --Red #fff8f9 Green 
FROM Audit.EventFact EF
INNER JOIN [Audit].[PackageLoad] PL
	ON EF.LoadId = PL.LoadId
WHERE EF.LoadId > = @StartLoadID AND ScreenId IS NOT NULL
AND CONVERT(Date, StartTime) <= @LoadDate
AND EF.LoadId <=  @FinishLoadId
)


,PreviousLoads AS 
(
SELECT 
	 RT.ExecutionId As PreviousLoadId
	,SUM(RT.InsertedRows) AS PreviousSuccessRows
	,ProcessStream + ' Success Rows' As RowDefinition
FROM [Audit].[RowThroughput] RT
WHERE RT.LoadId < = @StartLoadID AND RT.UpdatedDate > @StartTimeLastMonth
GROUP BY ProcessStream, ExecutionId

UNION ALL
 
SELECT 
	 RT.ExecutionId As PreviousLoadId
	,SUM(RT.UpdatedRows) AS UpdatedRows
	,ProcessStream + ' Updated Rows' As RowDefinition
FROM [Audit].[RowThroughput] RT
WHERE RT.LoadId < = @StartLoadID AND RT.UpdatedDate > @StartTimeLastMonth
AND CONVERT(Date, UpdatedDate) <= @Date
GROUP BY ProcessStream, ExecutionId

UNION ALL

SELECT 
	PL.LoadId As PreviousLoadId
	,CASE WHEN EF.LoadId IS NULL Then 0 ELSE COUNT(*) END AS DataQualityRows
	,'Bad Rows' As RowDefinition
FROM Audit.EventFact EF
INNER JOIN [Audit].[PackageLoad] PL
	ON EF.LoadId = PL.LoadId
WHERE EF.LoadId <= @StartLoadID AND ScreenId IS NULL AND UpdatedDate > @StartTimeLastMonth
AND CONVERT(Date, UpdatedDate) <= @Date
GROUP BY PL.LoadId, EF.LoadId


UNION ALL

SELECT 
	 PL.LoadId As PreviousLoadId
	,CASE WHEN EF.LoadId IS NULL Then 0 ELSE COUNT(*) END AS DataQualityRows
	,'Rows Failed Data Quality' As RowDefinition
FROM Audit.EventFact EF
RIGHT JOIN [Audit].[PackageLoad] PL
	ON EF.LoadId = PL.LoadId
WHERE EF.LoadId <= @StartLoadID AND ScreenId IS NOT NULL AND UpdatedDate > @StartTimeLastMonth
AND CONVERT(Date, UpdatedDate) <= @Date
GROUP BY PL.LoadId, EF.LoadId
) 


SELECT 
	 CurrentLoadId
	,SuccessRows
	,CL.RowDefinition
	,IndicatorColour
	,ISNULL(PreviousLoadId, CurrentLoadId) AS PreviousLoadId
	,ISNULL(PreviousSuccessRows, 0) AS PreviousSuccessRows
FROM CurrentLoad CL
LEFT JOIN PreviousLoads PL
	ON CL.RowDefinition = PL.RowDefinition