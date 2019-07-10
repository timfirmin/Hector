CREATE PROCEDURE Secure.GetDataLakeStoreConfiguration
	@ConfigurationName varchar(255)
AS
/*
 * Gets Configuration for data lake store
 */
BEGIN
	SELECT
		[ConfigurationId],
		[ConfigurationName],
		[AdlsAccountName],
		[SubscriptionId],
		[Domain],	
		[ClientId],
		[ClientSecretKey],
		[CreatedAt]
	FROM Secure.DataLakeStoreConfiguration
	WHERE [ConfigurationName] = @ConfigurationName
END