CREATE PROCEDURE [Control].[CheckSourceFilesIfStagedInClean]
	@pShouldCleanBlob BIT OUT
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;
	DECLARE @shouldCleanBlob BIT;

	IF EXISTS (SELECT TOP(1) *
			   FROM [Control].[SourceFile] 
			   WHERE [FileExtractedDate] IS NOT NULL
			     AND [BlobUploadDate] IS NOT NULL
			     AND [StageDate] IS NOT NULL
			     AND [CleanDate] IS NOT NULL
			     AND [WarehouseDate] IS NULL
				 ORDER BY [SourceFileName]) 
		SET @shouldCleanBlob = 1; 
	ELSE 
		SET @shouldCleanBlob = 0;

	SET @pShouldCleanBlob = @shouldCleanBlob;
		
END
