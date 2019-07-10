CREATE PROCEDURE [Azure].[GetComponentsByType]
	@ComponentTypeName VARCHAR(100)
AS
BEGIN
	SELECT
		c.[ResourceGroup],
		c.[DatabaseName],
		c.[ServerName]
	FROM Azure.Component c
	JOIN Azure.ComponentType ct ON ct.[ComponentTypeId] = c.[TypeId]
	WHERE ct.[Name] = @ComponentTypeName
END;