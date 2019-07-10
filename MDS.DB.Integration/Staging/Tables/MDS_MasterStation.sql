CREATE TABLE [Staging].[MDS_MasterStation] (
    [ID]                       INT             IDENTITY (1, 1) NOT NULL,
    [LoadId]                   INT             NULL,
    [Code]                     NVARCHAR (250)  NULL,
    [Name]                     NVARCHAR (250)  NULL,
    [NewCode]                  NVARCHAR (250)  NULL,
    [DistributionGroup]        NVARCHAR (250)  NULL,
    [LicencedStatus]           NVARCHAR (250)  NULL,
    [ExcludeFromFPV]           NVARCHAR (250)  NULL,
    [CodaCustomerCode]         NVARCHAR (250)  NULL,
 
    [RightType]                NVARCHAR (250)  NULL,
    [AudioPolicy]              NVARCHAR (250)  NULL,
    [AudioPolicyCommercial]    NVARCHAR (250)  NULL,
    [StationAdminRate]         NVARCHAR (250)  NULL,
    [PublicReceptionAdminRate] NVARCHAR (250)  NULL,
    [PRSHedgedRate]            NVARCHAR (250)  NULL,
    [MCPSHedgedRate]           NVARCHAR (250)  NULL,
    [MinimumFee]               DECIMAL (38, 2) NULL,
    [BR3Licence]               DECIMAL (38, 2) NULL,
    [CommercialSampleDays]     DECIMAL (38)    NULL,
    [NonCommercialSampleDays]  DECIMAL (38)    NULL,
    [TotalSampleDays]          DECIMAL (38)    NULL,
    [EnterDateTime]            DATETIME2 (3)   NULL,
    [LastChgDateTime]          DATETIME2 (3)   NULL
);






GO

