-- =============================================
-- Author:		Adatis Consulting
-- Create date: 06/11/2006
-- Description: Verifies that the status of the LoadProcess within the PackageLoad table
--				The Status of Load Processes in which the package is included (except for this load process),
--				or Load Processes in which dependent packages (as defined by PackageDependent) are 
--				included is checked. If any of these Load Processes are status 'In Progress' 
--				then the execution will be declined, as data conflicts may otherwise result from these 
--				Load Processes running.
--				allows the load execution to proceed. 
--				@EnvShortName			-	The ShortName for the environment
--				@ParentLoadID			- optional - the LoadID of the parent package.
--										- required if @LoadProcessShortName is null
--				@LoadProcessShortName	-	The load process that this Package is being requested to run within
--				@PackageID				-	The Package unique identifier
--				@LoadProcessResult output:	
--					1	Decine as LoadProcess In Progress for one or more of this package's Load Processes
--					2	Decline as LoadProcess In Progress for one or more of dependent package's Load Process
--					3	Accept
-- =============================================
CREATE PROCEDURE [Control].[VerifyPackageLoadStatus] 
	@ParentLoadID int = 0, 
	@LoadProcessShortName varchar(20) = NULL, 
	@PackageID uniqueidentifier, 
	@LoadProcessResult int output
AS

DECLARE @StatusCount int, @SystemID int, @EnvironmentID int, @LoadProcessID int

--either @ParentLoadID or @LoadProcessShortName must contain real values for the Load Process to be ascertained
--IF @ParentLoadID = 0 AND @LoadProcessShortName IS NULL
--BEGIN
--	RAISERROR ('Invalid @ParentLoadID, @LoadProcessShortName values in call to uspVerifyPackageLoadStatus', 16, 1) WITH SETERROR;
--	RETURN;
--END


--SELECT @SystemID = SystemID
--FROM vPackageSystem
--WHERE PackageID = @PackageID
--AND EnvironmentID = @EnvironmentID

----catch bad @PackageID values
--IF @SystemID IS NULL
--BEGIN
--	RAISERROR ('Invalid @PackageID, @EnvShortName values in call to uspVerifyPackageLoadStatus', 16, 1) WITH SETERROR;
--	RETURN;
--END

--SELECT @LoadProcessID = dbo.ufnGetLoadProcessID(@PackageID, @EnvironmentID, @ParentLoadID, @LoadProcessShortName)

--catch bad @LoadProcessShortName values
--IF @LoadProcessID IS NULL 
--BEGIN
--	RAISERROR ('Invalid @LoadProcessID value returned from ufnGetLoadProcessID() in call to uspVerifyPackageLoadStatus', 16, 1) WITH SETERROR
--	RETURN;
--END

-- check the Latest status of Load Processes that this package is included within, 
-- except for the intended Load Process
--SELECT @StatusCount = Count(*)
--FROM vPackageLoadProcess plp
--INNER JOIN vLoadProcessPackageStatusLatest lppsl
--	ON plp.LoadProcessID = lppsl.LoadProcessID
--	AND plp.EnvironmentID = lppsl.EnvironmentID
--WHERE plp.PackageID = @PackageID
--AND lppsl.SystemID = @SystemID
--AND lppsl.EnvironmentID = @EnvironmentID
----not this load process!
--AND lppsl.LoadProcessID <> @LoadProcessID
--AND lppsl.LoadStatusTypeShortName = 'In Prog'

-- Decline as LoadProcess In Progress for one or more of this package's Load Processes
--IF @StatusCount > 0
--BEGIN
--	SET @LoadProcessResult = 1
--	RETURN
--END

---- check the Latest status of Load Processes that dependent packages are included within,
---- irrespective of whether they are executing within this Load Process.
--SELECT @StatusCount = Count(*)
--FROM ufnGetPackageDependents(@PackageID, @EnvironmentID)  pd
--INNER JOIN vLoadProcessPackageStatusLatest lppsl
--	ON pd.LoadProcessID = lppsl.LoadProcessID
--	AND pd.EnvironmentID = lppsl.EnvironmentID
--WHERE lppsl.LoadStatusTypeShortName = 'In Prog'

-- Decline as LoadProcess In Progress for one or more of dependent package's Load Process
--IF @StatusCount > 0
--BEGIN
--	SET @LoadProcessResult = 2
--	RETURN
--END

-- Accept
SET @LoadProcessResult = 3
RETURN
