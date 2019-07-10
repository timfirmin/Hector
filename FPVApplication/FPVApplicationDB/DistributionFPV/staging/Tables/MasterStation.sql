CREATE TABLE [staging].[MasterStation] (
    [Code]                      NVARCHAR (250)  NULL,
    [DistributionGroup]         NVARCHAR (250)  NULL,
    [LicencedStatus]            NVARCHAR (250)  NULL,
    [ExcludeFromFPV]            NVARCHAR (250)  NULL,
    [RightType]                 NVARCHAR (250)  NULL,
    [AudioPolicy]               NVARCHAR (100)  NULL,
    [AudioPolicyCommercial]     NVARCHAR (100)  NULL,
    [CodaCustomerCode]          NVARCHAR (100)  NULL,
    [StationAdminRate]          DECIMAL (38, 2) NULL,
    [PublicReceptionAdminRate]  DECIMAL (38, 2) NULL,
    [PRSHedgedRate]             DECIMAL (38, 2) NULL,
    [MCPSHedgedRate]            DECIMAL (38, 2) NULL,
    [Name]                      NVARCHAR (250)  NULL,
    [CommercialSampleDays]      DECIMAL (38, 2) NULL,
    [NonCommercialSampleDays]   DECIMAL (38, 2) NULL,
    [TotalSampleDays]           DECIMAL (38, 2) NULL,
    [MinimumFee]                DECIMAL (38, 2) NULL,
    [RegionalParentStationFlag] NVARCHAR (100)  NULL,
    [RegionalParentStationId]   NVARCHAR (250)  NULL,
    [RegionalWeightingPRS]      DECIMAL (12, 5) NULL,
    [RegionalWeightingMCPS]     DECIMAL (12, 5) NULL,
    [EnterDateTime]             DATETIME2 (7)   NULL,
    [LastChgDateTime]           DATETIME2 (7)   NULL,
    [InsertLoadId]              INT             NULL,
    [InsertTimeStamp]           DATETIME2 (7)   CONSTRAINT [DF_MasterStation_InsertTimeStamp] DEFAULT (getdate()) NULL
);
GO

