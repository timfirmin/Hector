-- =============================================
-- Author:		Adatis Consulting
-- Create date: 2013/05/15
-- =============================================
CREATE PROCEDURE [OLAPControl].[ResetDirtyPartitions]
		@MeasureGroupName	VARCHAR(128),
		@CubeName			VARCHAR(128)
AS

SET NOCOUNT ON
	
	UPDATE		MGP
	SET			Dirty = 0 
	FROM		[OLAPControl].[MeasureGroupPartition]				MGP
		INNER JOIN	[OLAPControl].[MeasureGroup]					MG
		ON			MGP.MeasureGroupId = MG.MeasureGroupId	
		INNER JOIN	[OLAPControl].[Cube]							C
		ON			MG.CubeId = C.CubeId
	WHERE		MG.MeasureGroupName	= @MeasureGroupName
	AND			C.CubeName = @CubeName
	AND			Dirty = 1
