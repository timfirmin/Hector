CREATE TABLE [Reporting].[Reports] (
    [ReportKey]       INT              IDENTITY (1, 1) NOT NULL,
    [ReportId]        UNIQUEIDENTIFIER NOT NULL,
    [Path]            NVARCHAR (425)   NOT NULL,
    [SPSite]          NVARCHAR (425)   NULL,
    [SPDocLibrary]    NVARCHAR (425)   NULL,
    [ReportNameShort] NVARCHAR (425)   NOT NULL,
    [Name]            NVARCHAR (425)   NOT NULL,
    [ReportType]      INT              NOT NULL,
    [MachineKey]      INT              NULL,
    CONSTRAINT [pkcReports] PRIMARY KEY CLUSTERED ([ReportKey] ASC)
);

