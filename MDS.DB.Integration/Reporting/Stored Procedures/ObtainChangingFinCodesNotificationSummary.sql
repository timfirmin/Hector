CREATE PROCEDURE [Reporting].[ObtainChangingFinCodesNotificationSummary]
  @LoadId bigint,
  @ReportLink  NVARCHAR(MAX) 
AS
DECLARE @table  NVARCHAR(MAX) 
SET @ReportLink = @ReportLink+ 'MDSStationFinancialCodeMappings';

WITH StationStatusList AS
(
  SELECT
    RecordType = 'UnmappedCustomerCode',
    CodaCode = ccu.Code
  FROM
    [$(MDS)].[mdm].[Master_v_MasterStation] AS mst
  LEFT JOIN [$(MDS)].[mdm].[Master_v_CodaCustomer] AS ccu on 
    mst.CodaCustomerCode_Code = ccu.Code
  WHERE
    ccu.Code IS NULL
  UNION ALL 
  SELECT
    RecordType = (action + CodaCodeType),
    CodaCode 
   FROM
     [Transform].[v_CodaCodeAlerts]
  WHERE
    LoadId = @LoadId
),
Samples AS 
(
  SELECT  
    RecordType,
    NRecords = Count(*) 
  FROM
    StationStatusList
  GROUP BY
    RecordType
),
SampleSummary AS
(
  SELECT
    UpdatedCustomerCode = SUM(CASE WHEN RecordType = 'UpdatedCustomerCode' THEN NRecords ELSE 0 END),
    NNullCodaCustomerCodes = SUM(CASE WHEN RecordType = 'UnmappedCustomerCode' THEN NRecords ELSE 0 END)
  FROM
    Samples
)
SELECT 
@table = (
  SELECT     
	  *,
    NDate = CONVERT(VARCHAR(10),GETDATE(),103),
    NReportLink = @ReportLink
  FROM 
    SampleSummary
  FOR JSON PATH, INCLUDE_NULL_VALUES
  );

SELECT REPLACE(REPLACE(@table,']',''),'[','') AS [table];

GO