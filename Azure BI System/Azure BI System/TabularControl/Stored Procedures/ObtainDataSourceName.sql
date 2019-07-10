CREATE PROCEDURE [TabularControl].[ObtainDataSourceName]
	@ServerConnectionString VARCHAR(128),
	@DatabaseName	VARCHAR(128),
	@DataSourceName VARCHAR(128) OUT
AS
/*
 *	Obtains ObtainDataSourceName string for Database
 */
BEGIN
	SET NOCOUNT ON;

	SELECT TOP (1) @DataSourceName = t.DataSourceName
	FROM [TabularControl].[Database] t
	WHERE t.Name = @DatabaseName
	  AND t.ServerConnectionString = @ServerConnectionString
	ORDER BY t.DatabaseId ASC

	SET NOCOUNT OFF;
END
