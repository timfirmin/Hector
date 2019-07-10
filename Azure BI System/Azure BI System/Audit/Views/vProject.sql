
CREATE VIEW [Audit].[vProject]
AS
SELECT 
    project_id
   ,folder_id
   ,name
   ,description
   ,project_format_version
   ,deployed_by_sid
   ,deployed_by_name
   ,last_deployed_time
   ,created_time
   ,object_version_lsn
   ,validation_status
   ,last_validation_time
FROM     
   [SSIS].projects;