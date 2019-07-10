CREATE VIEW [Reporting].[vwExecutionLog]
AS

SELECT     
	 EL.ExecutionLogID
	,EL.TimeStart
	,EL.TimeEnd
	,EL.TimeDataRetrieval
	,EL.TimeProcessing
	,EL.TimeRendering
	,EL.ByteCount
	,EL.[RowCount]
	,EL.ExecutionID
	,EL.TotalExecTime
	,EL.ScalabilityTime_Paging
	,EL.ScalabilityTime_Processing
	,EL.EstMemoryKB_Paging
	,EL.EstMemoryKB_Processing
	,SC.Status
	,RT.Name AS ReportType
	,RQT.Name AS RequestType
	,ST.Name AS SourceType
	,U.UserName
	,U.UserNameShort
	,R.ReportID
	,R.Path
	,R.SPSite
	,R.SPDocLibrary
	,R.ReportNameShort
	,R.Name AS ReportName
	,RA.Action
	,M.InstanceName
	,FT.Format
	,FT.FormatType
	,M.MachineKey
	,RQT.RequestType AS RequestTypeKey
	,ST.SourceType AS SourceTypeKey
	,RA.ActionType
	,R.ReportKey
	,SC.StatusCode
	,U.UserKey
FROM Reporting.ExecutionLogs EL
INNER JOIN Reporting.FormatTypes FT
	ON EL.FormatType = FT.FormatType 
INNER JOIN Reporting.Machines M
	ON EL.MachineKey = M.MachineKey 
INNER JOIN Reporting.ReportActions RA
	ON EL.ActionType = RA.ActionType 
INNER JOIN Reporting.Reports R
	ON EL.ReportKey = R.ReportKey 
INNER JOIN Reporting.ReportTypes RT
	ON R.ReportType = RT.ReportType 
INNER JOIN Reporting.RequestTypes RQT
	ON EL.RequestType = RQT.RequestType 
INNER JOIN Reporting.SourceTypes ST
	ON EL.SourceType = ST.SourceType 
INNER JOIN Reporting.StatusCodes SC
	ON EL.StatusCode = SC.StatusCode 
INNER JOIN Reporting.Users U 
	ON EL.UserKey = U.UserKey
WHERE TimeStart > '2013-09-01 00:00:00.00'
