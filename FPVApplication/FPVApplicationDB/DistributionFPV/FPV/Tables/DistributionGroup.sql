CREATE TABLE [FPV].[DistributionGroup] (
    [DistributionGroupCode]   NVARCHAR (250)  NULL,
    [Comment]                 NVARCHAR (250)  NULL,
    [Enabled]                 BIT             NULL,
    [LicensingPeriod]         NVARCHAR (250)  NULL,
    [LicensingPeriodStart]    NVARCHAR (250)  NULL,
    [LicensingPeriodEnd]      NVARCHAR (250)  NULL,
    [HighPeakTimeBandFactor]  DECIMAL (18, 3) NULL,
    [LowPeakTimeBandFactor]   DECIMAL (18, 3) NULL,
    [NonPeakTimeBandFactor]   DECIMAL (18, 3) NULL,
    [DefaultStationAdminRate] DECIMAL (18, 3) NULL,
    [DefaultPRAdminRate]      DECIMAL (18, 3) NULL,
    [DefaultPRSHedgedRate]    DECIMAL (18, 3) NULL,
    [DefaultMCPSHedgedRate]   DECIMAL (18, 3) NULL,
    [DefaultBroadcastHours]   DECIMAL (18, 3) NULL,
    [InsertLoadId]            INT             NULL,
    [InsertTimeStamp]         DATETIME2 (7)   NULL
);










GO
CREATE UNIQUE NONCLUSTERED INDEX [PK_DistributionGroup]
    ON [FPV].[DistributionGroup]([DistributionGroupCode] ASC);

