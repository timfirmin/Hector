
 --------------------------------------------------------------------------
--Created By : Tim Firmin 2018JUN11 ~ FPV Hector 2 Application Project
--Builds FPV DistributionGroup Table
--Last Change : Tim Firmin 2018JUN12 - Output Parameter changed to @pInsertedRowCount
--Test: EXEC FPV.[uspDistributionGroup] @pLoadId = 321, @pInsertedRowCount = 0
 --------------------------------------------------------------------------

CREATE PROCEDURE [FPV].[uspDistributionGroup]
  @pLoadId			int,
  @pInsertedRowCount	bigint OUT
AS
BEGIN
  
   IF OBJECT_ID('FPV.DistributionGroup') IS NOT NULL
	  DROP TABLE FPV.DistributionGroup;
SELECT 
       [Name] as DistributionGroupCode



      ,cast('Licensing Period : ' + [LicensingPeriod] as nvarchar(250)) as Comment
      ,cast(case when [HectorInScope] = 'Y' then 1 else 0 end as bit) as Enabled
	  ,cast([LicensingPeriod] as nvarchar(250)) as [LicensingPeriod]
      ,cast([LicensingPeriodStart] as nvarchar(250)) as [LicensingPeriodStart]
      ,cast([LicensingPeriodEnd] as nvarchar(250)) as [LicensingPeriodEnd]
      ,cast(isnull([HighPeakTimeBandFactor],0) as decimal(18,3)) as [HighPeakTimeBandFactor]
      ,cast(isnull([LowPeakTimeBandFactor],0) as decimal(18,3)) as [LowPeakTimeBandFactor]
      ,cast(isnull([NonPeakTimeBandFactor],0) as decimal(18,3)) as [NonPeakTimeBandFactor]
      ,cast(isnull([DefaultStationAdminRate],0) as decimal(18,3)) as [DefaultStationAdminRate]
      ,cast(isnull([DefaultPRAdminRate],0) as decimal(18,3)) as [DefaultPRAdminRate]
      ,cast(isnull([DefaultPRSHedgedRate],0) as decimal(18,3)) as [DefaultPRSHedgedRate]
      ,cast(isnull([DefaultMCPSHedgedRate],0) as decimal(18,3)) as [DefaultMCPSHedgedRate]
      ,cast(isnull([DefaultBroadcastHours],0) as decimal(18,3)) as [DefaultBroadcastHours]
	  
	  ,@pLoadId as InsertLoadId
	  ,cast(getdate() as datetime2(7)) as InsertTimeStamp
  INTO FPV.DistributionGroup
  FROM [staging].[MasterDistributionGroup]
  WHERE ValidationStatus = 'Validation Succeeded'

	    /* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT

END