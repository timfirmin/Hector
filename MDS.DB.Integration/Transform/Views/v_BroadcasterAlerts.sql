








CREATE view [Transform].[v_BroadcasterAlerts]
as
SELECT *
  FROM [Transform].[Broadcaster]
  where (([NewRecordFlag] = 'N' and 
  ( 
  isnull([BroadcasterName],[MDS_BroadcasterName]) <> isnull([MDS_BroadcasterName],[BroadcasterName]) or 
  --isnull([DomainName],[MDS_DomainName]) <> isnull([MDS_DomainName],'Unknown') or 
  --isnull([MCPSLicenceTypeCode],[MDS_MCPSLicenceTypeCode]) <> isnull([MDS_MCPSLicenceTypeCode],'Unknown') or 
  isnull([RightTypeCode],[MDS_RightTypeCode]) <> isnull([MDS_RightTypeCode],'Unknown') or 
  --isnull([TerritoryCode],[MDS_TerritoryCode]) <> isnull([MDS_TerritoryCode],'Unknown') or 
  isnull([CustomerAccountNo],[MDS_CustomerAccountNo]) <> isnull([MDS_CustomerAccountNo],'Unknown') 
  ))

  or [NewRecordFlag] = 'Y')
GO

