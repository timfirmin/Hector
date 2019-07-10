




 
CREATE VIEW [TM1Control].[BatchMoveSummary]
as

SELECT 

 [LoadId]
,FileLogUniqueKey as FileKey
,[DerivedFileType]
,isnull([FileMovedActionTaken],'No Move') as [FileMovedActionTaken]
,isnull([FileName],'No Move') as [FileName]
,isnull([FileMovedTimeStamp],getdate()) as [FileMovedTimeStamp]

 FROM [TM1Control].[ImportFileLog]

 UNION

 SELECT 

max([FileDeletedLoadId]) as [LoadId]
,max(FileLogUniqueKey) as FileKey
,max([DerivedFileType]) as [DerivedFileType]
,'Deleted' as [FileMovedActionTaken]
,isnull([FileName],'Unknown') as [FileName]
,max([FileDeletedTimeStamp]) as [FileMovedTimeStamp]

 FROM [TM1Control].[ImportFileLog]
 WHERE [FileDeletedLoadId] is not null
 GROUP BY isnull([FileName],'Unknown')