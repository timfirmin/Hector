

CREATE PROCEDURE [DDItransform].[ObtainNotificationSummary]
	@LoadId bigint,
	@ReportLink  NVARCHAR(MAX) 
AS
--EXEC [notification].[uspRequestNotification]  @notificationTemplate = 'DDI MasterStation Orphan',@notificationSubject = 'Distribution Data Orphan Station Found',
--@notificationData ='{"NewStationCodeCount":6,"NewStationCodeDetail":"LATEST3,ICTLK2,IPCATY,IOTEST","SourceFileName":"D181_PRS_ILR_Forecasts.txt","NDate":"10\/08\/2018","NReportLink":"https:\/\/app-reports-dev01\/reports\/report\/MDSIntegration\/DDIOrphanStationAlertDetails?ParentLoadId=0"}'
--exec [DDItransform].[ObtainNotificationSummary] 64003,'RepLink=';
--"EXEC [DDItransform].[ObtainNotificationSummary]  @LoadId =  " +  (DT_WSTR,10)  @[$Package::intParentLoadId]  + " , @FileType='" + @[$User::strWorkingFileType] + "'" + " , @ReportLink='" + @[$Project::strSSRSReportLink] + "'"

DECLARE @table  NVARCHAR(MAX) 
SET @ReportLink = @ReportLink+ cast (@LoadId as varchar)

;WITH 
RawNotification as
(
select LoadId,
isnull(sum(case when DerivedFileType = 'MusicMinutes' then 1 else 0 end),0) as NMusicMinutes,
isnull(sum(case when DerivedFileType = 'MissingMinutes' then 1 else 0 end),0) as NMissingMinutes,
isnull(sum(case when DerivedFileType = 'PublicReception' then 1 else 0 end),0) as NPublicReception,
isnull(sum(case when DerivedFileType = 'SampleDates' then 1 else 0 end),0) as NSampleDates
FROM [DDItransform].[vNotificationLogFull]
where LoadId = @LoadId
group by LoadId
)
,JSONRaw AS
(
 SELECT
 NMusicMinutes	
,NMissingMinutes	
,NPublicReception
,NSampleDates
,convert(varchar(10),getdate() ,103) as NDate
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