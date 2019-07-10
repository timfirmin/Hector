
CREATE PROCEDURE [Secure].[GetBlobConnectionKey]
	@pAzureBlobConnectionKey NVARCHAR(255) OUT
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;

	SET	@pAzureBlobConnectionKey = (SELECT TOP 1 [Value] 
									FROM [Secure].[Configurations]
									ORDER BY ConfigurationId DESC);
   
END
