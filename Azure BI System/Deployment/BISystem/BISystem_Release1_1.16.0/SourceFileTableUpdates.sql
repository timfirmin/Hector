  Select * FROM Control.SourceFile
  WHERE ApplicationID = 5
  AND IsToBeLoaded = 1

  UPDATE Control.SourceFile

  SET ISToBeloaded = 0
, ISLoaded = 0
    WHERE ApplicationID = 5
  AND IsToBeLoaded = 1

    UPDATE Control.SourceFile

  SET ISToBeloaded = 1

    WHERE ApplicationID = 5
  AND OriginalFileId IN (55572,55573)
  
  --/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP 1000 [SourceFileId]
--      ,[ParentSourceFileId]
--      ,[SourceFileName]
--      ,[SourceFileTypeId]
--      ,[FileExtensionTypeId]
--      ,[ApplicationId]
--      ,[OriginalFileId]
--      ,[ModifiedDate]
--      ,[FileSizeBytes]
--      ,[DataSourceType]
--      ,[IsCompressed]
--      ,[Source]
--      ,[FileExtractedDate]
--      ,[FileExtractedParentLoadId]
--      ,[BlobUploadDate]
--      ,[StageDate]
--      ,[StageParentLoadId]
--      ,[CleanDate]
--      ,[CleanParentLoadId]
--      ,[WarehouseDate]
--      ,[WarehouseParentLoadId]
--      ,[OLAPDate]
--      ,[ArchivePath]
--      ,[ArchiveDate]
--      ,[UnloadFile]
--      ,[FileUnloaded]
--      ,[FileUnloadedDate]
--      ,[LoadId]
--      ,[CreatedBy]
--      ,[CreatedDate]
--      ,[TransformDate]
--      ,[TransformParentLoadId]
--      ,[TotalNoOfUses]
--      ,[32BitStageRequired]
--      ,[MDSDate]
--      ,[ScrubDate]
--      ,[LDSDate]
--      ,[PartitionKey]
--      ,[PurgeFromArchive]
--      ,[ArchivePurged]
--      ,[ArchivePurgedDate]
--      ,[PreStageDate]
--      ,[IsLoaded]
--      ,[IsToBeLoaded]
--      ,[SourceFileType]
--  FROM [Control].[SourceFile]

--  UPDATE 

--  SET SourceFileTypeId = 8 
--  WHERE ApplicationId = 5

  --SELECT * FROM [Control].[SourceFile] WHERE SourceFileId IN (80,81,52090,53353,53706,54212,54979,56240,56710,56822,57645)

  --DELETE  FROM [control].Entity
  --WHERE ApplicationID = 5


