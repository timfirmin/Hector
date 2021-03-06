
/****** Object:  Schema [notification]    Script Date: 11/07/2018 10:40:43 ******/
DROP SCHEMA IF EXISTS [notification]
GO
/****** Object:  Schema [notification]    Script Date: 11/07/2018 10:40:43 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'notification')
EXEC sys.sp_executesql N'CREATE SCHEMA [notification] AUTHORIZATION dbo'

GO
GRANT EXECUTE ON SCHEMA::[notification] TO [prs_subscribed_application] AS [dbo]
GO
GRANT SELECT ON SCHEMA::[notification] TO [prs_subscribed_application] AS [dbo]
GO
GRANT UPDATE ON SCHEMA::[notification] TO [prs_subscribed_application] AS [dbo]
GO
