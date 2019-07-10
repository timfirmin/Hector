-- =============================================
-- Author:		Adatis Consulting
-- Create date: 2013/05/13
-- =============================================
CREATE PROCEDURE [OLAPControl].[ObtainMGPartitionsToProcess]
		@ProcessType				SMALLINT = NULL,
		@MeasureGroupName			VARCHAR(128),
		@CubeName					VARCHAR(128),
		@PartitionKeyColName		VARCHAR(128)
AS

SET NOCOUNT ON
	
	SELECT		PartitionID
				,' FROM ' + PD.PartitionDefinitionName 
					+ ' WHERE ' + @PartitionKeyColName + ' BETWEEN ' 
					+ CAST(FromDateId AS VARCHAR) 
					+ ' AND ' + CAST(ToDateId AS VARCHAR)					AS PartitionRange,
				PD.PartitionPrefix,
				--Set the MDX slice if the metadata has been defined
				CASE 
					WHEN	MGP.PartitionSliceDimension IS NOT NULL AND 
							MGP.PartitionSliceAttribute IS NOT NULL AND
							MGP.PartitionSliceKey IS NOT NULL THEN
							'[' + MGP.PartitionSliceDimension + '].[' + MGP.PartitionSliceAttribute + '].&[' +
							CAST(MGP.PartitionSliceKey AS VARCHAR(10)) + ']'
					ELSE
						NULL
				END AS PartitionSlice
	FROM		OLAPControl.MeasureGroupPartition									MGP
		INNER JOIN	OLAPControl.MeasureGroup										MG
		ON			MGP.MeasureGroupId = MG.MeasureGroupId
		INNER JOIN	OLAPControl.[Cube]												CU
		ON			CU.CubeId =	MG.CubeId
		INNER JOIN	OLAPControl.PartitionDefinition									PD
		ON			MGP.PartitionDefinitionId = PD.PartitionDefinitionId
	WHERE	Dirty = 1 -- We only want to Process Dirty PArtitions, The Old Code Processesd Everthing if a Full Process Was Requested, however for Tubular this is not required. 
				--CASE 
				--	WHEN COALESCE(@ProcessType, 0) = 0
				--	THEN Dirty
				--	ELSE Active
				--END = 1	
	AND			MG.MeasureGroupName	= @MeasureGroupName
	AND			CU.CubeName	= @CubeName

	ORDER BY FromDateId
