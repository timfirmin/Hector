CREATE PROCEDURE [Control].[ObtainDistributionCodeFromSourceFile]
	@SourceFileId int
AS
BEGIN

	SELECT SourceFileName
	  FROM [Control].[SourceFile]
	 WHERE sourcefileid = @SourceFileId

END