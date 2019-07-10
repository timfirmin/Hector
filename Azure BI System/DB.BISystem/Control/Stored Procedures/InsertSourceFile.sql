CREATE PROCEDURE [Control].[InsertSourceFile]
				 @FileName VARCHAR(250),
				 @LoadId int,
				 @ApplicationCode VARCHAR(80),
				 @Source VARCHAR(80),
				 @SourceFileId int OUT

AS


DECLARE @ApplicationId int


SELECT @ApplicationId = [ApplicationId] FROM [Control].[Application]  WHERE Code = @ApplicationCode


IF NOT EXISTS (SELECT (1) FROM [Control].[SourceFile] WHERE [SourceFileName]= @FileName AND ApplicationId = @ApplicationId)
  BEGIN
    INSERT INTO [Control].[SourceFile] (
										[SourceFileName],
										[SourceFileTypeId],
										[ModifiedDate],
										[FileSizeBytes],
										[IsCompressed],
										[Source],
										[UnloadFile],
										[LoadId],
										[ApplicationId]
									   )
       SELECT    @FileName
				,1
				,SYSDATETIME()
				,0 
				,0 
				,@Source
				,0 
				, @LoadId
				, @ApplicationId



  END


  
SET @SourceFileId = (SELECT TOP(1) SourceFileId 
					   FROM [Control].[SourceFile] 
					  WHERE [SourceFileName]= @FileName
					    AND [ApplicationId] = @ApplicationId)
