
CREATE PROCEDURE staging.[AbacusNotificationSummary]
	@LoadId bigint,
	@NReportLink  NVARCHAR(MAX)
AS

--------------------------------------------------------------------------
--Created By : Tim Firmin 2018DEC10 ~ MDS Integration Hector 2 Project
--Get Notificiation Data
 
--Test001 SingleUser : EXEC staging.[AbacusNotificationSummary] @LoadId=101517, @NReportLink='ParamReportText\'
--------------------------------------------------------------------------

DECLARE @table  NVARCHAR(MAX) 
DECLARE @ReportName  NVARCHAR(100) 

SET @ReportName = 'AbacusValidationDetails'

SET @NReportLink =  @NReportLink + @ReportName + '?LoadId='+cast (@LoadId as varchar)

;WITH SampleSummary AS
 (  SELECT
 sum(case when charindex('Revenue', AbacusTableName) > 1 then avl.[ValidationRowCount] else 0 end)  as NRevenueChecks,
 sum(case when charindex('UDC', AbacusTableName) > 1 then avl.[ValidationRowCount] else 0 end)  as NUDCChecks,
 sum(case when charindex('Station', AbacusTableName) > 1 then avl.[ValidationRowCount] else 0 end)  as NStationChecks,
 sum(avl.[ValidationRowCount]) as NValidationRows,
 max(avl.InsertTimeStamp) as NDate,
 @NReportLink as  NReportLink

  FROM [staging].[AbacusValidationLog] avl JOIN [Config].[ValidationRules] vr
  on avl.[RuleId] = vr.[RuleId]
  where avl.[LoadId] = @LoadId
)
SELECT  @table =
      (SELECT     
	         *
        FROM SampleSummary
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]