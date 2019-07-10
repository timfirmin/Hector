CREATE TABLE [FPV].[MSSQL_TemporalHistoryFor_1376723957] (
    [DistributionGroupCode] VARCHAR (20)    NOT NULL,
    [DistributionCode]      VARCHAR (20)    NOT NULL,
    [Society]               VARCHAR (10)    NOT NULL,
    [StationID]             VARCHAR (20)    NOT NULL,
    [Type]                  VARCHAR (20)    NULL,
    [Revenue]               DECIMAL (18, 3) NULL,
    [UpdatedBy]             VARCHAR (100)   NOT NULL,
    [UpdateComment]         VARCHAR (255)   NULL,
    [SysStartTime]          DATETIME2 (7)   NOT NULL,
    [SysEndTime]            DATETIME2 (7)   NOT NULL,
    [Scenario]              VARCHAR (50)    NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_MSSQL_TemporalHistoryFor_1376723957]
    ON [FPV].[MSSQL_TemporalHistoryFor_1376723957]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

