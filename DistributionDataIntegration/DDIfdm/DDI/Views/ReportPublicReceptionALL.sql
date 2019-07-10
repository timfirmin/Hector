
create view DDI.ReportPublicReceptionALL
as

SELECT 
	   pr.[DistributionGroupCode]
      ,pr.[DistributionCode]
	  ,dc.[DistributionYear]
	  ,dc.[SortOrder] DistributionOrder
      ,pr.[CompanyCode]
      ,pr.[StationCode]
      ,pr.[StationName]
      ,pr.[MasterStationId]
      ,pr.TotalPRAllocation

  FROM [FinanceDataMart].[DDI].DistributionPublicReception pr
  JOIN [DDI].[DistributionCodes] dc on pr.[DistributionCode] = dc.[DistributionCode]