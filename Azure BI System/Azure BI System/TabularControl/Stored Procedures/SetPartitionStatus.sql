CREATE PROCEDURE [TabularControl].[SetPartitionStatus]
		@DatabaseName	VARCHAR(128),
		@TableName		VARCHAR(128),
		@PartitionName	VARCHAR(128),
		@PartitionStatus VARCHAR(128)
AS
/*
 *	Set Partition status
 */
BEGIN
	SET NOCOUNT ON;

	/*** Get ProcessStatusId by StatusName ***/
	DECLARE @TargetPartitionStatusId TINYINT;
	SET @TargetPartitionStatusId = (SELECT 
										ps.[ProcessStatusId]
									FROM [TabularControl].[ProcessStatus] ps
									WHERE ps.[Name] = @PartitionStatus);

	/*** Updates Partition with new status ***/
	WITH PartitionToUpdate
	AS
	(
		SELECT [ModelTablePartitionId] FROM [TabularControl].[ModelTablePartition] p
			JOIN [TabularControl].[ModelTable] t ON p.[ModelTableId] = t.[ModelTableId]
			JOIN [TabularControl].[Database] d ON t.[DatabaseId] = d.[DatabaseId]
		WHERE d.[Name] = @DatabaseName
		  AND t.[TableName] = @TableName
		  AND p.[Name] = @PartitionName
	)
	UPDATE tp
	SET
		ProcessStatusId = @TargetPartitionStatusId
	FROM [TabularControl].[ModelTablePartition] tp
		JOIN PartitionToUpdate pu ON pu.[ModelTablePartitionId] = tp.[ModelTablePartitionId];		

	SET NOCOUNT OFF;
END;
