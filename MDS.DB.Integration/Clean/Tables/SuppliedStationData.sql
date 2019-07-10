CREATE TABLE [Clean].[SuppliedStationData] (
    [SuppliedStationName] VARCHAR (250) NULL,
    [SourceSystem]        VARCHAR (25)  NULL,
    [RejectRow_YN]        VARCHAR (1)   NOT NULL,
    [LoadId]              INT           NULL,
    [SysStartTime]        DATETIME      NULL,
    [SysEndTime]          DATETIME      NULL
);

