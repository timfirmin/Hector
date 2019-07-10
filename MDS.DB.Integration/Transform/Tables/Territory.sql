CREATE TABLE [Transform].[Territory] (
    [TerritoryKey]  BIGINT       NOT NULL,
    [TerritoryCode] VARCHAR (10) NULL,
    [TerritoryName] VARCHAR (60) NULL,
    [NewRecordFlag] VARCHAR (1)  NULL,
    [LoadId]        INT          NULL,
    [SysStartTime]  DATETIME     NULL,
    [SysEndTime]    DATETIME     NULL
);

