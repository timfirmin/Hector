  CREATE TABLE Secure.DataLakeStoreConfiguration
  (
	ConfigurationId int identity(1,1) NOT NULL,
	ConfigurationName varchar(255) NOT NULL,
	AdlsAccountName varchar(255) NOT NULL,
	SubscriptionId varchar(255) NOT NULL,
	Domain varchar(255) NOT NULL,	
	ClientId varchar(255) NOT NULL,
	ClientSecretKey varchar(255) NOT NULL,
	CreatedAt datetime2 NOT NULL,
	CONSTRAINT UQ_DataLakeStoreConfiguration_ConfigurationName UNIQUE (ConfigurationName) 
  )