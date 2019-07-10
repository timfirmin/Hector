CREATE TABLE [hctr].[StationUDCBaseline] (
    [StationUDCKey]             INT           IDENTITY (1, 1) NOT NULL,
    [BroadcasterDomain]         NVARCHAR (60) NULL,
    [KeyAccountGroup]           NVARCHAR (60) NULL,
    [MusicReportingGroup]       NVARCHAR (60) NULL,
    [LicenceGroup]              NVARCHAR (60) NULL,
    [StationId]                 NVARCHAR (6)  NULL,
    [Broadcaster]               NVARCHAR (60) NULL,
    [RightType]                 NVARCHAR (20) NULL,
    [MCPSLicenceType]           NVARCHAR (20) NULL,
    [UsedForPurposeDesc]        NVARCHAR (30) NULL,
    [TimeBand]                  NVARCHAR (10) NULL,
    [UsageDistributionCode]     NVARCHAR (5)  NULL,
    [UsageDistributionCodeDesc] NVARCHAR (60) NULL,
    [InsertLoadId]              INT           NULL,
    [InsertTimeStamp]           DATETIME      CONSTRAINT [DF_StationUDCBaseline_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [UpdateLoadId]              INT           NULL,
    [UpdateTimeStamp]           DATETIME      NULL
);

