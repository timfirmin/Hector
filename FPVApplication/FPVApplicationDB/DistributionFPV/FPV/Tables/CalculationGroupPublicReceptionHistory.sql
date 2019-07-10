CREATE TABLE [FPV].[CalculationGroupPublicReceptionHistory] (
    [DistributionGroupCode] VARCHAR (20)    NOT NULL,
    [DistributionCode]      VARCHAR (20)    NOT NULL,
    [Society]               VARCHAR (20)    NOT NULL,
    [StationID]             VARCHAR (20)    NOT NULL,
    [TotalPRAllocation]     DECIMAL (18, 3) NULL,
    [UpdatedBy]             VARCHAR (100)   NULL,
    [UpdateComment]         VARCHAR (255)   NULL,
    [SysStartTime]          DATETIME2 (7)   NOT NULL,
    [SysEndTime]            DATETIME2 (7)   NOT NULL
);






GO
CREATE CLUSTERED INDEX [ix_CalculationGroupPublicReceptionHistory]
    ON [FPV].[CalculationGroupPublicReceptionHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

