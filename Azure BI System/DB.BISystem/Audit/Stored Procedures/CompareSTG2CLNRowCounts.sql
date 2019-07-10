CREATE PROC [Audit].[CompareSTG2CLNRowCounts]
	@pApplicationCode varchar(80)
AS
/*
 *This SP compares the row counts between the Extract to Stage Process and the Stage to Clean Process. This SP is called after the Stage to Clean Process is completed.
 */
DECLARE @MatchedFlag INT = 0;

WITH TempSourceFile
AS
(
	SELECT 
		SF.StageParentLoadId,
		SF.CleanParentLoadId,
		SF.SourceFileId,
		SF.SourceFileName 
	FROM [Control].SourceFile AS SF
	  INNER JOIN [Control].[Application] AS A
	  ON SF.ApplicationId = A.ApplicationId 
	WHERE SF.StageDate IS NOT NULL 
	  AND SF.CleanDate IS NOT NULL 
	  AND SF.WarehouseDate IS NULL
	  AND A.Code = @pApplicationCode
)
, 
LoadIdEXT2STG
AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
								SELECT StageParentLoadId 
								  FROM TempSourceFile
							)
)
, 
LoadIdSSTG2CLN
AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
								SELECT CleanParentLoadId 
								  FROM TempSourceFile
							)
)
,
EXT2STG_Counts
AS
(
	SELECT 
		  rt.EntityId
		, InsertedRows
		, FailedRows
		, rt.LoadId
		, cet.[Table] AS EntityTypeTable		
		, sf.SourceFileName
	 FROM [Audit].[RowThroughput] rt
		INNER JOIN [Control].Entity ce        ON ce.EntityId = rt.EntityId
		INNER JOIN [Control].[EntityType] cet ON cet.EntityTypeId = ce.EntityTypeId
		INNER JOIN [Control].[SourceFile] sf  ON sf.SourceFileId = ce.SourceFileId
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
STG2CLN_Counts
AS 
(
	SELECT 
		rt.EntityId,
		InsertedRows,
		FailedRows,
		rt.LoadId,
		cet.[Table] AS EntityTypeTable,
		sf.SourceFileName
	FROM [Audit].[RowThroughput] rt
		INNER JOIN [Control].Entity ce         ON ce.EntityId = rt.EntityId
		INNER JOIN [Control].[EntityType] cet  ON cet.EntityTypeId = ce.EntityTypeId
		INNER JOIN [Control].[SourceFile] sf   ON sf.SourceFileId = ce.SourceFileId
			AND sf.SourceFileId IN (
									SELECT SourceFileId 
									  FROM TempSourceFile
								   )
	WHERE rt.LoadId IN (
							SELECT LoadId 
							  FROM LoadIdSSTG2CLN 
						)
)
, Compare_Counts AS
(
	SELECT  
		ec.InsertedRows AS SourceRowCounts,
		sc.InsertedRows AS TargetRowcounts,
		sc.SourceFileName, sc.EntityTypeTable,
		sc.FailedRows, 
		CASE
		    WHEN (@pApplicationCode = 'DEOSDM' AND sc.EntityTypeTable IN ('DMS_STMT_ADDT','DMS_STMT_WKDT')) THEN
                CASE
				    -- DEOSDM: Failed rows are valid for DMS_STMT_WKDT/ADDT
         			WHEN (ec.InsertedRows = sc.InsertedRows) THEN 1 
		        	ELSE 0
                END
			ELSE
			    CASE
         			WHEN (ec.InsertedRows = sc.InsertedRows AND sc.FailedRows = 0 ) THEN 1 
		        	ELSE 0
                END
		END AS MatchedCountsFlag
	FROM EXT2STG_Counts ec 
		FULL OUTER JOIN STG2CLN_Counts sc ON ec.SourceFileName	= sc.SourceFileName
										 AND ec.EntityTypeTable = sc.EntityTypeTable
)
SELECT @MatchedFlag = ISNULL(MIN(CAST(MatchedCountsFlag AS INT)), 0) FROM Compare_Counts rt



-- Uncomment the below line to test if package execution stops when there are one or nore tables in source and target with diffrence in rowcounts  
--SET @MatchedFlag = 0  

DECLARE @SourceFileExists INT = 0;

SELECT @SourceFileExists = ISNULL(SF.SourceFileId, 0)
  FROM [Control].SourceFile AS SF
 INNER JOIN [Control].[Application] AS A
    ON SF.ApplicationId = A.ApplicationId 
 WHERE SF.StageDate IS NOT NULL 
   AND SF.CleanDate IS NOT NULL 
   AND SF.WarehouseDate IS NULL
   AND A.Code = @pApplicationCode

IF @SourceFileExists > 0
BEGIN
    IF @MatchedFlag = 0  
	BEGIN  
		RAISERROR ('STG2CLN Row counts did Not Match - Clean to Warehouse Will not Process - See Package Process Report', 16, 1) WITH SETERROR  	
	END	
END

