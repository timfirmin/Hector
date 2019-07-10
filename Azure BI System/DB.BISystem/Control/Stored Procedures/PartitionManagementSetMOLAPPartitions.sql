CREATE PROCEDURE [Control].[PartitionManagementSetMOLAPPartitions]
				(@FactTable varchar(50),
				@DateKey int)
AS

select 1

--stored proc code commented out as there are unresolved references to table objects preventing a successful build (tw 04/10/2018)
/*
DECLARE @Measures table (MeasureGroupID smallint)
DECLARE	@PartitionDefinitionID tinyint = (select PartitionDefinitionID from [Control].[PartitionDefinition] where PartitionDefinitionName = @FactTable)

INSERT INTO @Measures
SELECT MeasureGroupID 
FROM [Control].[MeasureGroup]
WHERE MeasureGroupSource = @FactTable

UPDATE [Control].[MeasureGroupPartition]
SET Dirty = 1
WHERE MeasureGroupID in (SELECT MeasureGroupID
							FROM [Control].[MeasureGroupPartition]
							WHERE MeasureGroupID in (select MeasureGroupID from @Measures)
												AND PartitionDefinitionID = @PartitionDefinitionID
												AND PartitionID = @DateKey)
					AND PartitionDefinitionID = @PartitionDefinitionID
					AND PartitionID = @DateKey

INSERT INTO [Control].[MeasureGroupPartition]
(
MeasureGroupID, PartitionID, PartitionDefinitionID, FromDateID, ToDateID, PartitionSliceDimension, PartitionSliceAttribute, PartitionSliceKey, Active, Dirty
)
SELECT 
	MeasureGroupID,
	cast(coalesce((select max(value) from sys.partition_range_values LOW where UPP.value > LOW.value AND UPP.function_id = LOW.function_id),20101201) as int) PartitionID,
	@PartitionDefinitionID PartitionDefinitionID,
	cast(coalesce((select max(value) from sys.partition_range_values LOW where UPP.value > LOW.value AND UPP.function_id = LOW.function_id),20101201) as int) FromDateID,
	cast(value as int) ToDateID,
	NULL PartitionSliceDimension,
	NULL PartitionSliceAttribute,
	NULL PartitionSliceKey,
	1 Active,
	1 Dirty
FROM sys.partition_range_values UPP cross join
	@Measures
WHERE cast(coalesce((select max(value) from sys.partition_range_values LOW where UPP.value > LOW.value AND UPP.function_id = LOW.function_id),20101201) as int) = @DateKey
	AND MeasureGroupID NOT IN (SELECT MeasureGroupID
								FROM [Control].[MeasureGroupPartition]
								WHERE MeasureGroupID in (select MeasureGroupID from @Measures)
										AND PartitionDefinitionID = @PartitionDefinitionID
										AND PartitionID = @DateKey)
*/