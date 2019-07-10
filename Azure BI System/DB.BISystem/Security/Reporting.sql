CREATE SCHEMA [Reporting]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Reporting] TO [prs_subscribed_application];

