


CREATE PROCEDURE [Control].[ProcessSourceFile] (@SourceFileName	VARCHAR(100), @SourceFileType NVARCHAR(20), @LoadId INT,  @ApplicationCode VARCHAR(80) = NULL, @SourceFileId INT OUTPUT)  
AS ---

SET NOCOUNT ON;

--DECLARE @SourceFileId INT

DECLARE @ApplicationId int


SELECT @ApplicationId = [ApplicationId] FROM [Control].[Application]  WHERE Code = @ApplicationCode


IF NOT EXISTS(SELECT * FROM CONTROL.SourceFile WHERE SourceFileName = @SourceFileName AND SourceFileType = @SourceFileType)
		INSERT INTO CONTROL.SourceFile(SourceFileName, SourceFileType, ModifiedDate, LoadId, FileSizeBytes, ApplicationId)
		VALUES(@SourceFileName, @SourceFileType, GETDATE(), @LoadId, 0, @ApplicationId)
ELSE
		UPDATE Control.SourceFile
		SET LoadId = @LoadId
		WHERE SourceFileName = @SourceFileName 
		AND SourceFileType = @SourceFileType 

SELECT @SourceFileId = SourceFileId 
FROM Control.SourceFile 
WHERE SourceFileName = @SourceFileName
AND SourceFileType = @SourceFileType
AND ApplicationID = @ApplicationId

--RETURN @SourceFileId

