CREATE PROCEDURE [Reporting].[ObtainSuppliedStationNotificationSummary]
	@ReportLink  NVARCHAR(MAX) 
AS

--------------------------------------------------------------------------
--Created By : Senay 2018 ~ Hector 2 MDS Integration Project
--Generates Notification String for Supplied Station Delta Reporting
--Change Tim Firmin 2018 DEC 03
--Last Change : Tim Firmin 2018DEC03 - Not Calling Correct Report String  @ReportName is a Generic Root Folder Entry
--Test001 : [Reporting].[ObtainSuppliedStationNotificationSummary] @ReportLink = 'https://app-reports-uat01/reports/report/Department Reports/BINotifications/MDSIntegration/'
--Change: Nathalie Carlberg 2019FEB25 - Add Summaries.
--Change: Nathalie Carlberg 2019MAR04 - Add CRM Summary.
--Change:  Tim Firmin 2019MAR27 - Remove Rejected Field
--------------------------------------------------------------------------

DECLARE @table NVARCHAR(MAX);
DECLARE @results VARCHAR(100);
DECLARE @ReportName NVARCHAR(100);
SET @ReportName = 'SuppliedStationAlerts';
SET @ReportLink = @ReportLink + @ReportName;

WITH StationStatusList AS
(
  SELECT
    DataSource_Code,
    NRecords = COUNT(*) 
  FROM
    MDS.mdm.Master_v_SuppliedStations 
  WHERE
    MasterStationCode_Code IS NULL 
	--OR Rejected_Name = 'Yes'
  GROUP BY
    DataSource_Code
)
SELECT 
  @results = COALESCE(@results + ',', '') + CONVERT(varchar(12), DataSource_Code)
FROM
  StationStatusList
;
WITH SampleSummary AS 
(
  SELECT
    NUnmatchedBARB,
    NUnmatchedRAJAR,
    NUnknownBARB,
    NUnknownRAJAR,
    NUnmatchedCRM,
    NUnknownCRM
  FROM
  (
    SELECT
      NUnmatchedBARB = SUM(CASE DataSource_Code WHEN 'BARB' THEN 1 ELSE 0 END),
      NUnmatchedRAJAR = SUM(CASE DataSource_Code WHEN 'RAJAR' THEN 1 ELSE 0 END),
      NUnmatchedCRM = SUM(CASE DataSource_Code WHEN 'CRM' THEN 1 ELSE 0 END)
    FROM
      MDS.mdm.Master_v_SuppliedStations
    WHERE
      MasterStationCode_Code IS NULL
  ) AS Unmatched
  CROSS JOIN
  (
    SELECT
      NUnknownBARB = SUM(CASE DataSource_Code WHEN 'BARB' THEN 1 ELSE 0 END),
      NUnknownRAJAR = SUM(CASE DataSource_Code WHEN 'RAJAR' THEN 1 ELSE 0 END),
      NUnknownCRM = SUM(CASE DataSource_Code WHEN 'CRM' THEN 1 ELSE 0 END)
    FROM
      MDS.mdm.Master_v_SuppliedStations
    --WHERE
    -- Rejected_Name = 'Yes'
  ) as Unknown
)
SELECT @table =
  (
    SELECT 
      *,
      NDataSources = @results,
      NDate = CONVERT(varchar(10),GETDATE(),103),
	  NReportLink = @ReportLink
    FROM
      SampleSummary
    FOR JSON PATH, INCLUDE_NULL_VALUES
  )
;

SELECT REPLACE(REPLACE(@table,']',''),'[','') AS [table]
GO