


CREATE view [TM1Control].[BatchLoadSummary]
as
with cte_Summarise
as
(
SELECT TOP 100 PERCENT
    [LoadId]
	,count([FileLogUniqueKey]) as FilesAttemptedforProcess

      ,sum(case when [StagingValidStatus] = 'N' then 1 else 0 end) as StagingNotValid
      ,sum(case when [StagingValidStatus] = 'Y' then 1 else 0 end) as StagingSuccess

      ,sum(case when [TransformValidStatus] = 'N' then 1 else 0 end) as TransformNotValid
      ,sum(case when [TransformValidStatus] = 'Y' then 1 else 0 end) as TransformSuccess

      ,sum(case when [ExtractValidStatus] = 'N' then 1 else 0 end) as ExtractNotValid
      ,sum(case when [ExtractValidStatus] = 'Y' then 1 else 0 end) as ExtractSuccess

  FROM [TM1Control].[ImportFileLog]
  WHERE [StagingValidToLoadFlag] = 'Y'

 GROUP BY [LoadId]
)
SELECT [LoadId] as BatchId
		--Note : Cost File without a Valid Revenue file will not permit Extacting
	   ,case when [FilesAttemptedforProcess] = [ExtractSuccess] then 'Batch Success, Processed ' + cast([ExtractSuccess] as varchar(5)) + ' Files' 	
			else case when [ExtractNotValid] > 0 then 
			'Batch Review, Extract Not Valid / File Not Used for ' + cast([ExtractNotValid]	 as varchar(5)) + ' File(s)'
			else case when [TransformNotValid] > 0 then 
			'Batch Error, Transform Not Valid for ' + cast([TransformNotValid] as varchar(5)) + ' File(s)'
			else case when [StagingNotValid] > 0 then 
			'Batch Error, Staging Not Valid for ' + cast([StagingNotValid] as varchar(5)) + ' File(s)'
	   end end end end as BatchSummaryMessage
      ,[FilesAttemptedforProcess]
      ,[StagingNotValid]
      ,[StagingSuccess]
      ,[TransformNotValid]
      ,[TransformSuccess]
      ,[ExtractNotValid]
      ,[ExtractSuccess]
  FROM cte_Summarise