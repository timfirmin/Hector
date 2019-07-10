CREATE PROCEDURE [Control].[ObtainFilesToUnload]
AS

SET NOCOUNT ON;

SELECT
	SourceFileId
FROM
	Control.SourceFile
WHERE
	UnloadFile = 1
	AND COALESCE(FileUnloaded, 0) = 0;
