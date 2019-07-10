CREATE SCHEMA [Staging]
    AUTHORIZATION [dbo];











GO
GRANT SELECT
    ON SCHEMA::[Staging] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Staging] TO [prs_subscribed_application];


GO
GRANT CONTROL
    ON SCHEMA::[Staging] TO [prs_subscribed_application];


GO
GRANT ALTER
    ON SCHEMA::[Staging] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Staging] TO [prs_reporting_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Staging] TO [prs_reporting_application];

