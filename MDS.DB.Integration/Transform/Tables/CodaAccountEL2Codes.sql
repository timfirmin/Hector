CREATE TABLE [Transform].[CodaAccountEL2Codes] (
    [CodaAccountKey]  BIGINT        IDENTITY (1, 1) NOT NULL,
    [CodaAccountCode] VARCHAR (10)  NULL,
    [CodaAccountName] VARCHAR (250) NULL,
    [NewRecordFlag]   VARCHAR (1)   NULL,
    [LoadId]          INT           NULL,
    [SysStartTime]    DATETIME      NULL,
    [SysEndTime]      DATETIME      NULL
);

