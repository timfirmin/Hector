CREATE TABLE ChartMartControl.Country
(
	[CountryKey]			INT				NOT NULL IDENTITY(1,1),
	[ApplicationId]			SMALLINT		NOT NULL,
	[Name]					VARCHAR(150)	NOT NULL,
	[Code]					VARCHAR(3)		NOT NULL,
	[IsChartDownloaded]		BIT				NOT NULL,
	CONSTRAINT PK_Country_CountryKey PRIMARY KEY CLUSTERED (CountryKey),
	CONSTRAINT U_Country_Name UNIQUE (ApplicationId,Name),
	CONSTRAINT U_Country_Code UNIQUE (ApplicationId,Code),
	CONSTRAINT FK_ChartMartControlCountry_ApplicationId FOREIGN KEY (ApplicationId) REFERENCES [Control].[Application](ApplicationId)
) ON [PRIMARY]