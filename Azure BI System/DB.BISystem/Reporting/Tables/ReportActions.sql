CREATE TABLE [Reporting].[ReportActions] (
    [ActionType] INT           IDENTITY (1, 1) NOT NULL,
    [Action]     NVARCHAR (26) NULL,
    CONSTRAINT [pkcReportActions] PRIMARY KEY CLUSTERED ([ActionType] ASC)
);

