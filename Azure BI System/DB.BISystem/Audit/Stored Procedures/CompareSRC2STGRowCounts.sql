CREATE PROC [Audit].[CompareSRC2STGRowCounts]
	@pApplicationCode VARCHAR(80)
AS
/*
 *This SP compares the row counts between the Source to Extract Process and the Extract to Stage Process. This SP is called after the Extract to Stage Process is completed.
 */
DECLARE @MatchedFlag INT = 0;

WITH TempSourceFile AS
(
	SELECT SF.FileExtractedParentLoadId
		  ,SF.StageParentLoadId
		  ,SF.SourceFileId
		  ,SF.SourceFileName
	  FROM [Control].SourceFile AS SF
	  INNER JOIN [Control].[Application] AS A
	  ON SF.ApplicationId = A.ApplicationId 
	 WHERE SF.StageDate		IS NOT NULL 
	   AND SF.CleanDate		IS NULL 
	   AND SF.WarehouseDate	IS NULL
	   AND A.Code = @pApplicationCode
)
, 
LoadIdEXT2STG AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
							  SELECT StageParentLoadId 
								FROM TempSourceFile
							)
)
,  
LoadIdSRC2EXT AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
								SELECT FileExtractedParentLoadId 
								  FROM TempSourceFile
						    )
)
, 
EXT2STG_Counts AS 
(
	SELECT 
		rt.EntityId,
		InsertedRows,
		FailedRows,
		cet.[Table] AS EntityTypeTable,
		sf.SourceFileName
 FROM [Audit].[RowThroughput] rt 
	INNER JOIN [Control].Entity ce         ON ce.EntityId      = rt.EntityId
	INNER JOIN [Control].[EntityType] cet  ON cet.EntityTypeId = ce.EntityTypeId
	INNER JOIN [Control].[SourceFile] sf   ON sf.SourceFileId  = ce.SourceFileId
	AND sf.SourceFileId IN (
								SELECT SourceFileId 
								  FROM TempSourceFile
							)
WHERE rt.LoadId IN (
						SELECT LoadId 
						  FROM LoadIdEXT2STG 
					)
)
, 
SRC2EXT_Counts
AS
(
SELECT 
	  rt.EntityId
	, SUM(InsertedRows)    AS InsertedRows
	, SUM(FailedRows)      AS FailedRows
	, cet.[Table]          AS EntityTypeTable
	, sf.SourceFileName
  FROM [Audit].[RowThroughput] rt
    INNER JOIN [Control].Entity ce         ON ce.EntityId      = rt.EntityId
	INNER JOIN [Control].[EntityType] cet  ON cet.EntityTypeId = ce.EntityTypeId
										  AND cet.[IsSourceEntity]	= 1 --gets only the one that are source entites
	INNER JOIN [Control].[SourceFile] sf   ON sf.SourceFileId  = ce.SourceFileId
	AND sf.SourceFileId IN (
								SELECT SourceFileId 
								  FROM TempSourceFile
							)
WHERE rt.LoadId In (
						SELECT LoadId 
                          FROM LoadIdSRC2EXT 
				   )
GROUP BY 
	ExecutionId
	, rt.EntityId
	, sf.SourceFileName
	, cet.[Table]

)
, 
Compare_Counts
AS
(
SELECT 
	ec.InsertedRows AS SourceRowCounts, 
	sc.InsertedRows AS TargetRowcounts,
	sc.SourceFileName,
	sc.EntityTypeTable,
	CASE 
		WHEN (ec.InsertedRows = sc.InsertedRows AND sc.FailedRows = 0 ) THEN 1 
		ELSE 0 
	END AS MatchedCountsFlag
FROM SRC2EXT_Counts ec 
	FULL OUTER JOIN EXT2STG_Counts sc 
		ON ec.SourceFileName = sc.SourceFileName
		AND ec.EntityTypeTable = sc.EntityTypeTable
)
SELECT @MatchedFlag = ISNULL(MIN(CAST(MatchedCountsFlag AS INT)), 0) FROM Compare_Counts rt


-- Uncomment the below line to test if package execution stops when there are one or nore tables in source and target with diffrence in rowcounts  
-- SET @MatchedFlag = 0  

DECLARE @SourceFileExists INT = 0;

SELECT @SourceFileExists = ISNULL(SF.SourceFileId, 0)
  FROM [Control].SourceFile AS SF
 INNER JOIN [Control].[Application] AS A
    ON SF.ApplicationId = A.ApplicationId 
 WHERE SF.StageDate		IS NOT NULL 
   AND SF.CleanDate		IS NULL 
   AND SF.WarehouseDate	IS NULL
   AND A.Code = @pApplicationCode

IF @SourceFileExists > 0
BEGIN
    IF @MatchedFlag = 0  
	BEGIN  
		RAISERROR ('SRCT2STG Row counts did Not Match - Stage to Clean Will not Process - See Package Process Report', 16, 1) WITH SETERROR  	
	END
END
