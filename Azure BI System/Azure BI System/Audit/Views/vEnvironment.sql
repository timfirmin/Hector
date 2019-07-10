
CREATE VIEW [Audit].[vEnvironment]
AS 
SELECT  
	 [environment_id]
	,[environment_name]
	,[folder_id]
	,[description]
FROM 
	[SSIS].environments;