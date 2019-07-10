CREATE SCHEMA [Reporting]
    AUTHORIZATION [dbo];







































GO
GRANT SELECT
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];


GO
GRANT CONTROL
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];


GO
GRANT ALTER
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Reporting] TO [prs_reporting_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Reporting] TO [prs_reporting_application];

