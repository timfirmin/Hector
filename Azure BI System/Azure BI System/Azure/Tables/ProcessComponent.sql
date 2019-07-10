CREATE TABLE [Azure].[ProcessComponent]  
(
	[ProcessId] int NOT NULL,
	[ComponentId] int NOT NULL,
	CONSTRAINT FK_ProcessComponent_Process_ProcessId FOREIGN KEY ([ProcessId]) REFERENCES [Azure].[Process](ProcessId),
	CONSTRAINT FK_ProcessComponent_Component_ComponentId FOREIGN KEY ([ComponentId]) REFERENCES [Azure].[Component](ComponentId)
);

