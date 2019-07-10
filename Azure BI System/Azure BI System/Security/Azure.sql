CREATE SCHEMA [Azure]
    AUTHORIZATION [dbo];






GO



GO
GRANT INSERT
    ON SCHEMA::[Azure] TO [db_azure_logging_agent];


GO
GRANT SELECT
    ON SCHEMA::[Azure] TO [db_subscribed_application];


GO
GRANT INSERT
    ON SCHEMA::[Azure] TO [db_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Azure] TO [db_azure_logging_agent];

