


CREATE VIEW [Transform].[v_CodaCodeAlerts]
AS


Select 
       'FDM'  as SourceSystem,
	   (case when NewRecordFlag = 'Y' Then 'New'  Else 'Updated' END ) as [action],
	   'AccountEL2Code' as CodaCodeType,
       CodaAccountCode as CodaCode,
 	   CodaAccountName as CodaCodeDescription,
	   LoadId ,
	   [SysStartTime]
from  [Transform].[CodaAccountEL2Codes]

Union All 

Select 
       'FDM'  as SourceSystem,
	   (case when NewRecordFlag = 'Y' Then 'New'  Else 'Updated' END ) as [action],
	   'CodaCustomerCode' as CodaCodeType,
       CustomerCodeCode  as CodaCode,
 	   CustomerCodeName as CodaCodeDescription,
	   LoadId ,
	   [SysStartTime]
from  [Transform].[CodaCustomerCodes]