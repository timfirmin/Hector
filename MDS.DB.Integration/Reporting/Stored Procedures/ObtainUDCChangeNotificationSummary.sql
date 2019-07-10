

CREATE PROCEDURE [Reporting].[ObtainUDCChangeNotificationSummary]
	@LoadId bigint,
	@ReportLink  NVARCHAR(MAX) 
AS

--------------------------------------------------------------------------
--Created By : Tim Firmin Nov 2018 ~ Hector 2 MDS Integration Project
--Generates Notification String for UDC Changes Rep vs MDS Model
--Last Change : Tim Firmin 2018DEC03 - Not Calling Correct Report String  @ReportName is a Generic Root Folder Entry
--Test001 : [Reporting].ObtainUDCChangeNotificationSummary  @LoadId =  0 , @ReportLink='https://app-reports-dev01/reports/report/Application%20Reports/Hector2/'
--------------------------------------------------------------------------


DECLARE @table  NVARCHAR(MAX)
DECLARE @ReportName  NVARCHAR(100) 

SET @ReportName = 'UDCStationAlertDetails'

SET @ReportLink =  @ReportLink + @ReportName + '?LoadId='+cast (@LoadId as varchar)


;WITH cteSample as 
(SELECT 'Master-UDC' as MDSEntity
      ,[DeltaAction]
      ,[DeltaMessage]
      ,count(MasterUDCDeltaKey) as NumberOfRecords
	  ,MAX(SysStartTime) as NDate
      ,[LoadId]
  FROM [Transform].[MasterUDCAlerts]
  WHERE  not (DeltaAction = 'Update' and  UDCDescription <>  MDSUDCDescription) AND [LoadId] = @LoadId  
  group by     
  [DeltaAction]      ,[DeltaMessage]	   ,[LoadId]

UNION

SELECT 'Station-UDC' as MDSEntity
      ,[DeltaAction]
      ,[DeltaMessage]
      ,count([BroadcasterUDCDeltaKey]) as NumberOfRecords
	  ,MAX(SysStartTime) as NDate
      ,[LoadId]
  FROM [Transform].[BroadcasterUDCAlerts]
  WHERE not (DeltaAction = 'Update' and  UDCTimeBand <>  MDSTimeBand and UDCUsedForPurposeDescription <> MDSUsedForPurposeDescription) AND [LoadId] = @LoadId  
  group by     
  [DeltaAction]      ,[DeltaMessage]	   ,[LoadId]
)
,SampleSummary AS
(
 SELECT
        SUM(CASE WHEN [DeltaAction] = 'Insert' AND  MDSEntity = 'Master-UDC' THEN NumberOfRecords ELSE 0 END) AS NUDCNew,
        SUM(CASE WHEN [DeltaAction] = 'Delete' AND  MDSEntity = 'Master-UDC' THEN NumberOfRecords ELSE 0 END) AS NUDCInactive,
        SUM(CASE WHEN [DeltaAction] = 'Insert' AND  MDSEntity = 'Station-UDC' THEN NumberOfRecords ELSE 0 END) AS NUDCStationNew,
        SUM(CASE WHEN [DeltaAction] = 'Update' AND  MDSEntity = 'Station-UDC' THEN NumberOfRecords ELSE 0 END) AS NUDCStationChange,
		max(convert(varchar(10),NDate ,103)) as NDate
  FROM cteSample  
)

 SELECT  @table =
      (SELECT     
	         *,
			 @ReportLink as NReportLink
        FROM SampleSummary
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]

--@notificationData ='{"NNewREP":0,"NNewCRM":0,"NUpdatedREP":215,"NUpdatedCRM":0,"NNewMDS":0,"NDate":"16\/08\/2018","NReportLink":""}'