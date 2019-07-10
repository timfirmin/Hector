CREATE TABLE [Azure].[Component]  
(
	[ComponentId]	INT IDENTITY(1,1) NOT NULL,
	[Name]			VARCHAR(255) NOT NULL,
	[ResourceGroup] VARCHAR(255) NOT NULL,
	[DatabaseName]	VARCHAR(255) NOT NULL,
	[ServerName]	VARCHAR(255) NOT NULL,
	[ComponentTag]	VARCHAR(255) NULL,
	[TypeId]		INT NOT NULL,
	CONSTRAINT PK_Component PRIMARY KEY CLUSTERED (ComponentId),
	CONSTRAINT FK_Component_ComponentType_typeId FOREIGN KEY ([TypeId]) REFERENCES [Azure].[ComponentType](ComponentTypeId)
);
