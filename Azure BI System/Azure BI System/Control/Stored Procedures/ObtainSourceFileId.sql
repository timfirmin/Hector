-- =============================================
-- Author:		Adatis
-- Create date: 27/09/2016
-- Description:	Gets SourceFileId by DistributionCode 
-- =============================================
CREATE PROCEDURE [Control].[ObtainSourceFileId] 
	@DistributionCode VARCHAR(255),
	@SourceFileId INT OUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @SourceFileId = (SELECT TOP (1) SourceFileId
						 FROM [Control].[SourceFile] AS sf
						   LEFT JOIN [Control].[SourceFileType] AS sft
						   ON sf.[SourceFileTypeId] = sft.SourceFileTypeId
						 WHERE sft.Code = 'DX'
						 AND sf.SourceFileName = @DistributionCode) 

	SET NOCOUNT OFF;
END
