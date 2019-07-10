CREATE SCHEMA [OLAPControl]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[OLAPControl] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[OLAPControl] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[OLAPControl] TO [prs_subscribed_application];


GO
GRANT UPDATE
    ON SCHEMA::[OLAPControl] TO [prs_subscribed_application];

