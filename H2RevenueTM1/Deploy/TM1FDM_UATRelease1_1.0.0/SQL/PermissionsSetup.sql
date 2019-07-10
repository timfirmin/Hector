USE [DistributionFPV]

/* Creates Application Role */
CREATE ROLE prs_subscribed_application AUTHORIZATION dbo

--CREATE ROLE prs_reporting_application AUTHORIZATION dbo
-- TM1Control, TM1Staging, TM1Transform
/* Grant Permissions */   ---prs_subscribed_application
	/* Schemas level */
	--GRANT SELECT, EXECUTE        	ON SCHEMA::Reporting	    TO prs_reporting_application;
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::staging		TO prs_subscribed_application;
	GRANT ALTER						ON SCHEMA::staging		TO prs_subscribed_application; --CREATE TABLE
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::FPV		TO prs_subscribed_application;
	GRANT ALTER						ON SCHEMA::FPV		TO prs_subscribed_application; --CREATE TABLE

	/* Database level */
	GRANT ALTER ANY EXTERNAL DATA SOURCE					TO prs_subscribed_application;
	GRANT ALTER ANY EXTERNAL FILE FORMAT					TO prs_subscribed_application;
	GRANT ALTER ANY SCHEMA									TO prs_subscribed_application; 
	GRANT CONTROL											TO prs_subscribed_application;
	GRANT CONNECT											TO prs_subscribed_application;

  GO

  sp_addrolemember prs_subscribed_application, 'PRS\SQLProxyBISysTest'  









