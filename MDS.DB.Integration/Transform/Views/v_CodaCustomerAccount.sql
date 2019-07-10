

CREATE VIEW [Transform].[v_CodaCustomerAccount]
AS

SELECT 
      CodaAccountCode as  Code	,
      MAX(CodaAccountName) as Name

FROM [Transform].[CodaAccountEL2Codes]
Group by CodaAccountCode