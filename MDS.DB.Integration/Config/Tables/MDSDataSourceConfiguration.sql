CREATE TABLE [Config].[MDSDataSourceConfiguration](
	[Id]				INT  IDENTITY (1, 1) NOT NULL,
	[MDSEntity]			VARCHAR(50) NOT NULL,
	[DataSource]		VARCHAR(50) NOT NULL,
	[DataSourceType]	VARCHAR(50) NOT NULL	
)
