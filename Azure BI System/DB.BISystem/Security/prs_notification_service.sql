CREATE ROLE [prs_notification_service] AUTHORIZATION [DBO];
GO;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON SCHEMA :: [notification] TO [prs_notification_service];
