USE [BISystemDev]
GO
/****** Object:  StoredProcedure [Control].[ObtainSourceFileId]    Script Date: 22/12/2016 09:50:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Firmin PRS For Music
-- Create date: 22/12/2016
-- Description:	Gets SourceFileId by Application and Current Process
-- Test:		EXEC	@return_value = [Control].[ObtainLatestSourceFileIdByApplication]		@ApplicationCode = N'CODA',		@SourceFileId = @SourceFileId OUTPUT  SELECT	@SourceFileId as N'@SourceFileId'
-- =============================================
CREATE PROCEDURE [Control].[ObtainLatestSourceFileIdByApplication] 
	@ApplicationCode VARCHAR(80),
	--@ProcessStream VARCHAR(80), could possibly narrow down by Process Stream if Required
	@SourceFileId INT OUT
AS

DECLARE @ApplicationId int
SELECT @ApplicationId = [ApplicationId] FROM [Control].[Application]  WHERE Code = @ApplicationCode

BEGIN
	SET NOCOUNT ON;

	--IF @ProcessStream = 'FILE2EXT'
	--BEGIN
  SET @SourceFileId = (SELECT TOP (1) [SourceFileId] 
  FROM [Control].[SourceFile]
  WHERE [ApplicationId] = @ApplicationId 
  ORDER BY [ModifiedDate] DESC )	
   --END

	SET NOCOUNT OFF;
END
