




 

CREATE VIEW [DDItransform].[vDistributionPublicReception]
AS	
--granularity now at [CustomerCode]
SELECT 
	   CAST(HashBytes('SHA1', ISNULL(dpr.[DistributionGroupCode], 'Unknown') + ISNULL(dpr.[DistributionCode], 'Unknown') + ISNULL(dpr.[CompanyCode], 'Unknown') + ISNULL(dpr.[StationCode], 'Unknown')) AS bigint) as DistributionPublicReceptionKey
	  ,CAST(ISNULL(dpr.[DistributionGroupCode], 'Unknown')				AS varchar(50))	as [DistributionGroupCode]
	  ,CAST(ISNULL(dpr.[DistributionCode], 'Unknown')				AS varchar(50))	as [DistributionCode]
	  ,CAST(ISNULL(dpr.[CompanyCode], 'Unknown')					AS varchar(50))	as [CompanyCode]
	  ,CAST(ISNULL(dpr.[StationCode], 'Unknown')					AS varchar(50))	as [StationCode]
	  ,CAST(ISNULL(dpr.[StationName], 'Unknown')					AS varchar(100))	as [StationName]	 		  
	--,ms.Code as MasterStationId
	   
 
 		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(TotalPRAllocation,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(TotalPRAllocation,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as TotalPRAllocation
 	  ,CAST(ISNULL(dpr.[Comment], '')					AS varchar(255))	as [Comment]
 
  		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(TotalPRAllocation,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as TotalPRAllocationValidYN


      ,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(TotalPRAllocation,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as [StagingRowValidFlag]
      ,dpr.[FileLogKey]
	  --,CONVERT(datetime2, ISNULL(el2.adddate, '31/12/2999'), 103)						AS [xxxDate]	
      ,dpr.[InsertTimeStamp]
      ,dpr.[InsertLoadId]
      ,dpr.[InsertBy]
  FROM [DDIstaging].[DistributionPublicReception] dpr