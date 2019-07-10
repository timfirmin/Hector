CREATE SCHEMA [Metadata]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[Metadata] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[Metadata] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Metadata] TO [prs_subscribed_application];

