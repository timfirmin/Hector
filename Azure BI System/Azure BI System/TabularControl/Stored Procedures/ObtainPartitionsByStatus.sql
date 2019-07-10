CREATE PROCEDURE [TabularControl].[ObtainPartitionsByStatus]
		@DatabaseName	VARCHAR(128),
		@ProcessStatus	VARCHAR(128)
AS
/*
 *	Obtains Partitions that should be created
 */
BEGIN
	SET NOCOUNT ON;

	SELECT
		p.[ModelTablePartitionId],
		p.[ModelTableId],
		p.[ProcessStatusId],
		t.[TableName],
		p.[Name],
		p.[StatusDateTime],
		p.[SourceSQLQuery]
	FROM [TabularControl].[ModelTablePartition] p
		JOIN [TabularControl].[ProcessStatus] ps ON p.[ProcessStatusId] = ps.[ProcessStatusId]
		JOIN [TabularControl].[ModelTable] t ON p.[ModelTableId] = t.[ModelTableId]
		JOIN [TabularControl].[Database] d ON t.[DatabaseId] = d.[DatabaseId]
	WHERE d.[Name] = @DatabaseName
	  AND ps.[Name] = @ProcessStatus;

	SET NOCOUNT OFF;
END
