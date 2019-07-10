CREATE TABLE [Transform].[RightType] (
    [RightTypeKey]  BIGINT       NOT NULL,
    [RightTypeCode] VARCHAR (10) NULL,
    [RightTypeName] VARCHAR (60) NULL,
    [NewRecordFlag] VARCHAR (1)  NULL,
    [LoadId]        INT          NULL,
    [SysStartTime]  DATETIME     NULL,
    [SysEndTime]    DATETIME     NULL
);

