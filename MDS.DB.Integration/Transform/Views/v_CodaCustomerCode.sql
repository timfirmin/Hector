
CREATE VIEW [Transform].[v_CodaCustomerCode]
AS

SELECT 
      CustomerCodeCode as  Code	,
      CustomerCodeName as Name

FROM [Transform].[CodaCustomerCodes]