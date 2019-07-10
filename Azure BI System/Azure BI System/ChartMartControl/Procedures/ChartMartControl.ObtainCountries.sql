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