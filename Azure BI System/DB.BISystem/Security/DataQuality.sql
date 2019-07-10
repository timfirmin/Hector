CREATE SCHEMA [DataQuality]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[DataQuality] TO [prs_subscribed_application];


GO
GRANT EXECUTE
    ON SCHEMA::[DataQuality] TO [prs_subscribed_application];


GO
GRANT SELECT
    ON SCHEMA::[DataQuality] TO [prs_subscribed_application];

