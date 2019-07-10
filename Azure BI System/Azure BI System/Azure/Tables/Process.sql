CREATE TABLE [Azure].[Process]  
(
	[ProcessId] int IDENTITY(1,1) NOT NULL,
	[Name] varchar(255) NOT NULL,
	[ApplicationId] int NULL,
	CONSTRAINT PK_Process PRIMARY KEY CLUSTERED (ProcessId)
);

