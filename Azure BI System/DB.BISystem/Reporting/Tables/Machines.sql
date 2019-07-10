CREATE TABLE [Reporting].[Machines] (
    [MachineKey]   INT           IDENTITY (100, 1) NOT NULL,
    [InstanceName] NVARCHAR (38) NOT NULL,
    CONSTRAINT [PK_Machines] PRIMARY KEY CLUSTERED ([MachineKey] ASC)
);

