
PRINT 'ChartMartControl.sql'
GO

CREATE SCHEMA [ChartMartControl]
    AUTHORIZATION [dbo];

GO
GRANT EXECUTE
    ON SCHEMA::[ChartMartControl] TO [db_subscribed_application];


GO
--GRANT SELECT
--    ON SCHEMA::[Audit] TO [PRSBIDevValidation];




PRINT 'ChartMartControl.ObtainCountries.sql'
GO

CREATE PROCEDURE ChartMartControl.ObtainCountries
	@ApplicationCode VARCHAR(150)
AS
BEGIN
	SELECT
		cmc.[CountryKey],
		cmc.[ApplicationId],
		cmc.[Name],
		cmc.[Code],
		cmc.[IsChartDownloaded]
	FROM [ChartMartControl].[Country] cmc
	JOIN [Control].[Application] a ON a.ApplicationId = cmc.ApplicationId
	WHERE a.Code = @ApplicationCode
	  AND cmc.IsChartDownloaded = 1
END

GO

PRINT 'ChartMartControl.Country.sql'

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

--Command(s) completed successfully.




