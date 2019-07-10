BEGIN TRANSACTION;

UPDATE [Control].[SourceFile]
   SET [SourceFileName] = 'DoNotUse_'+[SourceFileName],
       [FileExtractedDate] = sysdatetime(),
	   [FileExtractedParentLoadId] = 0,
       [BlobUploadDate] = sysdatetime(),
       [StageDate] = sysdatetime(),
	   [StageParentLoadId] = 0,
	   [CleanDate] = sysdatetime(),
	   [CleanParentLoadId] = 0,
	   [TransformDate] = sysdatetime(),
	   [TransformParentLoadId] = 0,
	   [WarehouseDate] = sysdatetime(),
	   [WarehouseParentLoadId] = 0
WHERE ApplicationId = 1
  AND [SourceFileId] IN (88423,88676); 

COMMIT TRANSACTION;

SELECT *
  FROM [Control].[SourceFile]
 WHERE [ApplicationId] = 1
   AND [SourceFileId] IN (88423,88676);
 
GO
 
