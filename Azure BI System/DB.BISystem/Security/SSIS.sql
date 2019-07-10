CREATE SCHEMA [SSIS]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[SSIS] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[SSIS] TO [prs_subscribed_application];


GO
GRANT INSERT
    ON SCHEMA::[SSIS] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[SSIS] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[SSIS] TO [prs_reporting_application];

