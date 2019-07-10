
CREATE PROCEDURE [Control].[ObtainFilesToUnloadDataRetention]
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
	( (COALESCE(FileUnloaded, 0) = 0 )
	  AND  
	  (DATEDIFF(dd, StageDate, GETDATE()) >= @DaysToRetain)
     ) AND Code = 'BRDDQ'

