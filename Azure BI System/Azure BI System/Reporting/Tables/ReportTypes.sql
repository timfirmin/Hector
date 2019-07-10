CREATE TABLE [Reporting].[ReportTypes] (
    [ReportType] INT           NOT NULL,
    [Name]       NVARCHAR (20) NOT NULL,
    CONSTRAINT [pkcReportTypes] PRIMARY KEY CLUSTERED ([ReportType] ASC) ON [PRIMARY]
);