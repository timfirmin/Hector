-- =============================================
-- Author:		Adatis Consulting
-- Create date: 15-10-2010
-- Description:	A Stored procedure for standard ETL Dashboard Reports : Dataset 'DS_DWLoad'
-- Used In:		*.rdl (Reporting Services Report) 
--Updates:
--	15/12/2010 - JK - Added a date parameter.
--  17/11/2014 - JOC - Correct issue with total packages count.
-- =============================================
CREATE PROCEDURE [Reporting].[ObtainPackageLoadSummary]

	--This will cause the load durations to be pulled back on the day passed in
	@Date DATE
	
AS
BEGIN

SET DATEFORMAT DMY
SET NOCOUNT ON
Declare @ProjectID int = null

declare @$prog varchar(50), 
	@$errno int, 
	@$errmsg varchar(4000), 
	@$proc_section_nm varchar(50),
	@$row_cnt INT,
	@$error_db_name varchar(50), 
	@$CreateUserName varchar(128),   -- last user changed the data 
	@$CreateMachineName varchar(128), -- last machine changes-procedure were run from
	@$CreateSource varchar(128), -- last process that made the changes
	@MaxLoadId INT		

select @$errno = NULL,  @$errmsg = NULL,  @$proc_section_nm = NULL
	,  @$prog = LEFT(object_name(@@procid),50), @$row_cnt = NULL
	, @$error_db_name = db_name();
--=========
BEGIN TRY;
--=========

--DECLARE @Date DATE = '2013-05-16';

	WITH e AS(
		SELECT 
			E.[status]
			,E.[folder_name] + '\' + E.[project_name] + '\' + E.[package_name] AS pkgPath 
		FROM 
			[$(SSISDB)].[catalog].[executions] E
		LEFT JOIN [$(SSISDB)].[catalog].[projects] P 
			ON E.project_name = P.name 
		WHERE 
			CONVERT (DATE, [start_time]) >= @Date 
			AND 
			project_id IN (SELECT DISTINCT project_id FROM Audit.vPackage WHERE Name LIKE '%Process%')
	)
	SELECT
	(SELECT COUNT(1) FROM E) AS AllPackages,
	(SELECT COUNT(1) FROM E WHERE [status] = 4) AS Failed,
	(SELECT COUNT(1) FROM E WHERE [status] = 2) AS Running,
	(SELECT COUNT(1) FROM E WHERE [status] = 7) AS Success,
	(SELECT COUNT(1) FROM E WHERE [status] != 2 AND [status] != 4 AND [status] != 7) AS Others,
	(SELECT COUNT(DISTINCT([pkgPath])) FROM e) AS DistinctRunPackages,
	--(SELECT COUNT(1) FROM [$(SSISDB)].[catalog].[packages]) AS TotalPackages 
	(SELECT COUNT([pkgPath]) FROM e) AS TotalPackages


--========
END TRY

--========

BEGIN CATCH
--===========
set @$errmsg = Left('Error ' +
		CASE
			WHEN @$errno > 0 THEN CAST(@$errno as varchar)
			ELSE Cast(ERROR_NUMBER() as varchar)
		END + 'in proc ' + isnull(@$prog,' ') + ' ' + 
		CASE 
			WHEN @$errno > 0 THEN isnull(@$errmsg,' ') 
			ELSE isnull(@$errmsg,' ') + ISNULL(ERROR_MESSAGE(),'')
		END ,4000);

raiserror (@$errmsg, 16, 1); 

IF (ISNULL(@$errno,0) = 0 )
	set @$errno = ERROR_NUMBER();

END CATCH

SET NOCOUNT OFF; 

RETURN @$errno;

END