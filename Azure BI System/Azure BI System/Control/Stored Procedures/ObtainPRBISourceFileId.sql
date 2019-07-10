-- =============================================
-- Author:		Adatis
-- Create date: 13/12/2016
-- Description:	Gets SourceFileId by SourceFileName
-- =============================================
CREATE PROCEDURE [Control].[ObtainPRBISourceFileId] 
	@SourceFileName VARCHAR(255),
	@SourceFileCode VARCHAR(400),
	@SourceFileId INT OUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @SourceFileId = (SELECT TOP (1) 
							SourceFileId
						 FROM [Control].[SourceFile] AS sf
						   LEFT JOIN [Control].[SourceFileType] AS sft
						   ON sf.[SourceFileTypeId] = sft.SourceFileTypeId
						 WHERE sft.Code = @SourceFileCode
						 AND sf.SourceFileName = @SourceFileName) 
	SET NOCOUNT OFF;
END