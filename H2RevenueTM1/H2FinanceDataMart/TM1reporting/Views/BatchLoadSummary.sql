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