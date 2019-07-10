CREATE TABLE [FPV].[InvalidApplicationRequest] (
    [RequestID]      INT            IDENTITY (1, 1) NOT NULL,
    [Request]        NVARCHAR (MAX) NOT NULL,
    [RequestSysTime] DATETIME2 (7)  CONSTRAINT [DF_InvalidApplicationRequest_SysTime] DEFAULT (sysutcdatetime()) NOT NULL,
    PRIMARY KEY CLUSTERED ([RequestID] ASC)
);

