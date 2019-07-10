USE [FinanceStage]
GO
/* Creates Application Role - this bit may already be done  */
--CREATE ROLE prs_subscribed_application AUTHORIZATION dbo

/* Grant Permissions */   ---prs_subscribed_application
	/* Schemas level */
	--GRANT SELECT, EXECUTE        	ON SCHEMA::Reporting	    TO prs_reporting_application;
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::DDIstaging		TO prs_subscribed_application;
	GRANT ALTER						ON SCHEMA::DDIstaging		TO prs_subscribed_application; --CREATE TABLE
	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::DDItransform		TO prs_subscribed_application;
	GRANT ALTER						ON SCHEMA::DDItransform		TO prs_subscribed_application; --CREATE TABLE



	/* Database level - this bit may already be done */
	GRANT ALTER ANY EXTERNAL DATA SOURCE					TO prs_subscribed_application;
	GRANT ALTER ANY EXTERNAL FILE FORMAT					TO prs_subscribed_application;
	GRANT ALTER ANY SCHEMA									TO prs_subscribed_application; 
	GRANT CONTROL											TO prs_subscribed_application;
	GRANT CONNECT											TO prs_subscribed_application;

  GO

  	/* This bit may already be done */
  sp_addrolemember prs_subscribed_application, 'PRS\SQLProxyBIProduction'  
  GO








