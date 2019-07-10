CREATE SCHEMA [Config]
    AUTHORIZATION [dbo];





GO
GRANT SELECT
    ON SCHEMA::[Config] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Config] TO [prs_subscribed_application];


GO
GRANT CONTROL
    ON SCHEMA::[Config] TO [prs_subscribed_application];


GO
GRANT ALTER
    ON SCHEMA::[Config] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Config] TO [prs_reporting_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Config] TO [prs_reporting_application];

