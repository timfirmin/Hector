USE [SSISDB]
GO

/* Add Proxy Memeber to Roles */
ALTER ROLE [db_datareader] ADD MEMBER [PRS\SQLProxyBIUAT]
GO

ALTER ROLE [ssis_logreader] ADD MEMBER [PRS\SQLProxyBIUAT]
GO

/* Check Setup - Member Roles */
SELECT      dp1.name AS DatabaseRoleName,
            COALESCE(DP2.name, 'No members') AS DatabaseUserName
FROM        sys.database_principals AS dp1
LEFT  JOIN  sys.database_role_members AS drm
      ON    drm.role_principal_id = dp1.principal_id
LEFT  JOIN  sys.database_principals AS dp2
      ON    dp2.principal_id = drm.member_principal_id
WHERE       dp1.type = 'R'
ORDER BY    dp1.name;


  








