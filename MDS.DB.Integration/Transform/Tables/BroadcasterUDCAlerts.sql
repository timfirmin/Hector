CREATE TABLE [Transform].[BroadcasterUDCAlerts] (
    [BroadcasterUDCDeltaKey]       INT           IDENTITY (1, 1) NOT NULL,
    [BroadcasterUDCCode]           VARCHAR (60)  NULL,
    [DeltaAction]                  VARCHAR (60)  NULL,
    [DeltaMessage]                 VARCHAR (240) NULL,
    [StationID]                    VARCHAR (60)  NULL,
    [StationName]                  VARCHAR (60)  NULL,
    [UDCCode]                      VARCHAR (60)  NULL,
    [UDCDescription]               VARCHAR (240) NULL,
    [UDCUsedForPurposeDescription] VARCHAR (240) NULL,
    [UDCTimeBand]                  VARCHAR (60)  NULL,
    [MDSUsedForPurposeDescription] VARCHAR (240) NULL,
    [MDSTimeBand]                  VARCHAR (60)  NULL,
    [LoadId]                       INT           NOT NULL,
    [SysStartTime]                 DATETIME      NOT NULL,
    [SysEndTime]                   DATETIME      NULL,
    [MDSSyncActionedTimeStamp]     DATETIME      NULL,
    [MDSSyncActionedLoadId]        INT           NULL,
    CONSTRAINT [PK_BroadcasterUDCDeltas] PRIMARY KEY CLUSTERED ([BroadcasterUDCDeltaKey] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_BroadcasterUDCDeltas]
    ON [Transform].[BroadcasterUDCAlerts]([BroadcasterUDCCode] ASC, [DeltaAction] ASC, [LoadId] ASC) WITH (IGNORE_DUP_KEY = ON);

