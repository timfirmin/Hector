CREATE PROCEDURE [Reporting].[ObtainStationChangeNotificationSummary]
	@LoadId bigint,
	@ReportLink  NVARCHAR(MAX) 
AS


DECLARE @table  NVARCHAR(MAX)
DECLARE @ReportName  NVARCHAR(100) 

SET @ReportName = 'MasterStationAlertDetails'

SET @ReportLink =  @ReportLink + @ReportName + '?LoadId='+cast (@LoadId as varchar)


;WITH Sample as 
(SELECT 
       action,
	   'REP' as MDS_InitialDataSource,
       Count(*) as NumberOfRecords,
	   MAX(SysStartTime) as NDate
  FROM [Transform].[MasterStationAlerts]
  WHERE [ParentLoadId] =@LoadId  
  GROUP BY  Action 
)
,SampleSummary AS
(
 SELECT
        SUM(CASE WHEN action like 'New%' AND MDS_InitialDataSource = 'REP' THEN NumberOfRecords ELSE 0 END) AS NNewREP,
		SUM(CASE WHEN action like 'New%' AND MDS_InitialDataSource = 'CRM' THEN NumberOfRecords ELSE 0 END) AS NNewCRM,
	    SUM(CASE WHEN action like 'MDS%' THEN NumberOfRecords ELSE 0 END) AS NNewMDS,
		SUM(CASE WHEN action like 'Upda%' AND MDS_InitialDataSource = 'REP' THEN NumberOfRecords ELSE 0 END) AS NUpdatedREP,
		SUM(CASE WHEN action like 'Upda%' AND MDS_InitialDataSource = 'CRM' THEN NumberOfRecords ELSE 0 END) AS NUpdatedCRM,
		convert(varchar(10),NDate ,103) as NDate
  FROM Sample Group by convert(varchar(10),NDate ,103)
)

 SELECT  @table =
      (SELECT     
	         *,
			 @ReportLink as NReportLink
        FROM SampleSummary
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]

--@notificationData ='{"NNewREP":0,"NNewCRM":0,"NUpdatedREP":215,"NUpdatedCRM":0,"NNewMDS":0,"NDate":"16\/08\/2018","NReportLink":""}'
GO

