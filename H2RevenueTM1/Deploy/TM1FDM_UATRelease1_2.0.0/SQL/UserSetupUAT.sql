USE Hector2
GO
/* Map the Proxy account to the Database */
CREATE USER [PRS\SQLProxyBIUAT] FOR LOGIN [PRS\SQLProxyBIUAT]
GO
/* Add Reporting Memeber to Role */
--exec sp_addrolemember 'prs_reporting_application', 'PRSBIDevValidation'

/* Add Proxy Memeber to Role */
exec sp_addrolemember 'prs_subscribed_application', 'PRS\SQLProxyBIUAT'

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





