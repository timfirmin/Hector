CREATE PROCEDURE Secure.InsertDataLakeStoreConfiguration
	@ConfigurationName varchar(255),
	@AdlsAccountName varchar(255),
	@SubscriptionId varchar(255),
	@Domain varchar(255),
	@ClientId varchar(255),
	@ClientSecretKey varchar(255)
AS
/*
 * Inserts Configuration for datalake store
 */
BEGIN
	INSERT INTO Secure.DataLakeStoreConfiguration
	(
		[ConfigurationName],
		[AdlsAccountName],
		[SubscriptionId],
		[Domain],	
		[ClientId],
		[ClientSecretKey],
		[CreatedAt]
	)
	VALUES
	(
		@ConfigurationName,
		@AdlsAccountName,
		@SubscriptionId,
		@Domain,
		@ClientId,
		@ClientSecretKey,
		SYSDATETIME()
	);
END  