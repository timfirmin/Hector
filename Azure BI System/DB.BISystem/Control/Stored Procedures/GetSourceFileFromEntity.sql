CREATE PROCEDURE [Control].[GetSourceFileFromEntity] @EntityId	INT
AS ---

SET NOCOUNT ON;


SELECT SourceFileid 
FROM Control.ENtity
WHERE EntityId = @EntityId
