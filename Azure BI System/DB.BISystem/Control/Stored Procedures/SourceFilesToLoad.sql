-- =============================================
-- Author:		Adatis - PRS
-- Create date: 08/09/2017
-- Description:	Gets SourceFileId To Load in the Online Rep Transational Reporting Process
-- =============================================
CREATE PROCEDURE [Control].[SourceFilesToLoad]
	@TotalNoOfUsesTreshold BIGINT 
AS
BEGIN
	SET NOCOUNT ON;

WITH RunningTotals AS (
	SELECT 
		SUM(TotalNoOfUses) OVER (ORDER BY SourceFileId) AS RT,
		SourceFileId, OriginalFileId, 
		TotalNoOfUses,
		ROW_NUMBER() OVER (ORDER BY SourceFileId) RowNumber
	FROM Control.SourceFile SF
		INNER JOIN Control.SourceFileType	SFT
	ON SF.SourceFileTypeId = SFT.SourceFileTypeId
	WHERE  IsToBeLoaded = 1 AND SFT.Code ='Online' AND (IsLoaded = 0 OR IsLoaded IS NULL)
	--OR OriginalFileId IN (55572,55573)
)
SELECT OriginalFileId AS SourceFileId, RT, SourceFileId AS BISystemFileId FROM RunningTotals
WHERE RT < @TotalNoOfUsesTreshold OR RowNumber = 1
ORDER BY SourceFileId
 
END
