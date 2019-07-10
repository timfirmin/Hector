
-- =============================================
-- Author:		Adatis
-- Create date: 15/12/2016
-- Description:	Gets List of Source files that need to be extracted
-- =============================================
CREATE PROCEDURE [Control].[ObtainSourceFiles] 
	@ApplicationCode VARCHAR(80)
AS
BEGIN
	SET NOCOUNT ON;
				  SELECT DISTINCT e.[Table]
				  FROM [Control].[EntityType] e
				  LEFT JOIN [Control].[Application] a ON e.ApplicationId = a.ApplicationId 
				  WHERE e.[IsSourceEntity]  = 1 --change this to the source entity flag (new column)
				  AND e.Code <> 'DXSTMTWKDT'
				  AND a.Code = @ApplicationCode

	SET NOCOUNT OFF;
END
