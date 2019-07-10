CREATE TABLE [Transform].[CodaCustomerCodes] (
    [CustomerCodeKey]  BIGINT        IDENTITY (1, 1) NOT NULL,
    [CustomerCodeCode] VARCHAR (10)  NULL,
    [CustomerCodeName] VARCHAR (250) NULL,
    [NewRecordFlag]    VARCHAR (1)   NULL,
    [LoadId]           INT           NULL,
    [SysStartTime]     DATETIME      NULL,
    [SysEndTime]       DATETIME      NULL
);

