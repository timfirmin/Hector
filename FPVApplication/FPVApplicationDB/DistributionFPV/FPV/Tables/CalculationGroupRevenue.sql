CREATE TABLE [FPV].[CalculationGroupRevenue] (
    [DistributionGroupCode]     VARCHAR (20)                                NOT NULL,
    [DistributionCode]          VARCHAR (20)                                NOT NULL,
    [Society]                   VARCHAR (10)                                NOT NULL,
    [StationID]                 VARCHAR (20)                                NOT NULL,
    [CodaCustomerCode]          VARCHAR (20)                                NOT NULL,
    [CodaCustomerDescription]   VARCHAR (100)                               CONSTRAINT [CGR_CodaCustomerDescription] DEFAULT ('unknown') NULL,
    [UpdatedBy]                 VARCHAR (100)                               NOT NULL,
    [UpdateComment]             VARCHAR (255)                               NULL,
    [SysStartTime]              DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroupRevenue_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_CalculationGroupRevenue_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [RevenueApportionment]      DECIMAL (18, 3)                             CONSTRAINT [CGR_RevenueApportionment] DEFAULT ((0)) NULL,
    [TotalRevenueApportionment] DECIMAL (18, 3)                             CONSTRAINT [CGR_TotalRevenueApportionment] DEFAULT ((0)) NULL,
    [AnnualMusicMinutes]        DECIMAL (18, 3)                             CONSTRAINT [CGR_AnnualMusicMinutes] DEFAULT ((0)) NULL,
    [MusicUsage]                DECIMAL (18, 3)                             CONSTRAINT [CGR_MusicUsage] DEFAULT ((0)) NULL,
    [MusicConsumption]          DECIMAL (18, 3)                             CONSTRAINT [CGR_MusicConsumption] DEFAULT ((0)) NULL,
    [ConsumptionSplit]          DECIMAL (18, 3)                             CONSTRAINT [CGR_ConsumptionSplit] DEFAULT ((0)) NULL,
    [PercentageSplit]           DECIMAL (18, 3)                             CONSTRAINT [CGR_PercentageSplit] DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
);






GO

