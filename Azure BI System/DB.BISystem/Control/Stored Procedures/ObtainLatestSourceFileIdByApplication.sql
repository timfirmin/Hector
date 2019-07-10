CREATE PROCEDURE [Control].[ObtainLatestSourceFileIdByApplication] 
	@ApplicationCode VARCHAR(80),
	--@ProcessStream VARCHAR(80), could possibly narrow down by Process Stream if Required
	@SourceFileId INT OUT
AS

DECLARE @ApplicationId int
SELECT @ApplicationId = [ApplicationId] FROM [Control].[Application]  WHERE Code = @ApplicationCode

BEGIN
	SET NOCOUNT ON;

	  SET @SourceFileId = (SELECT TOP (1) [SourceFileId] 
	  FROM [Control].[SourceFile]
	  WHERE [ApplicationId] = @ApplicationId 
	  ORDER BY [ModifiedDate] DESC )	

	SET NOCOUNT OFF;
END
