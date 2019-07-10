CREATE SCHEMA [Audit]
    AUTHORIZATION [dbo];


GO
GRANT EXECUTE
    ON SCHEMA::[Audit] TO [prs_subscribed_application];


GO
GRANT INSERT
    ON SCHEMA::[Audit] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Audit] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Audit] TO [prs_reporting_application];


GO
GRANT SELECT
    ON SCHEMA::[Audit] TO [prs_reporting_application];

