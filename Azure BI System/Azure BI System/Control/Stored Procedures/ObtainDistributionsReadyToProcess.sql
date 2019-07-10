
CREATE PROCEDURE [Control].[ObtainDistributionsReadyToProcess]
	@pApplicationCode nvarchar(50),
	@pSourceFileName nvarchar(255) OUT
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;
	SET @pSourceFileName = (SELECT TOP(1) 
								SF.[SourceFileName] 
							  FROM [Control].[SourceFile] AS SF
						 LEFT JOIN [Control].[Application] AS A
								ON SF.ApplicationId = A.ApplicationId 
							 WHERE SF.[BlobUploadDate] IS NULL
							   AND SF.[StageDate] IS NULL
							   AND SF.[CleanDate] IS NULL
							   AND SF.[WarehouseDate] IS NULL
							   AND A.Code = @pApplicationCode
							   AND NOT EXISTS (SELECT * 
										 	     FROM [Control].[SourceFile] AS SF
										    LEFT JOIN [Control].[Application] AS A
												   ON SF.ApplicationId = A.ApplicationId 
										        WHERE SF.[BlobUploadDate] IS NOT NULL
											   	  AND A.Code = @pApplicationCode
												  AND (
														SF.[StageDate] IS NULL OR
														SF.[CleanDate] IS NULL OR
														SF.[WarehouseDate] IS NULL
													  )
											  )
							ORDER BY [SourceFileName]);

END