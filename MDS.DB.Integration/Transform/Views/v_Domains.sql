CREATE VIEW [Transform].[v_Domains]
AS

SELECT distinct DomainCode,
       DomainName 
FROM [Transform].[Domain]
GO

