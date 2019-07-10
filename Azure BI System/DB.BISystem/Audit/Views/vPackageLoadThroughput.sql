CREATE VIEW [Audit].[vPackageLoadThroughput]
AS 
SELECT
	 PL.LoadId
	,PL.ParentLoadId
	,PL.PackageName
	,PL.LoadStatusId
	,PL.StartTime
	,PL.EndTime
	,PL.Duration
	,RT.ExtractedRows
	,RT.InsertedRows
	,RT.UpdatedRows
	,RT.DeletedRows
	,RT.ArchivedRows
	,RT.FailedRows
	,RT.BadRows
	,RT.EntityId
	,RT.ProcessStream
	,PL.ExecutionId
	,PL.EnvironmentId
	,PL.ProjectId
	,PL.ExecutionGUID
	,PL.PackageVersionGUID
	,PL.PackageGUID
FROM
	Audit.PackageLoad PL
	LEFT OUTER JOIN Audit.RowThroughput RT
	  ON PL.LoadId = RT.LoadId;
