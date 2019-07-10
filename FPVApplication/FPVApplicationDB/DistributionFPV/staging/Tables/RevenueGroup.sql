CREATE TABLE [staging].[RevenueGroup] (
    [Code]                           NVARCHAR (250)  NOT NULL,
    [Name]                           NVARCHAR (250)  NULL,
    [SocietySplitPercent]            DECIMAL (38, 2) NULL,
    [RevenueApportionment]           NVARCHAR (250)  NULL,
    [DistributionGroup]              NVARCHAR (250)  NULL,
    [CodaCustomerCode]               NVARCHAR (250)  NULL,
    [RevenueApportionmentMethodPRS]  NVARCHAR (250)  NULL,
    [RevenueApportionmentMethodMCPS] NVARCHAR (250)  NULL,
    [HedgedRate]                     DECIMAL (38, 2) NULL,
    [InsertLoadId]                   INT             NULL,
    [InsertTimeStamp]                DATETIME        CONSTRAINT [DF_LicenceGroup_InsertTimeStamp] DEFAULT (getdate()) NOT NULL
);
GO

