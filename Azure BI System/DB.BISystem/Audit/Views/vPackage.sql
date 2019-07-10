
CREATE VIEW [Audit].[vPackage]
AS 	
SELECT 
    MAX([package_id]) AS [package_id]
   ,[project_id]
   ,[name]
   ,[package_guid]
   ,[description]
FROM 
    [SSIS].[packages]
GROUP BY 
    [name]
   ,[package_guid]
   ,[description]
   ,[project_id];
