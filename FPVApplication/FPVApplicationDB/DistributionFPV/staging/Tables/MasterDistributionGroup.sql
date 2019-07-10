CREATE TABLE [staging].[MasterDistributionGroup] (
    [ID]                      INT              NOT NULL,
    [MUID]                    UNIQUEIDENTIFIER NOT NULL,
    [VersionName]             NVARCHAR (50)    NOT NULL,
    [VersionNumber]           INT              NOT NULL,
    [Version_ID]              INT              NOT NULL,
    [VersionFlag]             NVARCHAR (50)    NULL,
    [Name]                    NVARCHAR (250)   NULL,
    [Code]                    NVARCHAR (250)   NOT NULL,
    [ChangeTrackingMask]      INT              NOT NULL,
    [HectorInScope]           NVARCHAR (100)   NULL,
    [LicensingPeriod]         NVARCHAR (100)   NULL,
    [LicensingPeriodStart]    NVARCHAR (100)   NULL,
    [LicensingPeriodEnd]      NVARCHAR (100)   NULL,
    [FPVCalculatedMonth]      NVARCHAR (100)   NULL,
    [AnnualReconciliation]    NVARCHAR (100)   NULL,
    [HighPeakTimeBandFactor]  DECIMAL (18, 3)  NULL,
    [LowPeakTimeBandFactor]   DECIMAL (18, 3)  NULL,
    [NonPeakTimeBandFactor]   DECIMAL (18, 3)  NULL,
    [DefaultStationAdminRate] DECIMAL (18, 3)  NULL,
    [DefaultPRAdminRate]      DECIMAL (18, 3)  NULL,
    [DefaultPRSHedgedRate]    DECIMAL (18, 3)  NULL,
    [DefaultMCPSHedgedRate]   DECIMAL (18, 3)  NULL,
    [DefaultBroadcastHours]   DECIMAL (18, 3)  NULL,
    [EnterDateTime]           DATETIME2 (3)    NOT NULL,
    [EnterUserName]           NVARCHAR (100)   NULL,
    [EnterVersionNumber]      INT              NULL,
    [LastChgDateTime]         DATETIME2 (3)    NOT NULL,
    [LastChgUserName]         NVARCHAR (100)   NULL,
    [LastChgVersionNumber]    INT              NULL,
    [ValidationStatus]        NVARCHAR (250)   NULL,
    [InsertLoadId]            INT              NULL,
    [InsertTimeStamp]         DATETIME2 (3)    CONSTRAINT [DF_MasterDistributionGroup_InsertTimeStamp] DEFAULT (getdate()) NULL
);





