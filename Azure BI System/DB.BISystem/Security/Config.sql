CREATE SCHEMA [Config]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[Config] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Config] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Config] TO [prs_subscribed_application];

