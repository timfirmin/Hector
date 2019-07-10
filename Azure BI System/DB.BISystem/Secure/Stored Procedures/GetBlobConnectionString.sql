
CREATE PROCEDURE [Secure].[GetBlobConnectionString]
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;

	SELECT TOP 1 [Value] 
	FROM [Secure].[Configurations]
	ORDER BY ConfigurationId DESC;
   
END
