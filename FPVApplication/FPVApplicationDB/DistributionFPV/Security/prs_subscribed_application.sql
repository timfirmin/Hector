CREATE ROLE prs_subscribed_application AUTHORIZATION dbo;
GO
	--GRANT SELECT, EXECUTE        	ON SCHEMA::Reporting	    TO prs_reporting_application;
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::admin		TO prs_subscribed_application;
GO
	GRANT ALTER						ON SCHEMA::admin		TO prs_subscribed_application; --CREATE TABLE
GO
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::Config		TO prs_subscribed_application;
GO
	GRANT ALTER						ON SCHEMA::Config		TO prs_subscribed_application; --CREATE TABLE
GO
GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::FPV			TO prs_subscribed_application;
GO
	GRANT ALTER						ON SCHEMA::FPV			TO prs_subscribed_application; --CREATE TABLE
GO
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::FPV_Public	TO prs_subscribed_application;
GO
	GRANT ALTER						ON SCHEMA::FPV_Public	TO prs_subscribed_application; --CREATE TABLE
GO
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::reporting	TO prs_subscribed_application;
GO
	GRANT ALTER						ON SCHEMA::reporting	TO prs_subscribed_application; --CREATE TABLE
GO
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::staging		TO prs_subscribed_application;
GO
	GRANT ALTER						ON SCHEMA::staging		TO prs_subscribed_application; --CREATE TABLE
GO
	/* Database level */
	GRANT ALTER ANY EXTERNAL DATA SOURCE					TO prs_subscribed_application;
GO
	GRANT ALTER ANY EXTERNAL FILE FORMAT					TO prs_subscribed_application;
GO
	GRANT ALTER ANY SCHEMA									TO prs_subscribed_application; 
GO
	GRANT CONTROL											TO prs_subscribed_application;
GO
	GRANT CONNECT											TO prs_subscribed_application;
GO
  --sp_addrolemember prs_subscribed_application, 'PRS\SQLProxyBIUAT'  --'PRS\SQLProxyBISysTest'  
 