CREATE PROCEDURE [TabularControl].[ObtainDirtyPartitionsToProcess]
		@DatabaseName	VARCHAR(128),
		@TableName		VARCHAR(128)
AS
/*
 *	Obtains Partitions that should be processed
 */
BEGIN
	SET NOCOUNT ON;

		SELECT
			p.[ModelTablePartitionId],
			p.[ModelTableId],
			p.[ProcessStatusId],
			p.[Name],
			p.[StatusDateTime],
			p.[SourceSQLQuery]
		FROM [TabularControl].[ModelTablePartition] p
			JOIN [TabularControl].[ProcessStatus] ps ON p.[ProcessStatusId] = ps.[ProcessStatusId]
			JOIN [TabularControl].[ModelTable] t ON p.[ModelTableId] = t.[ModelTableId]
			JOIN [TabularControl].[Database] d ON t.[DatabaseId] = d.[DatabaseId]
		WHERE d.[Name] = @DatabaseName
		  AND t.[TableName] = @TableName
		  AND ps.[Name] IN ( 'New','Dirty');

	SET NOCOUNT OFF;
END
