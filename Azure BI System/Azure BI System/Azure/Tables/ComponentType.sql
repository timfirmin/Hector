CREATE TABLE [Azure].[ComponentType]
(
	ComponentTypeId INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(100)
	CONSTRAINT PK_ComponentType PRIMARY KEY (ComponentTypeId)
)
