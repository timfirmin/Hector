CREATE TABLE [FPV].[RequestDef] (
    [RequestDefID]  INT           IDENTITY (1, 1) NOT NULL,
    [RequestType]   VARCHAR (255) NOT NULL,
    [RequestEntity] VARCHAR (255) NOT NULL,
    [ProcName]      VARCHAR (255) NULL,
    [ValidateData]  BIT           CONSTRAINT [DF_RequestDef_SysTime] DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([RequestDefID] ASC)
);

