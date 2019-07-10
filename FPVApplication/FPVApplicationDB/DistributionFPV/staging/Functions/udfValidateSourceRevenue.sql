CREATE  FUNCTION staging.[udfValidateSourceRevenue] ()


RETURNS TABLE 
AS
RETURN 
(


SELECT [StationID]
      ,[DistributionGroupCode]
      ,[StationName]
      ,case when [CodaCustomerCode] = 'Unknown' then 1 else 0 end as NoCustomerCode
	  ,case when [AccountCodeEL2] is null then 1 else 0 end as NoRevenueAtSource 
	  ,1 as [ValidationResult]
  FROM [staging].[vStation] Stn
  LEFT JOIN 
  (
  SELECT DISTINCT [AccountCodeEL2]
  FROM [staging].[vMasterRevenueByScenario]
  where [PlanningYear] = YEAR(getdate()-5)) Rev on Stn.[CodaCustomerCode] = Rev.[AccountCodeEL2]
  
  where 
   [CodaCustomerCode] = 'Unknown'  or [AccountCodeEL2] is null 


)