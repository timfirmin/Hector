CREATE TABLE [FPV].[ReferenceDataHistory] (
    [RefDataCategory] VARCHAR (100)  NOT NULL,
    [RefDataGroup]    VARCHAR (100)  NOT NULL,
    [RefDataName]     VARCHAR (100)  NOT NULL,
    [RefDataType]     VARCHAR (100)  NOT NULL,
    [RefDataValue]    VARCHAR (2000) NULL,
    [SysStartTime]    DATETIME2 (7)  NOT NULL,
    [SysEndTime]      DATETIME2 (7)  NOT NULL,
    [UsageType]       VARCHAR (100)  NULL
);








GO
CREATE CLUSTERED INDEX [ix_ReferenceDataHistory]
    ON [FPV].[ReferenceDataHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

