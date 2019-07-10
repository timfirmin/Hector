

-- 

CREATE PROCEDURE [DDItransform].[ObtainNotificationFileType]
	@LoadId bigint,
	@FileType NVARCHAR(100),
	@ReportLink  NVARCHAR(MAX) 
AS
--EXEC [notification].[uspRequestNotification]  @notificationTemplate = 'DDI MasterStation Orphan',@notificationSubject = 'Distribution Data Orphan Station Found',
--@notificationData ='{"NewStationCodeCount":6,"NewStationCodeDetail":"LATEST3,ICTLK2,IPCATY,IOTEST","SourceFileName":"D181_PRS_ILR_Forecasts.txt","NDate":"10\/08\/2018","NReportLink":"https:\/\/app-reports-dev01\/reports\/report\/MDSIntegration\/DDIOrphanStationAlertDetails?ParentLoadId=0"}'
--exec [DDItransform].[ObtainNotificationSummary] 64003,'SampleDates','RepLink=';
--"EXEC [DDItransform].[ObtainNotificationSummary]  @LoadId =  " +  (DT_WSTR,10)  @[$Package::intParentLoadId]  + " , @FileType='" + @[$User::strWorkingFileType] + "'" + " , @ReportLink='" + @[$Project::strSSRSReportLink] + "'"

DECLARE @table  NVARCHAR(MAX) 
SET @ReportLink = @ReportLink+ cast (@LoadId as varchar)

;WITH RawNotification as 
(SELECT 
  e.DerivedFileType,
  e.[LoadId],
  e.FileName as SourceFileName,
  e.[NotificationFieldName],
  count(e.[NotificationUniqueKey]) [NewStationCodeCount],
  max([InsertTimeStamp]) as DateStamp,
  LEFT(r.NotificationCode , LEN(r.NotificationCode)-1) [NewStationCodeDetail]
FROM [DDItransform].[vNotificationLogFull] e
CROSS APPLY
(
    SELECT 
	r.[NotificationFieldCode] + ', '
    FROM [DDItransform].[vNotificationLogFull] r
    where e.DerivedFileType = r.DerivedFileType
      and e.[LoadId] = r.[LoadId]
    FOR XML PATH('')
) r (NotificationCode)
--WHERE e.DerivedFileType = @FileType and e.[LoadId] = @LoadId
  WHERE e.DerivedFileType = @FileType and e.[LoadId] = @LoadId
GROUP BY
  e.DerivedFileType,
  e.[LoadId],
    e.FileName,
  e.[NotificationFieldName],
  LEFT(r.NotificationCode , LEN(r.NotificationCode)-1) 
)
,JSONRaw AS
(
 SELECT
NewStationCodeCount,
NewStationCodeDetail,
SourceFileName,
convert(varchar(10),DateStamp ,103) as NDate
--NReportLink
  FROM RawNotification
  )
   SELECT  @table =
      (SELECT     
	         *,
			 @ReportLink as NReportLink
        FROM JSONRaw
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]