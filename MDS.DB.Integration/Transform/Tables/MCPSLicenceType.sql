CREATE TABLE [Transform].[MCPSLicenceType] (
    [MCPSLicenceKey]  BIGINT        NOT NULL,
    [MCPSLicenceCode] VARCHAR (10)  NULL,
    [MCPSLicenceName] VARCHAR (10)  NULL,
    [Description]     VARCHAR (500) NULL,
    [NewRecordFlag]   VARCHAR (1)   NULL,
    [LoadId]          INT           NULL,
    [SysStartTime]    DATETIME      NULL,
    [SysEndTime]      DATETIME      NULL
);

