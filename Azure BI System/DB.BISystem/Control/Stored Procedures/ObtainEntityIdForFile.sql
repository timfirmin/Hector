-- =============================================
-- Author:		Adatis
-- Create date: 06/06/2013
-- Description:	Returns an EntityId for the passed in FileId & EntityName. If no rows match the input parameters then the procedure will return 0.
-- =============================================
CREATE PROCEDURE [Control].[ObtainEntityIdForFile]
	@SourceFileId		INT, 
	@EntityTypeName		VARCHAR(50)
AS

SET NOCOUNT ON;

SELECT TOP 1 
	EntityId
FROM
(
	SELECT 
		EntityId
	FROM 
		Control.Entity E
		INNER JOIN Control.EntityType ET 
		  ON E.EntityTypeId = ET.EntityTypeId 
	WHERE 
		SourceFileId = @SourceFileId 
		AND ET.Name = @EntityTypeName
	UNION 
		SELECT 
			0 AS EntityId
) E
ORDER BY
	EntityId DESC;
