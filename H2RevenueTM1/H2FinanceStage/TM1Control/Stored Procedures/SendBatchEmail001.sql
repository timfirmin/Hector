



CREATE PROCEDURE [TM1Control].[SendBatchEmail001]
  @recipientsSTR NVARCHAR(MAX),
  @profilenameSTR NVARCHAR(MAX),
  @intBatchID INT
AS
BEGIN

--------------------------------------------------------------------------
--Created By : Tim Firmin 2018APR17 ~ BI TM1-Hector2-FDM Project
--Sends out HTML Email with Batch Summary of Last ETL Run
--Last Change : Tim Firmin 2018APR17 - Inserted Warning re Row Validation
--Test001 SingleUser	 : EXEC  [TM1control].[SendBatchEmail001] @recipientsSTR = 'tim.firmin@prsformusic.com', @profilenameSTR = 'AZI-MS-SQL-D002 SQL Database Mail', @intBatchID = 58438    
--------------------------------------------------------------------------
	
DECLARE @tableHTML  NVARCHAR(MAX) ;	
DECLARE @subjectSTR  NVARCHAR(MAX) ;	
DECLARE @environmentSTR  NVARCHAR(MAX) ;	

SET @tableHTML =
 N'<H3>TM1 BI Data Integration Last Batch Summary Report : ' + cast(@intBatchID as varchar(10)) + '</H3>' + 
    
