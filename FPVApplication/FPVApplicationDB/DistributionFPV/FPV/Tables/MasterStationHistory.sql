CREATE TABLE [FPV].[MasterStationHistory] (
    [StationID]                 VARCHAR (20)    NOT NULL,
    [DistributionGroupCode]     VARCHAR (20)    NULL,
    [StationName]               VARCHAR (100)   NULL,
    [StationStatus]             VARCHAR (20)    NULL,
    [GroupAdminRate]            DECIMAL (18, 3) NULL,
    [HedgePercent]              DECIMAL (18, 3) NULL,
    [HedgePercentMCPS]          DECIMAL (18, 3) NULL,
    [PRAdminRate]               DECIMAL (18, 3) NULL,
    [IsExcluded]                BIT             NULL,
    [SysStartTime]              DATETIME2 (7)   NOT NULL,
    [SysEndTime]                DATETIME2 (7)   NOT NULL,
    [CodaCustomerCode]          VARCHAR (50)    NULL,
    [AudioPolicyMain]           VARCHAR (100)   CONSTRAINT [MSh_AudioPolicyMain] DEFAULT ('unknown') NULL,
    [AudioPolicyCommercial]     VARCHAR (100)   CONSTRAINT [MSh_AudioPolicyCommercial] DEFAULT ('unknown') NULL,
    [CommercialSampleDays]      DECIMAL (38, 2) CONSTRAINT [MSh_CommercialSampleDays] DEFAULT ((0)) NULL,
    [NonCommercialSampleDays]   DECIMAL (38, 2) CONSTRAINT [MSh_NonCommercialSampleDays] DEFAULT ((0)) NULL,
    [TotalSampleDays]           DECIMAL (38, 2) CONSTRAINT [MSh_TotalSampleDays] DEFAULT ((0)) NULL,
    [MinimumFee]                DECIMAL (38, 2) CONSTRAINT [LGh_MinimumFee] DEFAULT ((0)) NULL,
    [RegionalParentStationFlag] VARCHAR (100)   CONSTRAINT [MSh_RegionalParentStationFlag] DEFAULT ('Unknown') NULL,
    [RegionalParentStationId]   VARCHAR (100)   CONSTRAINT [MSh_RegionalParentStationId] DEFAULT ('Unknown') NULL,
    [RegionalWeightingPRS]      DECIMAL (12, 5) CONSTRAINT [MSh_RegionalWeightingPRS] DEFAULT ((0)) NULL,
    [RegionalWeightingMCPS]     DECIMAL (12, 5) CONSTRAINT [MSh_RegionalWeightingMCPS] DEFAULT ((0)) NULL,
    [RightTypeCompany]          VARCHAR (10)    CONSTRAINT [CGTh_RightTypeCompany] DEFAULT ('Both') NULL
);


GO

CREATE CLUSTERED INDEX [ix_MasterStationHistory]
    ON [FPV].[MasterStationHistory]([SysEndTime] ASC, [SysStartTime] ASC);
GO

