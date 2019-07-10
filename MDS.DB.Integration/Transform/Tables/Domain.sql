CREATE TABLE [Transform].[Domain] (
    [DomainKey]     BIGINT       NOT NULL,
    [DomainCode]    VARCHAR (10) NULL,
    [DomainName]    VARCHAR (60) NULL,
    [NewRecordFlag] VARCHAR (1)  NULL,
    [LoadId]        INT          NULL,
    [SysStartTime]  DATETIME     NULL,
    [SysEndTime]    DATETIME     NULL
);

