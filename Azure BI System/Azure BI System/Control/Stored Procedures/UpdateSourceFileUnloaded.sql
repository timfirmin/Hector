CREATE PROCEDURE [Control].[UpdateSourceFileUnloaded]
	@SourceFileId		INT
AS

SET NOCOUNT ON;

UPDATE
	Control.SourceFile
SET
	FileUnloaded			= 1,
	FileUnloadedDate		= GETDATE()
WHERE
	SourceFileId = @SourceFileId;