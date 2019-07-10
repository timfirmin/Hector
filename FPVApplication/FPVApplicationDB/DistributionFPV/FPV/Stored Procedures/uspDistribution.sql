

 --------------------------------------------------------------------------
--Created By : Tim Firmin 2018JUN11 ~ FPV Hector 2 Application Project
--Builds FPV Distribution Table
--Last Change : Tim Firmin 2018JUN12 - Output Parameter changed to @pInsertedRowCount
--Test: EXEC FPV.[uspDistribution] @pLoadId = 321, @pInsertedRowCount = 0
 --------------------------------------------------------------------------

CREATE PROCEDURE [FPV].[uspDistribution]
  @pLoadId			int,
  @pInsertedRowCount	bigint OUT
AS
BEGIN
  
   IF OBJECT_ID('FPV.Distribution') IS NOT NULL
	  DROP TABLE FPV.Distribution;

	  SELECT 

		 mdp.[Code] as DistributionCode
		,mdp.[Name] as DistributionDescription
		,mdp.[MainMini] as DistributionType

		,CASE WHEN CHARINDEX('-', [EndDate],1) = 5 THEN
		SUBSTRING([EndDate],1,4)	ELSE Null END  as DistributionYear

		,CASE WHEN CHARINDEX('-', [StartDate],1) = 5 THEN
		TRY_CONVERT(datetime,convert(datetime,cast(CONCAT(SUBSTRING([StartDate],6,2),'/',SUBSTRING([StartDate],9,2),'/',SUBSTRING([StartDate],1,4)) as date),112))
		ELSE Null END as DistributionStartDate

		,CASE WHEN CHARINDEX('-', [EndDate],1) = 5 THEN
		TRY_CONVERT(datetime,convert(datetime,cast(CONCAT(SUBSTRING([EndDate],6,2),'/',SUBSTRING([EndDate],9,2),'/',SUBSTRING([EndDate],1,4)) as date),112))
		ELSE Null END as DistributionEndDate
	  
		,cast(isnull(mps.[PlanningScenario], 'N/A') as varchar(50)) as DistributionLatestScenario

		,@pLoadId as InsertLoadId
		,cast(getdate() as datetime2(7)) as InsertTimeStamp

	INTO FPV.Distribution

  FROM [staging].[MasterDistributionPeriod] mdp
	LEFT JOIN (select * from [staging].[MasterPlanningScenario] where ScenarioLatestForYearFlag = 'Y') mps on SUBSTRING(mdp.[EndDate],1,4) = mps.PlanningYear
  WHERE MainMini = 'Main'

	    /* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT

END