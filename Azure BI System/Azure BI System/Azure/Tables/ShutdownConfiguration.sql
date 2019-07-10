CREATE TABLE [Azure].[ShutdownConfiguration]
(
	[Id]		INT NOT NULL IDENTITY(1,1),
	[From]		TIME(0) NOT NULL,
	[To]		TIME(0) NOT NULL,
	[CreatedAt] DATETIME2 NOT NULL,
	[IsActive]	BIT NOT NULL,
)
