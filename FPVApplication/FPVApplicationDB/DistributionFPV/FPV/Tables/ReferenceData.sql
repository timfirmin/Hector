CREATE TABLE [FPV].[ReferenceData] (
    [RefDataCategory] VARCHAR (100)                               NOT NULL,
    [RefDataGroup]    VARCHAR (100)                               NOT NULL,
    [RefDataName]     VARCHAR (100)                               NOT NULL,
    [RefDataType]     VARCHAR (100)                               NOT NULL,
    [RefDataValue]    VARCHAR (2000)                              NULL,
    [SysStartTime]    DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_ReferenceData_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]      DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_ReferenceData_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [UsageType]       VARCHAR (100)                               NULL,
    PRIMARY KEY CLUSTERED ([RefDataCategory] ASC, [RefDataGroup] ASC, [RefDataName] ASC, [RefDataType] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[ReferenceDataHistory], DATA_CONSISTENCY_CHECK=ON));







