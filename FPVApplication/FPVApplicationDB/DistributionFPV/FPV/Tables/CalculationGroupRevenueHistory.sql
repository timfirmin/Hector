CREATE TABLE [FPV].[CalculationGroupRevenueHistory] (
    [DistributionGroupCode]     VARCHAR (20)    NOT NULL,
    [DistributionCode]          VARCHAR (20)    NOT NULL,
    [Society]                   VARCHAR (10)    NOT NULL,
    [StationID]                 VARCHAR (20)    NOT NULL,
    [CodaCustomerCode]          VARCHAR (20)    NOT NULL,
    [CodaCustomerDescription]   VARCHAR (100)   CONSTRAINT [CGRh_CodaCustomerDescription] DEFAULT ('unknown') NULL,
    [UpdatedBy]                 VARCHAR (100)   NOT NULL,
    [UpdateComment]             VARCHAR (255)   NULL,
    [SysStartTime]              DATETIME2 (7)   NOT NULL,
    [SysEndTime]                DATETIME2 (7)   NOT NULL,
    [RevenueApportionment]      DECIMAL (18, 3) CONSTRAINT [CGRh_RevenueApportionment] DEFAULT ((0)) NULL,
    [TotalRevenueApportionment] DECIMAL (18, 3) CONSTRAINT [CGRh_TotalRevenueApportionment] DEFAULT ((0)) NULL,
    [AnnualMusicMinutes]        DECIMAL (18, 3) CONSTRAINT [CGRh_AnnualMusicMinutes] DEFAULT ((0)) NULL,
    [MusicUsage]                DECIMAL (18, 3) CONSTRAINT [CGRh_MusicUsage] DEFAULT ((0)) NULL,
    [MusicConsumption]          DECIMAL (18, 3) CONSTRAINT [CGRh_MusicConsumption] DEFAULT ((0)) NULL,
    [ConsumptionSplit]          DECIMAL (18, 3) CONSTRAINT [CGRh_ConsumptionSplit] DEFAULT ((0)) NULL,
    [PercentageSplit]           DECIMAL (18, 3) CONSTRAINT [CGRh_PercentageSplit] DEFAULT ((0)) NULL
);






GO


GO

