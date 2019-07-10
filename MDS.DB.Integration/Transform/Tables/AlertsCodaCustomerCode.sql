CREATE TABLE [Transform].[AlertsCodaCustomerCode] (
    [ParentLoadId]        BIGINT        NULL,
    [SourceSystem]        VARCHAR (10)  NULL,
    [action]              VARCHAR (10)  NULL,
    [CodaCodeType]        VARCHAR (25)  NULL,
    [CodaCode]            VARCHAR (10)  NULL,
    [CodaCodeDescription] VARCHAR (250) NULL,
    [LoadId]              INT           NULL,
    [SysStartTime]        DATETIME      NULL,
    [SysEndTime]          DATETIME      NULL
);

