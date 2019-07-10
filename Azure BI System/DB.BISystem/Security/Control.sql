CREATE SCHEMA [Control]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[Control] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Control] TO [prs_subscribed_application];


GO
GRANT INSERT
    ON SCHEMA::[Control] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Control] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Control] TO [prs_reporting_application];


GO
GRANT SELECT
    ON SCHEMA::[Control] TO [prs_reporting_application];

