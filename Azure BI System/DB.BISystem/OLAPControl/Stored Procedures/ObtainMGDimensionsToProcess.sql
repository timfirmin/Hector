-- =============================================
-- Author:		Adatis Consulting
-- Create date: 2013/05/15
-- This can return the dimensions for a given measure group.
-- If @ProcessAll is set to 1 then all dimensions in the dbo.Dimension table will be returned
-- =============================================
CREATE PROCEDURE [OLAPControl].[ObtainMGDimensionsToProcess]
		@MeasureGroupName	VARCHAR(128),
		@CubeName		VARCHAR(128),
		@ProcessAll		BIT
AS

SET NOCOUNT ON
	
SELECT			DISTINCT D.DimensionName
FROM			OLAPControl.MeasureGroupDimension MGD
INNER JOIN		OLAPControl.MeasureGroup MG ON MGD.MeasureGroupId = MG.MeasureGroupId
INNER JOIN		OLAPControl.Dimension D ON MGD.DimensionId = D.DimensionId
INNER JOIN		OLAPControl.[Cube] CU ON MG.CubeId = CU.CubeId
WHERE			(MG.MeasureGroupName = @MeasureGroupName AND CU.CubeName = @CubeName)
OR				@ProcessAll = 1
