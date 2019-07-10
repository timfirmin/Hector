/* Create Application Role */
CREATE ROLE [prs_subscribed_application]
    AUTHORIZATION [dbo];

/* Grant Permisions to Application Role */
GRANT EXECUTE,SELECT ON SCHEMA::Config	TO prs_subscribed_application;
GRANT EXECUTE,SELECT ON SCHEMA::Control	TO prs_subscribed_application;

/* Check Setup - Principal Permissions */
SELECT * 
  FROM sys.database_principals;

SELECT pr.principal_id, pr.name principal_name, pr.type_desc principal_type,   
       pe.state_desc persmission, pe.permission_name,
	   ISNULL(s.[name], ts.[name]) schema_name, t.[name] table_name  
  FROM sys.database_principals AS pr   
  JOIN sys.database_permissions AS pe ON pe.grantee_principal_id = pr.principal_id
  LEFT JOIN sys.schemas as s ON pe.major_id =s.[schema_Id]
  LEFT JOIN sys.tables as t on pe.major_id = t.object_id
  LEFT JOIN sys.schemas as ts ON t.[schema_id] =ts.[schema_Id];

  








