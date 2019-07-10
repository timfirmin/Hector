-- =============================================
-- Author:		Adatis
-- Create date: 18/03/2013
-- Description:	GEts all Files that are ready to be Processed
-- =============================================
CREATE PROCEDURE [Control].[ObtainUnprocessedSourceFiles]

AS
BEGIN
	SET NOCOUNT ON;
  SELECT DISTINCT 
	[Collection] AS Code, 
	SF.[32BitStageRequired]
  FROM 
	[Control].[SourceFile] SF
		INNER JOIN 
	Control.SourceFileType SFT ON SFT.SourceFileTypeId = SF.SourceFileTypeId  
  WHERE 
	(StageDate IS NULL OR ScrubDate IS NULL OR CleanDate IS NULL OR LDSDate IS NULL)
		AND 
	IsCompressed = 0
END
