CREATE TABLE [Transform].[MasterUDCAlerts] (
    [MasterUDCDeltaKey]        INT           IDENTITY (1, 1) NOT NULL,
    [UDCCode]                  VARCHAR (60)  NULL,
    [DeltaAction]              VARCHAR (60)  NULL,
    [DeltaMessage]             VARCHAR (240) NULL,
    [UDCDescription]           VARCHAR (240) NULL,
    [UDCInactiveDate]          DATETIME      NULL,
    [MDSUDCDescription]        VARCHAR (240) NULL,
    [MDSUDCInactiveDate]       DATETIME      NULL,
    [LoadId]                   INT           NOT NULL,
    [SysStartTime]             DATETIME      NULL,
    [SysEndTime]               DATETIME      NULL,
    [MDSSyncActionedTimeStamp] DATETIME      NULL,
    [MDSSyncActionedLoadId]    INT           NULL,
    CONSTRAINT [PK_MasterUDCAlerts] PRIMARY KEY CLUSTERED ([MasterUDCDeltaKey] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MasterUDCAlerts]
    ON [Transform].[MasterUDCAlerts]([UDCCode] ASC, [DeltaAction] ASC, [LoadId] ASC) WITH (IGNORE_DUP_KEY = ON);

