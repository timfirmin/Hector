CREATE USER [ROLE-BI-DEVELOPER] FOR EXTERNAL PROVIDER;
CREATE USER [SQLProxyBIProduction@prsformusic.com] FOR EXTERNAL PROVIDER;

CREATE USER [db_azure_logging_agent] WITH PASSWORD = N'atp{ev~Q|ItqCnur4mfv#XlhmsFT7_&#$!~<GVoAzuqj|mff';
CREATE USER [SSISBIProductionuser] WITH PASSWORD = N'tp{geLN8Uv|ftq71nurm,fn#msFT7_&#$!~<vlVkhozuqHj|';
CREATE USER [SSRSBIOperationsuser] WITH PASSWORD = N'tp{eh#vS|tq~nquY%rmf2vlhmsFT7_&#$!~<Moz?uqTj|mf=';
CREATE USER [SSRSBIProductionuser] WITHOUT LOGIN;

--ROLE MEMBERSHIPS

ALTER ROLE [db_owner] ADD MEMBER [ROLE-BI-DEVELOPER];
GO
ALTER ROLE [db_datareader] ADD MEMBER [ROLE-BI-DEVELOPER];
GO
ALTER ROLE [prs_subscribed_application] ADD MEMBER [SQLProxyBIProduction@prsformusic.com];
GO
ALTER ROLE [prs_subscribed_application] ADD MEMBER [SSISBIProductionuser];

GO
ALTER ROLE [prs_reporting_application] ADD MEMBER [SSRSBIProductionuser];
GO
ALTER ROLE [prs_reporting_application] ADD MEMBER [SSRSBIOperationsuser];

--USER PERMISSIONS
GO
GRANT CONNECT TO [SQLProxyBIProduction@prsformusic.com];
GO
GRANT CONNECT TO [SSISBIProductionuser];
GO
GRANT CONNECT TO [ROLE-BI-DEVELOPER];
GO
GRANT CONNECT TO [db_azure_logging_agent];
GO
GRANT CONNECT TO [ADM-SQLServerAdmin-azp-ms-sql-p003];
GO
GRANT CONNECT TO [SSRSBIProductionuser];
GO
GRANT CONNECT TO [SSRSBIOperationsuser];

GO
GRANT INSERT ON SCHEMA::[Azure] TO [db_azure_logging_agent];