--Summary Row

	N'<table style="border:3px dashed black;font-family:arial;">' +
    N'<font color="black" size="3" face="Verdana">
	<tr></tr>' +
    CAST ( ( SELECT		
						'td/@bgcolor'=CASE left([BatchSummaryMessage],11) WHEN 'Batch Error' THEN 'Tomato' WHEN 'Batch Revie' THEN 'Orange' ELSE 'SpringGreen' END,																																	           
					td = t1.[BatchSummaryMessage], ''
               FROM [TM1Control].[BatchLoadSummary] t1 WHERE [BatchId] = @intBatchID
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</font></table>'  +
	  N'<h5 ><span style="background-color: #FFFF00">Table 1 : TM1 Integrate ~ Summary of Files Loaded</span></h5>' + 
--Table One part 1
	N'<table style="border:1px dashed black;font-family:arial;">' +
    N'<font color="black" size="1" face="Verdana">
	<tr><th>FileKey</th><th>DerivedFileType</th><th>FileName</th><th> </th><th>FileStartPeriod</th><th>FileEndPeriod</th>
	<th> </th><th>RawRowCount</th><th>FileModified</th><th>StagingRows</th><th>StagingStatus</th>
	<th> </th><th>TransformRows</th><th>TransformStatus</th><th> </th><th>ExtractFDMRows</th><th>ExtractFPVRows</th></tr>' +
    CAST ( ( SELECT																																								           
					td = t1.[FileKey], '',    
					td = t1.[DerivedFileType], '',
					td = t1.[FileName], '',
					td = '|', '', 
					td = t1.[FileStartPeriodString], '',
					td = t1.[FileEndPeriodString], '',
					td = '|', '', 
					td = t1.[FileRawRowCount], '',   
					td = t1.[FileModifiedTimeStamp], '',
					td = t1.[StagingTotalRows], '',

					'td/@bgcolor'=CASE WHEN [StagingValidStatus]<>'Y' THEN 'Tomato' ELSE 'SpringGreen' END,
					td = t1.[StagingValidStatus], '',
					td = '|', '', 
					td = t1.[TransformValidRows], '',

					'td/@bgcolor'=CASE WHEN [TransformValidStatus]<>'Y' THEN 'Tomato' ELSE 'SpringGreen' END,
					td = t1.[TransformValidStatus], '',
					td = '|', '', 
					td = t1.[ExtractFDMRows], '',
					td = t1.[ExtractFPVRows], ''
               FROM [TM1Control].[BatchRowSummary] t1 WHERE [LoadId] = @intBatchID
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</font></table><br>'  +

    N'<h5 ><span style="background-color: #FFFF00">Table 2 : TM1 Integrate ~ Summary of File Management</span></h5>' + 

N'<table style="border:1px dashed black;font-family:arial;">' +
    N'<font color="black" size="1" face="Verdana"><tr><th>FileKey</th><th>DerivedFileType</th><th>FileName</th><th> </th><th>FileMovedActionTaken</th><th>FileMovedTimeStamp</th></tr>' +
    CAST ( ( SELECT																								                            																																																													         																														           
					td = t1.[FileKey], '',    
					td = t1.[DerivedFileType], '',
					td = t1.[FileName], '',
					td = '|', '', 
					'td/@bgcolor'=CASE ([FileMovedActionTaken]) WHEN 'Deleted' THEN 'Tomato' WHEN 'Archived' THEN 'Orange' WHEN 'No Move' THEN 'Pink' ELSE 'SpringGreen' END,
					td = t1.[FileMovedActionTaken], '',
					td = t1.[FileMovedTimeStamp], ''
					--Add stuff in for Quarantine	

               FROM [TM1Control].[BatchMoveSummary] t1 WHERE [LoadId] = @intBatchID
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</font></table>' +




	   N'<h5 ><span style="background-color: #FFFF00">Table 3 : TM1 Integrate ~ Last Core Planning Scenario TimeStamps</span></h5>' + 
	   N'<table style="border:1px dashed black;">' +
       N'<font color="black" size="1" face="Verdana"><tr><th>PlanningScenario</th><th> </th><th>FirstArrived</th><th>LastRefreshed</th></tr>' +
    CAST ( ( SELECT  
					td = t1.Scenario, '',
					td = '|', '',  
					'td/@bgcolor'=CASE AlertMe WHEN 'Y' THEN 'Orange' WHEN 'N' THEN 'SpringGreen' ELSE 'White' END,
					td = t1.ScenarioFirstArrivedDate, '', 
					td = t1.ScenarioLastUpdatedDate, ''

              FROM [TM1Control].[BatchLastCalendarArrival] t1 order by 1 
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</font></table>' +



	                 '<H4>End of Batch Summary Email for ' + cast(@intBatchID as varchar(10)) + ' [' + LEFT(CONVERT(VARCHAR, GETDATE(), 120), 16) + ']<br></H4>
                <h5 align="right">TJF 2018APR16 v01</h5><br>' 
--PRINT @tableHTML

SET @environmentSTR = 
	CASE @profilenameSTR
		WHEN 'AZI-MS-SQL-D002 SQL Database Mail' then 'DEV'
		WHEN 'AZI-MS-SIS-D002 SQL Database Mail' then 'DEV'
		WHEN 'AZI-MS-SQL-T001 SQL Database Mail' then 'Test'
		WHEN 'AZI-MS-SIS-T001 SQL Database Mail' then 'Test'
		WHEN 'AZI-MS-SQL-U001 SQL Database Mail' then 'UAT'
		WHEN 'AZI-MS-SIS-U001 SQL Database Mail' then 'UAT'
		WHEN 'AZI-MS-SQL-P001 SQL Database Mail' then 'PRD'
		WHEN 'AZI-MS-SIs-P001 SQL Database Mail' then 'PRD'
	END

SET @subjectSTR = 'TM1 Integration [' + @environmentSTR + '] End of Batch Email ID : ' + cast(@intBatchID as varchar(10)) + ' Date : ' + LEFT(CONVERT(VARCHAR, GETDATE(), 120), 16)



EXEC msdb.dbo.sp_send_dbmail @recipients=@recipientsSTR, --'tim.firmin@prsformusic.com; Vandana.Bangera@prsformusic.com, Ian.Norman@prsformusic.com'
@subject = @subjectSTR,
@profile_name = @profilenameSTR,
@body = @tableHTML,
@body_format = 'HTML'

END