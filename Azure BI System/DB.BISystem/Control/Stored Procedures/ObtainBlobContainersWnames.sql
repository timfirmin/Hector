

CREATE PROCEDURE [Control].[ObtainBlobContainersWnames]
	@pApplicationCode VARCHAR(80)
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 * exec  [Control].[ObtainBlobContainers] @pApplicationCode  = 'ETLSystem'
 */
	SET NOCOUNT ON;

	SELECT 
		E.[Code] , E.Name
	FROM [Control].[EntityType] AS E
	LEFT JOIN [Control].[Application] AS A
		ON E.ApplicationId = A.ApplicationId
	WHERE A.[Code] = @pApplicationCode
	  AND E.[IsSourceEntity] = 1;


	SET NOCOUNT OFF;
END