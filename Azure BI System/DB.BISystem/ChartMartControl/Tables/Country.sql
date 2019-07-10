CREATE TABLE [ChartMartControl].[Country] (
    [CountryKey]        INT           IDENTITY (1, 1) NOT NULL,
    [ApplicationId]     SMALLINT      NOT NULL,
    [Name]              VARCHAR (150) NOT NULL,
    [Code]              VARCHAR (3)   NOT NULL,
    [IsChartDownloaded] BIT           NOT NULL,
    CONSTRAINT [PK_Country_CountryKey] PRIMARY KEY CLUSTERED ([CountryKey] ASC),
    CONSTRAINT [FK_ChartMartControlCountry_ApplicationId] FOREIGN KEY ([ApplicationId]) REFERENCES [Control].[Application] ([ApplicationId]),
    CONSTRAINT [U_Country_Code] UNIQUE NONCLUSTERED ([ApplicationId] ASC, [Code] ASC),
    CONSTRAINT [U_Country_Name] UNIQUE NONCLUSTERED ([ApplicationId] ASC, [Name] ASC)
);

