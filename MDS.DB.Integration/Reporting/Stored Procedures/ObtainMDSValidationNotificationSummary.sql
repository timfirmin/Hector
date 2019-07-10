
CREATE PROCEDURE [Reporting].[ObtainMDSValidationNotificationSummary]
	@LoadId bigint,
	@NReportLink  NVARCHAR(MAX) ,
	@TemplateName NVarchar(150)
AS


DECLARE @table  NVARCHAR(MAX) 
DECLARE @ReportName  NVARCHAR(100) 

--SET @ReportName = CASE WHEN @TemplateName = 'MDS Validation SDM' THEN 'MDSValidationSDM'
--                       WHEN @TemplateName = 'MDS Validation Licensing' THEN 'MDSValidationLicensing' 
--					   WHEN @TemplateName = 'MDS Validation BI' THEN 'MDSValidationBI'
--					   WHEN @TemplateName = 'MDS Master Station Validation' THEN 'MDSMasterStationValidation' END

SET @ReportName = 'MDSMasterStationValidation'

SET @NReportLink =  @NReportLink + @ReportName + '?LoadId='+cast (@LoadId as varchar)

;WITH Sample1 AS
 ( SELECT count(DISTINCT V.Code) NumberOfValidationFailuers, 
          SUM(CASE WHEN AudioPolicy IS NULL THEN 0 ELSE 1 END) NAudioPolicyUpdates, 
		  SUM(CASE WHEN LicenceGroup IS NULL THEN 0 ELSE 1 END) NLicenceUpdate,
		  SUM(CASE WHEN LowRevenue IS NULL THEN 0 ELSE 1 END) NLicenceFeeBreaks,
          Value as Template
          FROM [Transform].[v_MDSMasterStationValidation] V INNER JOIN
               [Config].[MDSBusinessRules] C  ON C.RuleId = V.RuleId
				    CROSS APPLY STRING_SPLIT(NotificationTemplate, ',') 
WHERE LoadId = @LoadId
GROUP BY Value
),
SampleSummary AS
(
    Select NumberOfValidationFailuers as NValidationBreaks,
	       NLicenceUpdate,
           NAudioPolicyUpdates,
		   NLicenceFeeBreaks,
           0 AS NAttributeMismatches,
		   convert(varchar(10),getdate(),103) as NDate,
		   @NReportLink as  NReportLink
	FROM Sample1
	Where Template = @TemplateName


)

SELECT  @table =
      (SELECT     
	         *
        FROM SampleSummary
		FOR JSON PATH, INCLUDE_NULL_VALUES);

select  replace(Replace(@table,']',''),'[','') as  [table]







