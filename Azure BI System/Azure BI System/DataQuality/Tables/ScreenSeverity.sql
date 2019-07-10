CREATE TABLE [DataQuality].[ScreenSeverity] (
    [ScreenSeverityID] TINYINT      NOT NULL,
    [SeverityName]     VARCHAR (20) NOT NULL,
    [SeverityCategory] VARCHAR (20) NOT NULL,
    CONSTRAINT [pkcScreenSeverity] PRIMARY KEY CLUSTERED ([ScreenSeverityID] ASC)
);
