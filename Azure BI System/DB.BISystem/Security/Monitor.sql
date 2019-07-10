CREATE SCHEMA [Monitor]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[Monitor] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Monitor] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Monitor] TO [prs_subscribed_application];

