CREATE TABLE [Transform].[AnalogyStation] (
    [AnalogyStationKey]    BIGINT        NOT NULL,
    [Format]               VARCHAR (10)  NULL,
    [FileStationID]        VARCHAR (60)  NULL,
    [FileAnalogyStationID] VARCHAR (60)  NULL,
    [MDSStationName]       VARCHAR (255) NULL,
    [MDSStationCode]       VARCHAR (255) NULL,
    [RecordFlag]           VARCHAR (20)  NULL,
    [LoadId]               INT           NULL,
    [SysStartTime]         DATETIME      NULL,
    [SysEndTime]           DATETIME      NULL
);
GO

