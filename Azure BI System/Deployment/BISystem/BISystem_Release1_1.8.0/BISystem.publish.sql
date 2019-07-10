ALTER PROCEDURE [Control].[ObtainSourceFileIdForBlobUpload]
	@ApplicationCode nvarchar(80),
	@SourceFileId    int OUT
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;
	SET @SourceFileId = (SELECT TOP(1) SF.[SourceFileId] 
							    FROM [Control].[SourceFile] AS SF
								LEFT JOIN [Control].[Application] AS A
								  ON A.ApplicationId = SF.ApplicationId
							   WHERE SF.[FileExtractedDate] IS NOT NULL
								 AND SF.[BlobUploadDate] IS NULL
								 AND SF.[StageDate] IS NULL
								 AND SF.[CleanDate] IS NULL
								 AND SF.[WarehouseDate] IS NULL
								 AND A.[Code] = @ApplicationCode
                                 AND NOT EXISTS (SELECT * 
												   FROM [Control].[SourceFile] AS SF
                     							   LEFT JOIN [Control].[Application] AS A
						                 			 ON A.ApplicationId = SF.ApplicationId 
												  WHERE [BlobUploadDate] IS NOT NULL
												    AND [FileExtractedDate] IS NOT NULL
												    AND A.[Code] = @ApplicationCode
													AND ([StageDate] IS NULL
													 OR  [CleanDate] IS NULL
													 OR  [WarehouseDate] IS NULL))
							   ORDER BY [SourceFileId]);

  IF @SourceFileId IS NULL
  BEGIN 
    SET @SourceFileId = 0
  END
END
GO