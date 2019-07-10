DECLARE @SourceFileId NVARCHAR(255) = 91979;
SELECT *
  FROM [Control].[SourceFile] sf
  JOIN [Control].SourceFileType sft on sft.SourceFileTypeId = sf.SourceFileTypeId
  JOIN [Control].[Application] a on sf.ApplicationId = a.[ApplicationId]
 WHERE a.[Code] = 'DEOSSAS'
   AND WarehouseDate IS NULL;

PRINT 'CLN2WAR Packages Before';
SELECT * 
  FROM Control.EntityProcessStream 
 WHERE EntityId IN (SELECT EntityId 
                      FROM Control.Entity 
	    		     WHERE SourceFileId = @SourceFileId) 
   AND ProcessStream IN ('CLN2WAR')
 ORDER BY LoadId DESC;
 
PRINT 'CLN2WAR Delete Packages';
DELETE
  FROM Control.EntityProcessStream 
 WHERE EntityId IN (SELECT EntityId 
                      FROM Control.Entity 
	    		     WHERE SourceFileId = @SourceFileId) 
   AND ProcessStream IN ('CLN2WAR');
 
PRINT 'CLN2WAR Packages After';
SELECT * 
  FROM Control.EntityProcessStream 
 WHERE EntityId IN (SELECT EntityId 
                      FROM Control.Entity 
	    		     WHERE SourceFileId = @SourceFileId) 
   AND ProcessStream IN ('CLN2WAR')
 ORDER BY LoadId DESC;