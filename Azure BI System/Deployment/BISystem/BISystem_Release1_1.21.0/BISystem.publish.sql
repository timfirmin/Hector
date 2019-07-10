PRINT N'Creating  PROCEDURE [Control].[UpdateSourceFileUnloaded]'
GO

CREATE PROCEDURE [Control].[UpdateSourceFileUnloaded]
	@SourceFileId		INT
AS

SET NOCOUNT ON;

UPDATE
	Control.SourceFile
SET
	FileUnloaded			= 1,
	FileUnloadedDate		= GETDATE()
WHERE
	SourceFileId = @SourceFileId;

GO

PRINT N'Creating  PROCEDURE [Control].[ObtainFilesToUnloadDataRetention]'
GO

ALTER PROCEDURE [Control].[ObtainFilesToUnloadDataRetention]
(@NumberOfMonthsRetained INT)
AS

SET NOCOUNT ON;

DECLARE @DaysToRetain INT;

SET @DaysToRetain = @NumberOfMonthsRetained * 30;

SELECT top 500
	SourceFileId, SourceFileName
FROM
	Control.SourceFile S INNER JOIN
	[Control].[Application] A on S.ApplicationId = A.ApplicationId
WHERE
	( (UnloadFile = 1 AND COALESCE(FileUnloaded, 0) = 0 )
	  OR 
	  (DATEDIFF(dd, StageDate, GETDATE()) >= @DaysToRetain)
     ) AND Code = 'BRDDQ'

GO