CREATE TABLE [FPV].[CalculationGroupHistory] (
    [DistributionGroupCode]  VARCHAR (20)  NOT NULL,
    [DistributionCode]       VARCHAR (20)  NOT NULL,
    [Society]                VARCHAR (10)  NOT NULL,
    [CalculationGroupStatus] VARCHAR (20)  NOT NULL,
    [CalculationPeriodStart] DATETIME      NOT NULL,
    [CalculationPeriodEnd]   DATETIME      NOT NULL,
    [UpdatedBy]              VARCHAR (100) NOT NULL,
    [UpdateComment]          VARCHAR (255) NULL,
    [SysStartTime]           DATETIME2 (7) NOT NULL,
    [SysEndTime]             DATETIME2 (7) NOT NULL,
    [Enabled]                BIT           CONSTRAINT [CGTh_Enabled] DEFAULT ((0)) NOT NULL
);




GO
CREATE CLUSTERED INDEX [ix_CalculationGroupHistory]
    ON [FPV].[CalculationGroupHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

