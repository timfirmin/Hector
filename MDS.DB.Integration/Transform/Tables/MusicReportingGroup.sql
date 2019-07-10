CREATE TABLE [Transform].[MusicReportingGroup] (
    [MusicReportingGroupKey]  BIGINT        NOT NULL,
    [MusicReportingGroupCode] VARCHAR (250) NULL,
    [MusicReportingGroupName] VARCHAR (250) NULL,
    [NewRecordFlag]           VARCHAR (1)   NULL,
    [LoadId]                  INT           NULL,
    [SysStartTime]            DATETIME      NULL,
    [SysEndTime]              DATETIME      NULL
);

