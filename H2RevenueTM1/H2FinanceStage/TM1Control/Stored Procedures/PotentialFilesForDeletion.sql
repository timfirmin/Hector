

--------------------------------------------------------------------------
--Created By : Tim Firmin 2018APR16 ~ TM1 Extact H2 Project
--Files For Deletion TM1
--Last Change : Tim Firmin 2018APR16 - 
--Test001 : EXEC [TM1control].[PotentialFilesForDeletion] @pFilePath = '\\ONP-MS-FSS-DV01\Data\Proj\Hector2\Dev\'
--Test002 :
--------------------------------------------------------------------------

CREATE PROCEDURE [TM1Control].[PotentialFilesForDeletion]
  @pFilePath varchar(150) --   '[SourceFileName] = 'DistributionFilePRS_Extract_30062017'
AS
BEGIN

--DECLARE @PathLocn as varchar(50)
--SET @PathLocn  = '\\ONP-MS-FSS-DV01\Data\Proj\Hector2\Dev\'
 
SELECT  
ifl.FileLogUniqueKey as FileLogKey
,
case when ExtractValidStatus = 'Y'
then
replace(ifl.FilePath, @pFilePath
+ ift.PlanningFileTypeImportFolderName,   @pFilePath
+ ift.PlanningFileTypeProcessedFolderName)
else
replace(ifl.FilePath, @pFilePath
+ ift.PlanningFileTypeImportFolderName,   @pFilePath + ift.PlanningFileTypeArchiveFolderName)
end as ArchivePath
,ift.PlanningFileRetentionDays
,dateadd(day,ift.PlanningFileRetentionDays,CONVERT(DATETIME, ifl.FileCreatedTimeStamp, 103)) as DeleteDateAge
,datediff(day,getdate(),dateadd(day,ift.PlanningFileRetentionDays,CONVERT(DATETIME, ifl.FileCreatedTimeStamp, 103)) ) as DaysUntilDelete
,case when datediff(day,getdate(),dateadd(day,ift.PlanningFileRetentionDays,CONVERT(DATETIME, ifl.FileCreatedTimeStamp, 103)) ) < 1 then 'Y' else 'N' end as DeleteFileFlag
	
 FROM [TM1Control].[ImportFileLog] ifl
 join [TM1Control].[ImportFileType] ift
 on ifl.FileTypeKey = ift.PlanningFileTypeUniqueKey
 WHERE [LoadId] in (select distinct [LoadId]   FROM [TM1Control].[ImportFileLog]   where [ExtractValidStatus] = 'Y')




 END