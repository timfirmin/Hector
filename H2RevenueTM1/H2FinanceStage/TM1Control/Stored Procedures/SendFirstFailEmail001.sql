
CREATE PROCEDURE [TM1control].[SendFirstFailEmail001]
  @recipientsSTR NVARCHAR(MAX),
  @profilenameSTR NVARCHAR(MAX),
  @htmlIN NVARCHAR(MAX),
  @intBatchID INT
AS
BEGIN

--------------------------------------------------------------------------
--Created By : Tim Firmin 2017SEP21 ~ BI Turquoise JV Project
--Sends out HTML Email with First Error Description from SSISDB
--Last Change : Tim Firmin 2017OCT03
--Test001 SingleUser	 : EXEC  [TM1control].[SendFirstFailEmail001] @recipientsSTR = 'tim.firmin@prsformusic.com', @profilenameSTR = 'AZI-MS-SQL-D002 SQL Database Mail', @htmlIN = '<H3>ETL.BIT.ExtractAndReport <br> BITExtract.ExtractTransformToDataMart.dtsx <br> Oct  3 2017  2:35PM <br> FST109 Move Files To Archive Folder:Error: An error occurred with the following error message: "Could not find file \\ONP-MS-FSS-DV01\Data\Proj\Turquoise\Dev\FinancialFiles\InProcess\VATCreditNoteFiles\In\VATCreditNote_PRS_19092017_007.csv.".  </H3>',  @intBatchID = 39518
--------------------------------------------------------------------------

DECLARE @tableHTML  NVARCHAR(MAX) ;	
DECLARE @subjectSTR  NVARCHAR(MAX) ;	

SET @tableHTML =
 N'<h4 ><span style="background-color: #FFFF00">SSIS Failure found for Batch ID : ' + cast(@intBatchID as varchar(10)) + ' [' + LEFT(CONVERT(VARCHAR, GETDATE(), 120), 16) + '] First Error Shown Below..<br></span></h4>' + 
+ @htmlIN

SET @subjectSTR = 'TM1FDM Integration SSIS (1st) Fail Error Batch ID : ' + cast(@intBatchID as varchar(10)) + ' Date : ' + LEFT(CONVERT(VARCHAR, GETDATE(), 120), 16)

EXEC msdb.dbo.sp_send_dbmail @recipients=@recipientsSTR, --'tim.firmin@prsformusic.com; Vandana.Bangera@prsformusic.com, Ian.Norman@prsformusic.com'
@subject = @subjectSTR,
@profile_name = @profilenameSTR,
@body = @tableHTML,
@body_format = 'HTML'

END