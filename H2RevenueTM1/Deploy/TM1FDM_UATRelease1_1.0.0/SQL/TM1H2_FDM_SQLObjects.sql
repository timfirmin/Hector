/*
Deployment script for FinanceDataMart

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "FinanceDataMart"
:setvar DefaultFilePrefix "FinanceDataMart"
:setvar DefaultDataPath "F:\SQLServerDatabases\"
:setvar DefaultLogPath "G:\SQLServerXLogs\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];

GO
CREATE SCHEMA [TM1reporting]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [TM1reporting].[BatchLoadSummary]...';


GO
CREATE VIEW TM1Reporting.BatchLoadSummary
as
SELECT [BatchId]
      ,[BatchSummaryMessage]
      ,[FilesAttemptedforProcess]
      ,[StagingNotValid]
      ,[StagingSuccess]
      ,[TransformNotValid]
      ,[TransformSuccess]
      ,[ExtractNotValid]
      ,[ExtractSuccess]
  FROM [FinanceStage].[TM1Control].[BatchLoadSummary]
GO
PRINT N'Creating [TM1reporting].[BatchMoveSummary]...';


GO
CREATE VIEW TM1Reporting.[BatchMoveSummary]
as
SELECT [LoadId] as BatchId
      ,[FileKey]
      ,[DerivedFileType]
      ,[FileMovedActionTaken]
      ,[FileName]
      ,[FileMovedTimeStamp]
  FROM [FinanceStage].[TM1Control].[BatchMoveSummary]
GO
PRINT N'Creating [TM1reporting].[BatchRowSummary]...';


GO
CREATE VIEW TM1Reporting.[BatchRowSummary]
as
SELECT [LoadId] as BatchId
      ,[FileKey]
      ,[DerivedFileType]
      ,[FileName]
      ,[FileStartPeriodString]
      ,[FileEndPeriodString]
      ,[FileRawRowCount]
      ,[FileModifiedTimeStamp]
      ,[StagingTotalRows]
      ,[StagingValidStatus]
      ,[TransformValidRows]
      ,[TransformValidStatus]
      ,[ExtractFDMRows]
      ,[ExtractFPVRows]
      ,[ExtractValidStatus]
  FROM [FinanceStage].[TM1Control].[BatchRowSummary]
GO
PRINT N'Creating [TM1reporting].[ImportFileLog]...';


GO

CREATE VIEW [TM1reporting].[ImportFileLog]
as
	SELECT [FileLogUniqueKey]
		  ,[FileRawRowCount]
		  ,[FileCreatedTimeStamp]
		  ,[FileModifiedTimeStamp]
		  ,[FilePath]
		  ,[FileName]
		  ,[FileSource]
		  ,[FileStartPeriodString]
		  ,[FileEndPeriodString]
		  ,[FileStartPeriodSeq]
		  ,[FileEndPeriodSeq]
		  ,[FileTypeKey] as [RevenueFileTypeKey]
		  ,[DerivedFileType]
		  ,[FileSize]
		  ,[SourceFileID]
		  ,[SourceFileInsertTimeStamp]
		  ,[StagingValidToLoadFlag]
		  ,[StagingStartPeriodSeq]
		  ,[StagingEndPeriodSeq]
		  ,[StagingTotalRows]
		  ,[StagingValidValue]
		  ,[StagingValidStatus]
		  ,[StagingTimeStamp]
		  ,[TransformTimeStamp]
		  ,[TransformValidValue]
		  ,[TransformValidRows]
		  ,[TransformValidStatus]
		  ,[ExtractFDMTimeStamp]
		  ,[ExtractFDMValue]
		  ,[ExtractFDMRows]
		  ,[ExtractFPVTimeStamp]
		  ,[ExtractFPVValue]
		  ,[ExtractFPVRows]
		  ,[ExtractValidStatus]
		  ,[FileMovedAtSourceFlag]
		  ,[FileMovedActionTaken]
		  ,[FileMovedTimeStamp]
		  ,[FileMovedDestinationFolder]
		  ,[FileDeletedLoadId]
		  ,[FileDeletedTimeStamp]
		  ,[LoadId]
		  ,[LoadTimeStamp]
	  FROM [FinanceStage].[TM1Control].[ImportFileLog]
GO
PRINT N'Creating [TM1reporting].[PlanningData]...';


GO
CREATE VIEW TM1Reporting.[PlanningData]
as
	SELECT [PlanningDataKey]
      ,[PlanningScenarioKey]
      ,[PlanningFileLogKey]
      ,[PlanningFileTypeKey]
      ,[PlanningCalendarKey]
      ,[PlanningFilePeriodSeq]
      ,[PlanningPeriodFirstDay]
      ,[Company]
      ,[Class]
      ,[Level4]
      ,[Level3]
      ,[Level2]
      ,[Level1]
      ,[EL1Description]
      ,[EL1Code]
      ,[EL2Description]
      ,[EL2Code]
      ,[PlanningPeriod]
      ,[PlanningYear]
      ,[PlanningScenario]
      ,[ValueGBP]
      ,[InsertTimeStamp]
      ,[InsertLoadId]
  FROM [FinanceStage].[TM1Transform].[PlanningData]
GO
PRINT N'Creating [TM1reporting].[DataCheckStagingRevenue]...';


GO




CREATE VIEW [TM1reporting].[DataCheckStagingRevenue]
AS

select 
	Company,	
	RevenueFileTypeName, 
	FinanceSection, 
	[PlanningYear],
	isnull([Budget],0) as [Budget], 
	isnull([Forecast Q1],0) as [ForecastQ1], 
	isnull([Forecast Q2],0) as [ForecastQ2], 
	isnull([Forecast Q3],0) as [ForecastQ3], 
	[StagingLoadId] ,
	[StagingFileName]
from 
(
(
SELECT  
       pec.[Company]
	  ,replace(ift.PlanningFileTypeName, 'Data','') as RevenueFileTypeName 
      ,pec.Level2 as FinanceSection
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,pec.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [FinanceStage].[TM1Staging].[PlanningExtractRevenue] pec

JOIN [FinanceStage].[TM1Control].[ImportFileLog] ifl on pec.FileLogUniqueKey = ifl.[FileLogUniqueKey]
JOIN [FinanceStage].[TM1Control].[PlanningScenario] ps on pec.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [FinanceStage].[TM1Control].[ImportFileType] ift on pec.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY 
	   pec.[Company]
	  ,ift.PlanningFileTypeName
      ,pec.Level2
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
      ,pec.[InsertLoadId]
	  ,ifl.[FileName]
)) PivotBase
PIVOT
(SUM(ScenarioYearValue) FOR 
[PlanningScenario] IN ([Budget], [Forecast Q1], [Forecast Q2], [Forecast Q3])
) AS PivotTable;
GO
PRINT N'Creating [TM1reporting].[DataCheckStagingCosts]...';


GO




   --    ,pec.[BusinessUnit] as Class
   --   ,pec.[SubBusinessUnit] as Level4
   --   ,pec.[Category] as Level3
   --   ,pec.[Mapping] as Level2
	  --,'Costs' as Level1

CREATE VIEW [TM1reporting].[DataCheckStagingCosts]
AS

select 
	Company,	
	RevenueFileTypeName, 
	FinanceSection, 
	[PlanningYear],
	isnull([Budget],0) as [Budget], 
	isnull([Forecast Q1],0) as [ForecastQ1], 
	isnull([Forecast Q2],0) as [ForecastQ2], 
	isnull([Forecast Q3],0) as [ForecastQ3], 
	[StagingLoadId] ,
	[StagingFileName]
from 
(
(
SELECT  
       pec.[Company]
	  ,replace(ift.PlanningFileTypeName, 'Data','') as RevenueFileTypeName 
      ,pec.Mapping as FinanceSection
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,pec.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [FinanceStage].[TM1Staging].[PlanningExtractCosts] pec

JOIN [FinanceStage].[TM1Control].[ImportFileLog] ifl on pec.FileLogUniqueKey = ifl.[FileLogUniqueKey]
JOIN [FinanceStage].[TM1Control].[PlanningScenario] ps on pec.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [FinanceStage].[TM1Control].[ImportFileType] ift on pec.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY 
	   pec.[Company]
	  ,ift.PlanningFileTypeName
      ,pec.Mapping
      ,pec.[PlanningScenario]
      ,pec.[PlanningYear]
      ,pec.[InsertLoadId]
	  ,ifl.[FileName]
)) PivotBase
PIVOT
(SUM(ScenarioYearValue) FOR 
[PlanningScenario] IN ([Budget], [Forecast Q1], [Forecast Q2], [Forecast Q3])
) AS PivotTable;
GO
PRINT N'Creating [TM1reporting].[DataCheckTransform]...';


GO




CREATE VIEW [TM1reporting].[DataCheckTransform]
AS

select 
	Company,	
	RevenueFileTypeName, 
	FinanceSection, 
	[PlanningYear],
	isnull([Budget],0) as [Budget], 
	isnull([Forecast Q1],0) as [ForecastQ1], 
	isnull([Forecast Q2],0) as [ForecastQ2], 
	isnull([Forecast Q3],0) as [ForecastQ3], 
	[StagingLoadId] ,
	[StagingFileName]
from 
(
(
SELECT
       ods.[Company]
	  ,replace(ift.PlanningFileTypeName, 'Data','') as RevenueFileTypeName 
      ,ods.Level2 as FinanceSection
      ,ods.[PlanningScenario]
      ,ods.[PlanningYear]
	  ,sum([ValueGBP]) as ScenarioYearValue
	  ,ods.[InsertLoadId] as StagingLoadId
	  ,ifl.[FileName] as StagingFileName

  FROM [FinanceStage].[TM1Transform].[PlanningData] ods

JOIN [FinanceStage].[TM1Control].[ImportFileLog] ifl on ods.PlanningFileLogKey = ifl.[FileLogUniqueKey]
JOIN [FinanceStage].[TM1Control].[PlanningScenario] ps on ods.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
JOIN [FinanceStage].[TM1Control].[ImportFileType] ift on ods.PlanningFileTypeKey = ift.PlanningFileTypeUniqueKey

WHERE [PlanningScenarioValidFDM] = 'Y'

GROUP BY
       ods.[Company]
	  ,ift.PlanningFileTypeName
      ,ods.Level2 
      ,ods.[PlanningScenario]
      ,ods.[PlanningYear]
	  ,ods.[InsertLoadId] 
	  ,ifl.[FileName] 
)) PivotBase
PIVOT
(SUM(ScenarioYearValue) FOR 
[PlanningScenario] IN ([Budget], [Forecast Q1], [Forecast Q2], [Forecast Q3])
) AS PivotTable;
GO
PRINT N'Creating Permission...';

 

GO
PRINT N'Update complete.';


GO
