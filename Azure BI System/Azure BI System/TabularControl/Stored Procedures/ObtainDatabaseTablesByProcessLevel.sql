CREATE PROCEDURE [TabularControl].[ObtainDatabaseTablesByProcessLevel]
		@DatabaseName	VARCHAR(128),
		@ProcessLevel	VARCHAR(128),
		@IsDimensionYN	CHAR(1)
AS
/*
 *	Obtains Partitions that should be created
 */
BEGIN
	SET NOCOUNT ON;

	/*** Get array of partition to be created ***/
	SELECT
		t.[ModelTableId],
		t.[DatabaseId],
		t.[ProcessLevelId],
		t.[TableName],
		t.[IsDimensionYN]
	FROM [TabularControl].[ModelTable] t
		JOIN [TabularControl].[Database] d ON t.[DatabaseId] = d.[DatabaseId]
		JOIN [TabularControl].[ProcessLevel] pl ON t.[ProcessLevelId] = pl.[ProcessLevelId]
	WHERE d.[Name] = @DatabaseName
	  AND pl.Name = @ProcessLevel
	  AND t.IsDimensionYN = @IsDimensionYN;

	SET NOCOUNT OFF;
END
