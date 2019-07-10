CREATE TABLE [Staging].[BroadcasterAttributes] (
    [DistributionCode]    NVARCHAR (100) NOT NULL,
    [Domain]              NVARCHAR (250) NOT NULL,
    [StationId]           NVARCHAR (250) NOT NULL,
    [BroadcasterName]     NVARCHAR (250) NOT NULL,
    [LicenceGroup]        NVARCHAR (250) NULL,
    [MusicReportingGroup] NVARCHAR (250) NULL,
    [KeyAccountGroup]     NVARCHAR (250) NULL,
    [InsertLoadId]        INT            NULL,
    [InsertTimeStamp]     DATETIME       CONSTRAINT [DF_BroadcasterAttributes_InsertTimeStamp] DEFAULT (getdate()) NOT NULL
);

