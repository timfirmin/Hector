CREATE SCHEMA [Transform]
    AUTHORIZATION [dbo];

































































GO
GRANT SELECT
    ON SCHEMA::[Transform] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Transform] TO [prs_subscribed_application];


GO
GRANT CONTROL
    ON SCHEMA::[Transform] TO [prs_subscribed_application];


GO
GRANT ALTER
    ON SCHEMA::[Transform] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Transform] TO [prs_reporting_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Transform] TO [prs_reporting_application];

