

-- =============================================
-- Author:		Tim Firmin
-- Create Date: 21/11/2017
-- Description:	Gets SAM Flag Based on (Parent) LoadId and System Code
-- Test :  exec Audit.ObtainSAMProceedFlag  @ApplicationLoadId = 6868, @SAMApplicationCode = 'SQL-DB-PRSCODA', @SAMProceedBit = 0
-- =============================================
CREATE PROCEDURE [Audit].[ObtainSAMProceedFlag]
	@ApplicationLoadId int,
	@SAMApplicationCode VARCHAR(255),
	@SAMProceedBit smallint OUT
AS
BEGIN
	SET @SAMProceedBit = 
	(
	SELECT TOP 1 SAMProgressInt FROM
		(	SELECT 1 as SortOrder, SAMProgressInt from [Audit].[SAMActiveMessageLog] WITH (NOLOCK)
			WHERE [ApplicationLoadId] =  @ApplicationLoadId AND [SAMApplicationCode] = @SAMApplicationCode
			UNION
			SELECT 2 as SortOrder, 0 as SAMProgressInt
		) GetVals
			ORDER BY SortOrder
	)
	PRINT @SAMProceedBit
	RETURN
END



