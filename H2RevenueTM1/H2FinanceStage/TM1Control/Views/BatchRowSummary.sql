



CREATE VIEW [TM1Control].[BatchRowSummary]
AS
SELECT 

 [LoadId]
,FileLogUniqueKey as FileKey
,[DerivedFileType]
,[FileName]
,[FileStartPeriodString]
,[FileEndPeriodString]
,[FileRawRowCount]
,[FileModifiedTimeStamp]
,isnull([StagingTotalRows],0) as [StagingTotalRows] 
,isnull([StagingValidStatus], 'Unknown') as [StagingValidStatus]
,isnull([TransformValidRows],0) as [TransformValidRows]
,isnull([TransformValidStatus], 'Unknown') as [TransformValidStatus]
,isnull([ExtractFDMRows],0) as [ExtractFDMRows]
,isnull([ExtractFPVRows],0) as [ExtractFPVRows]
,isnull([ExtractValidStatus], getdate()) as [ExtractValidStatus]
 FROM [TM1Control].[ImportFileLog]