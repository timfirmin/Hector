CREATE TABLE [Transform].[AlertsSuppliedStationData] (
    [ParentLoadId]          BIGINT        NULL,
    [SourceSystem]          VARCHAR (10)  NULL,
    [action]                VARCHAR (10)  NULL,
    [SuppliedStationName]   VARCHAR (250) NULL,
    [SuppliedStationSource] VARCHAR (25)  NULL,
    [LoadId]                INT           NULL,
    [SysStartTime]          DATETIME      NULL,
    [SysEndTime]            DATETIME      NULL
);

