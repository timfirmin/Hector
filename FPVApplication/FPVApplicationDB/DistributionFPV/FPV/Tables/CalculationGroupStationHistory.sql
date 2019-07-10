CREATE TABLE [FPV].[CalculationGroupStationHistory] (
    [DistributionGroupCode]     VARCHAR (20)    NOT NULL,
    [DistributionCode]          VARCHAR (20)    NOT NULL,
    [Society]                   VARCHAR (10)    NOT NULL,
    [StationID]                 VARCHAR (20)    NOT NULL,
    [StationName]               VARCHAR (100)   NOT NULL,
    [StationStatus]             VARCHAR (100)   NOT NULL,
    [GroupAdminRate]            DECIMAL (18, 3) NULL,
    [HedgePercent]              DECIMAL (18, 3) NULL,
    [HedgePercentMCPS]          DECIMAL (18, 3) NULL,
    [PRAdminRate]               DECIMAL (18, 3) NULL,
    [IsExcluded]                BIT             NULL,
    [UpdatedBy]                 VARCHAR (100)   NOT NULL,
    [UpdateComment]             VARCHAR (255)   NULL,
    [SysStartTime]              DATETIME2 (7)   NOT NULL,
    [SysEndTime]                DATETIME2 (7)   NOT NULL,
    [FPVStatus]                 VARCHAR (20)    CONSTRAINT [CGSh_FPVStatus] DEFAULT ('PROG') NULL,
    [AudioPolicyMain]           VARCHAR (100)   CONSTRAINT [CGSh_AudioPolicyMain] DEFAULT ('unknown') NULL,
    [AudioPolicyCommercial]     VARCHAR (100)   CONSTRAINT [CGSh_AudioPolicyCommercial] DEFAULT ('unknown') NULL,
    [NonCommercialSampleDays]   DECIMAL (38, 2) CONSTRAINT [CGSh_NonCommercialSampleDays] DEFAULT ((0)) NULL,
    [TotalSampleDays]           DECIMAL (38, 2) CONSTRAINT [CGSh_TotalSampleDays] DEFAULT ((0)) NULL,
    [MinimumFee]                DECIMAL (18, 3) CONSTRAINT [CGSh_MinimumFee] DEFAULT ((0)) NULL,
    [CommercialSampleDays]      DECIMAL (18, 3) CONSTRAINT [CGSh_CommercialSampleDays] DEFAULT ((0)) NULL,
    [BroadcastHours]            DECIMAL (18, 3) CONSTRAINT [CGSh_BroadcastHours] DEFAULT ((24)) NULL,
    [LicenceFeeSplitPercent]    DECIMAL (12, 4) CONSTRAINT [CGSh_LicenceFeeSplitPercent] DEFAULT ((0)) NULL,
    [RegionalParentStationFlag] VARCHAR (100)   CONSTRAINT [CGSh_RegionalParentStationFlag] DEFAULT ('Unknown') NULL,
    [RegionalParentStationId]   VARCHAR (100)   CONSTRAINT [CGSh_RegionalParentStationId] DEFAULT ('Unknown') NULL,
    [RegionalWeightingPRS]      DECIMAL (12, 5) CONSTRAINT [CGSh_RegionalWeightingPRS] DEFAULT ((0)) NULL,
    [RegionalWeightingMCPS]     DECIMAL (12, 5) CONSTRAINT [CGSh_RegionalWeightingMCPS] DEFAULT ((0)) NULL
);
GO

CREATE CLUSTERED INDEX [ix_CalculationGroupStationHistory]
    ON [FPV].[CalculationGroupStationHistory]([SysEndTime] ASC, [SysStartTime] ASC);
GO

