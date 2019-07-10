CREATE SCHEMA [Secure]
    AUTHORIZATION [dbo];


GO
GRANT EXECUTE
    ON SCHEMA::[Secure] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[Secure] TO [prs_subscribed_application];

