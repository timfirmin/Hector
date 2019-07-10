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

  USE [FinanceDataMart]
    GO

GRANT ALTER
    ON SCHEMA::TM1Reporting TO [prs_subscribed_application];
GO

GRANT CONTROL
    ON SCHEMA::TM1Reporting TO [prs_subscribed_application];
  GO
 