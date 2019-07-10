SET IDENTITY_INSERT [TabularControl].[ModelTablePartition] ON;
GO

MERGE INTO [TabularControl].[ModelTablePartition] AS Tgt
USING 
	(
	VALUES
		(1,	1,	1,	'Adustment Reason-2016-10',					GETDATE(),	'SELECT * FROM Reporting.vwDimAdjustmentReason'),
		(2,	1,	1,	'Distribution-2016-10',						GETDATE(),	'SELECT * FROM Reporting.vwDimDistribution'),
		(3,	1,	2,	'FactDistributionRoyalty_2016-10-Mini',		GETDATE(),	'SELECT * FROM Reporting.vwFactDistributedRoyalty'),
		(4,	1,	2,	'FactDistributionRoyalty_2016-10-Main-1',	GETDATE(),	'SELECT * FROM Reporting.vwFactDistributedRoyalty')
	) 
	AS Src
	(
		[ModelTablePartitionId],
		[ModelTableId],
		[ProcessStatusId],
		[Name],
		[StatusDateTime],
		[SourceSQLQuery]
	)
	ON Tgt.ModelTablePartitionId = Src.ModelTablePartitionId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[ModelTableId]			= Src.[ModelTableId],
		[ProcessStatusId]		= Src.[ProcessStatusId],
		[Name]					= Src.[Name],
		[StatusDateTime]		= Src.[StatusDateTime],
		[SourceSQLQuery]		= Src.[SourceSQLQuery]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[ModelTablePartitionId],
		[ModelTableId],
		[ProcessStatusId],
		[Name],
		[StatusDateTime],
		[SourceSQLQuery]
	)
	VALUES
	(
		Src.[ModelTablePartitionId],
		Src.[ModelTableId],
		Src.[ProcessStatusId],
		Src.[Name],
		Src.[StatusDateTime],
		Src.[SourceSQLQuery]
	)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

GO
SET IDENTITY_INSERT [TabularControl].[ModelTablePartition] OFF;