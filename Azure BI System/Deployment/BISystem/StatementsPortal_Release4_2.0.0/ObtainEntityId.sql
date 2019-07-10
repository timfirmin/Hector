DROP PROCEDURE [Control].[ObtainEntityId]
GO

-- =============================================
-- Author:		Adatis
-- Create date: 18/03/2013
-- Description:	Gets Entity Id 
-- =============================================
CREATE PROCEDURE [Control].[ObtainEntityId]
	@SourceFileId INT, 
	@EntityName VARCHAR(50),
	@LoadId int = -1, 
	@ParentEntityId INT = NULL   
AS
BEGIN
	SET NOCOUNT ON;

DECLARE @EntityId INT 
DECLARE @EntityTypeId INT 
DECLARE @ApplicationId SMALLINT

SELECT @EntityId = E.EntityId, @ApplicationId = sf.ApplicationId
  FROM [Control].[SourceFile] SF 
  INNER JOIN [Control].[Entity] E ON SF.SourceFileId = E.SourceFileId 
  INNER JOIN [Control].EntityType ET ON E.EntityTypeId = ET.EntityTypeId 
  WHERE ET.Name = @EntityName AND E.SourceFileId = @SourceFileId 

IF COALESCE(@EntityId,0) = 0 
BEGIN 

SELECT @ApplicationId = sf.ApplicationId
  FROM [Control].[SourceFile] SF 
      --added this new line
  WHERE sourcefileid = @SourceFileId

SELECT @EntityTypeId = EntityTypeId 
FROM 
[Control].EntityType
WHERE Name = @EntityName
  AND ApplicationId = @ApplicationId

INSERT INTO [Control].[Entity]
           (
           [SourceFileId]
           ,[EntityTypeId]
		   ,[ApplicationId]
		   ,LoadId
		   ,ParentEntityId)
     VALUES
           (
           @SourceFileId
           ,@EntityTypeId
		   ,@ApplicationId
		   ,@LoadId
		   ,@ParentEntityId)
		SELECT @@Identity AS EntityId
END 

ELSE Select @EntityID AS EntityId 
END
