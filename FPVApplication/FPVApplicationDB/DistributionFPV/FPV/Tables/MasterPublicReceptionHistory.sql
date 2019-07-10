CREATE TABLE [FPV].[MasterPublicReceptionHistory] (
    [DistributionGroupCode]      VARCHAR (20)    NOT NULL,
    [DistributionCode]           VARCHAR (20)    NOT NULL,
    [Society]                    VARCHAR (10)    NOT NULL,
    [StationID]                  VARCHAR (20)    NOT NULL,
    [TotalPRAllocation]          DECIMAL (18, 3) NULL,
    [UpdatedBy]                  VARCHAR (100)   NOT NULL,
    [UpdateComment]              VARCHAR (255)   NULL,
    [SysStartTime]               DATETIME2 (7)   NOT NULL,
    [SysEndTime]                 DATETIME2 (7)   NOT NULL,
    [CalculationGroupStationKey] BIGINT          CONSTRAINT [PR_CalculationGroupStationKey] DEFAULT ((-1)) NULL
);








GO
CREATE CLUSTERED INDEX [ix_MasterPublicReceptionHistory]
    ON [FPV].[MasterPublicReceptionHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

