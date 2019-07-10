CREATE VIEW [DDItransform].[vDistributionMissingMinutes]
AS	

SELECT 
	   CAST(HashBytes('SHA1', ISNULL(dmm.[DistributionGroupCode], 'Unknown') + ISNULL(dmm.[DistributionCode], 'Unknown') + ISNULL(dmm.[CompanyCode], 'Unknown') + ISNULL(dmm.[StationCode], 'Unknown')) AS bigint) as DistributionMissingMinutesKey
	  ,CAST(ISNULL(dmm.[DistributionGroupCode], 'Unknown')				AS varchar(50))	as [DistributionGroupCode]
	  ,CAST(ISNULL(dmm.[DistributionCode], 'Unknown')				AS varchar(50))	as [DistributionCode]
	  ,CAST(ISNULL(dmm.[CompanyCode], 'Unknown')					AS varchar(50))	as [CompanyCode]
	  ,CAST(ISNULL(dmm.[StationCode], 'Unknown')					AS varchar(50))	as [StationCode]
	  ,CAST(ISNULL(dmm.[StationName], 'Unknown')					AS varchar(100))	as [StationName]	 
	--  ,ms.Code as MasterStationId
	  
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(MinutesMissingData,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(MinutesMissingData,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as MinutesMissingData
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(MinutesCarryForwards,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(MinutesCarryForwards,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as MinutesCarryForwards
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(MinutesTotal,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(MinutesTotal,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as MinutesTotal
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(RevenueMissingData,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(RevenueMissingData,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as RevenueMissingData
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(RevenueCarryForwards,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(RevenueCarryForwards,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as RevenueCarryForwards
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(RevenueTotal,' ',''),'-','0'),'£','')))) = 1 THEN CAST(ltrim(rtrim(replace(replace(replace(RevenueTotal,' ',''),'-','0'),'£',''))) as decimal(18,3)) ELSE 0 END) as RevenueTotal
 
 	  ,CAST(ISNULL(dmm.[Comment], '')					AS varchar(255))	as [Comment]


	  	,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesMissingData,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as MinutesMissingDataValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesCarryForwards,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as MinutesCarryForwardsValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesTotal,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as MinutesTotalValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueMissingData,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as RevenueMissingDataValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueCarryForwards,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as RevenueCarryForwardsValidYN
		,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueTotal,''),0),' ',''),'-','0'),'£','')))) = 1 THEN 'Y' ELSE 'N' END) as RevenueTotalValidYN

	  	,(CASE WHEN ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesMissingData,''),0),' ',''),'-','0'),'£','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesCarryForwards,''),0),' ',''),'-','0'),'£','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(MinutesTotal,''),0),' ',''),'-','0'),'£','')))) = 1 
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueMissingData,''),0),' ',''),'-','0'),'£','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueCarryForwards,''),0),' ',''),'-','0'),'£','')))) = 1
		AND  ISNUMERIC(ltrim(rtrim(replace(replace(replace(isnull(nullif(RevenueTotal,''),0),' ',''),'-','0'),'£','')))) = 1 
		THEN 'Y' ELSE 'N' END) 	As [StagingRowValidFlag]
      ,dmm.[FileLogKey]
	  --,CONVERT(datetime2, ISNULL(el2.adddate, '31/12/2999'), 103)	AS [xxxDate]	
      ,dmm.[InsertTimeStamp]
      ,dmm.[InsertLoadId]
      ,dmm.[InsertBy]												
  FROM [DDIstaging].[DistributionMissingMinutes] dmm