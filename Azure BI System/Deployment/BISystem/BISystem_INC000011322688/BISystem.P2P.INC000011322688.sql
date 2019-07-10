UPDATE [Control].[SourceFile]
   SET [CleanParentLoadId] = 72106
 WHERE [SourceFileId] = 11622

 GO

 SELECT [SourceFileId], [CleanParentLoadId]
   FROM [Control].[SourceFile]
  WHERE [SourceFileId] = 11622

GO