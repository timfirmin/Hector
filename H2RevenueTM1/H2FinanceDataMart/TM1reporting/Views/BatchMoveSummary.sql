CREATE VIEW TM1Reporting.[BatchMoveSummary]
as
SELECT [LoadId] as BatchId
      ,[FileKey]
      ,[DerivedFileType]
      ,[FileMovedActionTaken]
      ,[FileName]
      ,[FileMovedTimeStamp]
  FROM [FinanceStage].[TM1Control].[BatchMoveSummary]