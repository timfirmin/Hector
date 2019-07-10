CREATE PROCEDURE [DDItransform].[ObtainNotificationSummary2]
	@LoadId bigint,
	@ReportLink  NVARCHAR(MAX) 
AS
--exec [DDItransform].[ObtainNotificationSummary2] 77133,'RepLink=';

DECLARE @table  NVARCHAR(MAX) 
SET @ReportLink = @ReportLink+ cast (@LoadId as varchar)

--Insert a Blank Row if No Files Logged On This Batch
IF EXISTS (SELECT FileLogUniqueKey FROM [DDIstaging].[FileLog] WHERE LoadId = @LoadId)
BEGIN
PRINT 'Nothing To Do'
END
ELSE
BEGIN
--If no Files Loaded Insert an Empty Batch Row for Reporting
INSERT INTO [DDIstaging].[FileLog]
           ([FileRawRowCount],[FileCreatedTimeStamp],[FileModifiedTimeStamp],[FileProcessPath],[FileSourcePath],[FileName],[FileValidationComment],[LoadId],[LoadTimeStamp])
     VALUES
           (99999
           ,getdate()
           ,getdate()
           ,'Dummy'
           ,'Dummy'
           ,'* No Files Loaded In This Batch *'
           ,'Empty Batch'
           ,@LoadId
           ,getdate())
END

;WITH 
RawNotification as
(
SELECT [LoadId]
,isnull(sum(case when DerivedFileType = 'MusicMinutes' and isnull(FileMovedActionTaken,'Failed') = 'Failed' then 1 else 0 end),0) as NMusicMinutes
,isnull(sum(case when DerivedFileType = 'MissingMinutes'  and isnull(FileMovedActionTaken,'Failed') = 'Failed' then 1 else 0 end),0) as NMissingMinutes
,isnull(sum(case when DerivedFileType = 'PublicReception'  and isnull(FileMovedActionTaken,'Failed') = 'Failed' then 1 else 0 end),0) as NPublicReception
  FROM [FinanceStage].[DDIstaging].[FileLog]
where LoadId = @LoadId
  group by [LoadId]
)
,JSONRaw AS
(
 SELECT
 NMusicMinutes	
,NMissingMinutes	
,NPublicReception
,convert(varchar(10),getdate() ,103) as NDate
--NReportLink
  FROM RawNotification
  WHERE	NMusicMinutes + NMissingMinutes + NPublicReception <> 0
  )
   SELECT  @table =
      (SELECT     
	         *,
			 @ReportLink as NReportLink
        FROM JSONRaw
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]