CREATE TABLE [FPV].[CalculationGroupStation] (
    [DistributionGroupCode]     VARCHAR (20)                                NOT NULL,
    [DistributionCode]          VARCHAR (20)                                NOT NULL,
    [Society]                   VARCHAR (10)                                NOT NULL,
    [StationID]                 VARCHAR (20)                                NOT NULL,
    [StationName]               VARCHAR (100)                               NOT NULL,
   
    [StationStatus]             VARCHAR (100)                               NOT NULL,
    [GroupAdminRate]            DECIMAL (18, 3)                             NULL,
    [HedgePercent]              DECIMAL (18, 3)                             NULL,
    [HedgePercentMCPS]          DECIMAL (18, 3)                             NULL,
    [PRAdminRate]               DECIMAL (18, 3)                             NULL,
    [IsExcluded]                BIT                                         NULL,
    [UpdatedBy]                 VARCHAR (100)                               NOT NULL,
    [UpdateComment]             VARCHAR (255)                               NULL,
    [SysStartTime]              DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_CalculationGroupStation_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_SCalculationGroupStation_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [FPVStatus]                 VARCHAR (20)                                CONSTRAINT [CGS_FPVStatus] DEFAULT ('PROG') NULL,
    [AudioPolicyMain]           VARCHAR (100)                               CONSTRAINT [CGS_AudioPolicyMain] DEFAULT ('unknown') NULL,
    [AudioPolicyCommercial]     VARCHAR (100)                               CONSTRAINT [CGS_AudioPolicyCommercial] DEFAULT ('unknown') NULL,
    [NonCommercialSampleDays]   DECIMAL (38, 2)                             CONSTRAINT [CGS_NonCommercialSampleDays] DEFAULT ((0)) NULL,
    [TotalSampleDays]           DECIMAL (38, 2)                             CONSTRAINT [CGS_TotalSampleDays] DEFAULT ((0)) NULL,
    [MinimumFee]                DECIMAL (18, 3)                             CONSTRAINT [CGS_MinimumFee] DEFAULT ((0)) NULL,
    [CommercialSampleDays]      DECIMAL (18, 3)                             CONSTRAINT [CGS_CommercialSampleDays] DEFAULT ((0)) NULL,
    [BroadcastHours]            DECIMAL (18, 3)                             CONSTRAINT [CGS_BroadcastHours] DEFAULT ((24)) NULL,
    [LicenceFeeSplitPercent]    DECIMAL (12, 4)                             CONSTRAINT [CGS_LicenceFeeSplitPercent] DEFAULT ((0)) NULL,
    [RegionalParentStationFlag] VARCHAR (100)                               CONSTRAINT [CGS_RegionalParentStationFlag] DEFAULT ('Unknown') NULL,
    [RegionalParentStationId]   VARCHAR (100)                               CONSTRAINT [CGS_RegionalParentStationId] DEFAULT ('Unknown') NULL,
    [RegionalWeightingPRS]      DECIMAL (12, 5)                             CONSTRAINT [CGS_RegionalWeightingPRS] DEFAULT ((0)) NULL,
    [RegionalWeightingMCPS]     DECIMAL (12, 5)                             CONSTRAINT [CGS_RegionalWeightingMCPS] DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([DistributionGroupCode] ASC, [DistributionCode] ASC, [Society] ASC, [StationID] ASC) WITH (IGNORE_DUP_KEY = ON),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[CalculationGroupStationHistory], DATA_CONSISTENCY_CHECK=ON));
GO

