

CREATE PROCEDURE [Control].[WaitGlobalProcessPackageCompletion]
	@LoadProcessShortName varchar(20),
	@StartTime datetime

AS


DECLARE @StatusId int 
SET @StatusId = 0

WAITFOR DELAY '00:00:05'


 SELECT DISTINCT TOP 1 
		@StatusId = LoadStatusId 
	FROM 
		[Audit].[PackageLoad]  
			WHERE  StartTime >=  @StartTime AND LoadStatusId <> 2 AND LoadProcess <> @LoadProcessShortName 
 ORDER BY 
	LoadStatusId ASC 

IF @StatusId = 3  
	BEGIN  

		RAISERROR ('Packages Failed - Warehouse Will not Process - See Package Process Report', 16, 1) WITH SETERROR  
	
	END

ELSE IF COALESCE(@StatusId,0) = 0  
	BEGIN  
		SELECT 
			 COUNT(LoadId) AS PackageCount 
		FROM 
			[Audit].[PackageLoad]  
		WHERE  
			StartTime >  COALESCE((SELECT MAX(EndTime) AS ProcessLast 
									FROM [Audit].[PackageLoad]  
									WHERE  PackageName = 'C2W.Process.dtsx' AND LoadStatusId <> 3)  ,@StartTime) 
			AND ENDTIME IS NOT NULL 
			AND LoadStatusId = 2
		

	END 	
ELSE
BEGIN 
  SELECT -1 AS PackageCount 
END


GO


