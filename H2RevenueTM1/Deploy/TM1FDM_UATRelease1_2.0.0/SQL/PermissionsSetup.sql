USE FinanceStage
GO

GRANT ALTER
    ON SCHEMA::[TM1Control] TO [prs_subscribed_application];
GO

GRANT CONTROL
    ON SCHEMA::[TM1Control] TO [prs_subscribed_application];
GO


GRANT ALTER
    ON SCHEMA::[TM1Staging] TO [prs_subscribed_application];
GO

GRANT CONTROL
    ON SCHEMA::[TM1Staging] TO [prs_subscribed_application];
GO

GRANT ALTER
    ON SCHEMA::[TM1Transform] TO [prs_subscribed_application];
GO

GRANT CONTROL
    ON SCHEMA::[TM1Transform] TO [prs_subscribed_application];
GO




  GO

  USE [FinanceDataMart]
    GO

GRANT ALTER
    ON SCHEMA::TM1Reporting TO [prs_subscribed_application];
GO

GRANT CONTROL
    ON SCHEMA::TM1Reporting TO [prs_subscribed_application];
GO

  GO

--  USE [Hector2]
--  GO
--  --CREATE ROLE prs_reporting_application AUTHORIZATION dbo
---- TM1Control, TM1Staging, TM1Transform
--/* Grant Permissions */   ---prs_subscribed_application
--	/* Schemas level */
--	--GRANT SELECT, EXECUTE        	ON SCHEMA::Reporting	    TO prs_reporting_application;
--	GRANT SELECT, CONTROL, EXECUTE	ON SCHEMA::HctrStaging		TO prs_subscribed_application;
--	GRANT ALTER						ON SCHEMA::HctrStaging		TO prs_subscribed_application; --CREATE TABLE

--	/* Database level */
--	GRANT ALTER ANY EXTERNAL DATA SOURCE					TO prs_subscribed_application;
--	GRANT ALTER ANY EXTERNAL FILE FORMAT					TO prs_subscribed_application;
--	GRANT ALTER ANY SCHEMA									TO prs_subscribed_application; 
--	GRANT CONTROL											TO prs_subscribed_application;
--	GRANT CONNECT
	
--												TO prs_subscribed_application;


 