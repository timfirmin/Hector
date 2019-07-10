CREATE PROCEDURE [Control].[ObtainSourceFileIdForProcess]
	@ProcessStream		VARCHAR(50),
	@ApplicationCode	VARCHAR(80)

AS
BEGIN

	IF (@ProcessStream = 'SRC2STG') -- ommits blob upload
	BEGIN			 
		IF EXISTS (
			SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
				INNER JOIN [Control].SourceFileType sft ON sft.SourceFileTypeId = sf.SourceFileTypeId
				LEFT JOIN [Control].[Application] a ON sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] IS NOT NULL
			  AND [BlobUploadDate] IS NULL
			  AND StageDate IS NULL
			  AND a.[Code] = @ApplicationCode
		)
		BEGIN	
			SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
				INNER JOIN Control.SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
				LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] IS NOT NULL
			  AND [BlobUploadDate] IS NULL
			  AND StageDate IS NULL
			  AND a.[Code] = @ApplicationCode
		END			
		ELSE SELECT 0;
	END;

IF (@ProcessStream = 'EXT2STG')
BEGIN
			 
			IF EXISTS 
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is null
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN Control.SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is null
			AND a.[Code] = @ApplicationCode
			)
			END
			
			ELSE SELECT 0
END

IF (@ProcessStream = 'STG2CLN')

BEGIN
			 IF EXISTS
			 (SELECT TOP (1) SourceFileId 
			 FROM [Control].SourceFile SF
			 INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			 LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			 WHERE [FileExtractedDate] is not null
			 AND [BlobUploadDate] is  not null
			 AND StageDate is not null
			 AND [CleanDate] is null
			AND a.[Code] = @ApplicationCode
			 )
			 
			 BEGIN
			 
			 
			 (SELECT TOP (1) SourceFileId 
			 FROM [Control].SourceFile SF
			 INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			 LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			 WHERE [FileExtractedDate] is not null
			 AND [BlobUploadDate] is  not null
			 AND StageDate is not null
			 AND [CleanDate] is null
			AND a.[Code] = @ApplicationCode
			 )
			 END
			 
			 ELSE SELECT 0
END

IF (@ProcessStream = 'CLN2WAR') 

BEGIN
			IF EXISTS
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND WarehouseDate is null
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND WarehouseDate is null
			AND a.[Code] = @ApplicationCode
			)
			END
			ELSE SELECT 0

END

IF (@ProcessStream = 'STG2DMT') 

BEGIN
			IF EXISTS
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND WarehouseDate is null
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND WarehouseDate is null
			AND a.[Code] = @ApplicationCode
			)
			END
			ELSE SELECT 0

END

IF (@ProcessStream = 'CLN2TRN') 

BEGIN
			IF EXISTS
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND TransformDate is null
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND TransformDate is null
			AND a.[Code] = @ApplicationCode
			)
			END
			ELSE SELECT 0

END

IF (@ProcessStream = 'TRN2WAR') 

BEGIN
			IF EXISTS
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND TransformDate is not null
			AND WarehouseDate is null
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND TransformDate is not null
			AND WarehouseDate is null
			AND a.[Code] = @ApplicationCode
			)
			END
			ELSE SELECT 0

END



IF (@ProcessStream = 'WAR2OLP') 

BEGIN
			IF EXISTS
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND TransformDate is not null
			AND WarehouseDate is not null
			AND OLAPDate is null
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND StageDate is not null
			AND CleanDate is not null
			AND TransformDate is not null
			AND WarehouseDate is not null
			AND OLAPDate is null
			AND a.[Code] = @ApplicationCode
			)
			END
			ELSE SELECT 0

END

IF (@ProcessStream = 'EXT2STGMF') 

BEGIN
			IF EXISTS
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND (StageDate is null
			OR WarehouseDate is null)			
			AND a.[Code] = @ApplicationCode
			)
			
			BEGIN
			
			
			(SELECT TOP (1) SourceFileId 
			FROM [Control].SourceFile SF
			INNER JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
			LEFT JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
			WHERE [FileExtractedDate] is not null
			AND [BlobUploadDate] is  not null
			AND (StageDate is null
			OR WarehouseDate is null)
			AND a.[Code] = @ApplicationCode
			)
			END
			ELSE SELECT 0

END




END

