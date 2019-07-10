CREATE TABLE [FPV].[MasterStation] (
    [StationID]                 VARCHAR (20)                                NOT NULL,
    [DistributionGroupCode]     VARCHAR (20)                                NULL,
    [StationName]               VARCHAR (100)                               NULL,
    [StationStatus]             VARCHAR (20)                                NULL,
    [GroupAdminRate]            DECIMAL (18, 3)                             NULL,
    [HedgePercent]              DECIMAL (18, 3)                             NULL,
    [HedgePercentMCPS]          DECIMAL (18, 3)                             NULL,
    [PRAdminRate]               DECIMAL (18, 3)                             NULL,
    [IsExcluded]                BIT                                         NULL,
    [SysStartTime]              DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_MasterStation_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]                DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_MasterStation_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [CodaCustomerCode]          VARCHAR (50)                                NULL,
    [AudioPolicyMain]           VARCHAR (100)                               CONSTRAINT [MS_AudioPolicyMain] DEFAULT ('unknown') NULL,
    [AudioPolicyCommercial]     VARCHAR (100)                               CONSTRAINT [MS_AudioPolicyCommercial] DEFAULT ('unknown') NULL,
    [CommercialSampleDays]      DECIMAL (38, 2)                             CONSTRAINT [MS_CommercialSampleDays] DEFAULT ((0)) NULL,
    [NonCommercialSampleDays]   DECIMAL (38, 2)                             CONSTRAINT [MS_NonCommercialSampleDays] DEFAULT ((0)) NULL,
    [TotalSampleDays]           DECIMAL (38, 2)                             CONSTRAINT [MS_TotalSampleDays] DEFAULT ((0)) NULL,
    [MinimumFee]                DECIMAL (38, 2)                             CONSTRAINT [LG_MinimumFee] DEFAULT ('unknown') NULL,
    [RegionalParentStationFlag] VARCHAR (100)                               CONSTRAINT [MS_RegionalParentStationFlag] DEFAULT ('Unknown') NULL,
    [RegionalParentStationId]   VARCHAR (100)                               CONSTRAINT [MS_RegionalParentStationId] DEFAULT ('Unknown') NULL,
    [RegionalWeightingPRS]      DECIMAL (12, 5)                             CONSTRAINT [MS_RegionalWeightingPRS] DEFAULT ((0)) NULL,
    [RegionalWeightingMCPS]     DECIMAL (12, 5)                             CONSTRAINT [MS_RegionalWeightingMCPS] DEFAULT ((0)) NULL,
    [RightTypeCompany]          VARCHAR (10)                                CONSTRAINT [CGT_RightTypeCompany] DEFAULT ('Both') NULL,
    PRIMARY KEY CLUSTERED ([StationID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[MasterStationHistory], DATA_CONSISTENCY_CHECK=ON));




GO
CREATE NONCLUSTERED INDEX [IX_StationIdCodaCustomer]
    ON [FPV].[MasterStation]([StationID] ASC, [CodaCustomerCode] ASC);

