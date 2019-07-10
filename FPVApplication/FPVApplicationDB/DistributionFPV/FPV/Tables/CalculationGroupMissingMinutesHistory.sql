CREATE TABLE [FPV].[CalculationGroupMissingMinutesHistory] (
    [DistributionGroupCode] VARCHAR (20)    NOT NULL,
    [DistributionCode]      VARCHAR (20)    NOT NULL,
    [Society]               VARCHAR (20)    NOT NULL,
    [StationID]             VARCHAR (20)    NOT NULL,
    [MissingMinutes]        INT             NULL,
    [CarryForwardsMinutes]  INT             NULL,
    [TotalMinutesToHold]    INT             NULL,
    [MissingRevenue]        DECIMAL (18, 3) NULL,
    [CarryForwardsRevenue]  DECIMAL (18, 3) NULL,
    [TotalRevenueToHold]    DECIMAL (18, 3) NULL,
    [UpdatedBy]             VARCHAR (100)   NOT NULL,
    [UpdateComment]         VARCHAR (255)   NULL,
    [SysStartTime]          DATETIME2 (7)   NOT NULL,
    [SysEndTime]            DATETIME2 (7)   NOT NULL
);








GO
CREATE CLUSTERED INDEX [ix_CalculationGroupMissingMinutesHistory]
    ON [FPV].[CalculationGroupMissingMinutesHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

