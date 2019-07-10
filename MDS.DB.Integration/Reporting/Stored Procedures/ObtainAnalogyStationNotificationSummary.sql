


CREATE PROCEDURE [Reporting].[ObtainAnalogyStationNotificationSummary]
	@LoadId bigint,
	@NReportLink  NVARCHAR(MAX) 
AS

--------------------------------------------------------------------------
--Created By : Doni 2018 ~ Hector 2 MDS Integration Project
--Generates Notification String for Analogy Station Deltas
--Change Tim Firmin 2018 DEC 03
--Last Change : Tim Firmin 2018DEC03 - Not Calling Correct Report String  @ReportName is a Generic Root Folder Entry
--Test001 : [Reporting].[ObtainAnalogyStationNotificationSummary] @NReportLink = 'https://app-reports-uat01/reports/report/Department Reports/BINotifications/MDSIntegration/', @LoadId=103798
--------------------------------------------------------------------------

DECLARE @table  NVARCHAR(MAX)
DECLARE @ReportName  NVARCHAR(100) 

SET @ReportName = 'AnalogyStationIntegrationAlert'
SET @NReportLink =  @NReportLink + @ReportName + '?LoadId='+cast (@LoadId as varchar)

;WITH Sample1 as 
(SELECT 
       RecordFlag,
       Count(*) as NumberOfRecords,
	   CAST(MAX(SysStartTime) AS Date) as NDate
  FROM [Transform].[AnalogyStationAlerts]
  WHERE [ParentLoadId] = @LoadId  
  GROUP BY  Recordflag
),
SampleSummary 
AS
(
 SELECT
       
        SUM(CASE WHEN RecordFlag = 'Update' THEN NumberOfRecords ELSE 0 END) AS NUpdates,
		SUM(CASE WHEN RecordFlag = 'NoStation' THEN NumberOfRecords ELSE 0 END) AS NUnmatchedMasterStations,
		SUM(CASE WHEN RecordFlag = 'NoAnalogy' THEN NumberOfRecords ELSE 0 END) AS NUnmatchedAnalogyStations,
		convert(varchar(10),NDate,103) as NDate
  FROM Sample1 
Group by NDate
)


SELECT  @table =
      (SELECT     
	         *,
			 @NReportLink as NReportLink
        FROM SampleSummary
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]
GO

