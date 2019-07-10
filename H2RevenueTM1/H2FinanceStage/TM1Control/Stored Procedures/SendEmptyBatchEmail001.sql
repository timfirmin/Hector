






CREATE PROCEDURE [TM1control].[SendEmptyBatchEmail001]
  @recipientsSTR NVARCHAR(MAX),
  @profilenameSTR NVARCHAR(MAX),
  @intBatchID INT
AS
BEGIN

--------------------------------------------------------------------------
--Created By : Tim Firmin 2017SEP21 ~ BI Turquoise JV Project
--Sends out HTML Email with Batch Summary of Last ETL Run
--Last Change : Tim Firmin 2017SEP21 - Inserted Warning re Row Validation
--Test001 SingleUser	 : EXEC  [TM1control].[SendEmptyBatchEmail001] @recipientsSTR = 'tim.firmin@prsformusic.com', @profilenameSTR = 'AZI-MS-SQL-D002 SQL Database Mail', @intBatchID = 39518
--------------------------------------------------------------------------

DECLARE @tableHTML  NVARCHAR(MAX) ;	
DECLARE @subjectSTR  NVARCHAR(MAX) ;	

SET @tableHTML =
    N'<H3>TM1FDM End of Batch Summary Report : ' + cast(@intBatchID as varchar(10)) + '</H3>' + 
    N'<h4 ><span style="background-color: #FFFF00">No Files Were Processed for Batch Run ID : ' + cast(@intBatchID as varchar(10)) + ' [' + LEFT(CONVERT(VARCHAR, GETDATE(), 120), 16) + ']<br></span></h4>' + 

    N'<h5 align="right">TJF 2018APR12 v01</h5><br>' 
--PRINT @tableHTML

SET @subjectSTR = 'TM1FDM Batch Run with No Activity ID : ' + cast(@intBatchID as varchar(10)) + ' Date : ' + LEFT(CONVERT(VARCHAR, GETDATE(), 120), 16)

EXEC msdb.dbo.sp_send_dbmail @recipients=@recipientsSTR, --'tim.firmin@prsformusic.com; Vandana.Bangera@prsformusic.com, Ian.Norman@prsformusic.com'
@subject = @subjectSTR,
@profile_name = @profilenameSTR,
@body = @tableHTML,
@body_format = 'HTML'

END