CREATE PROC [Audit].CompareSTG2DMTRowCounts
	@pApplicationCode VARCHAR(80)
AS
	
--DECLARE	@pApplicationCode VARCHAR(80)
--SET @pApplicationCode = 'ETLSystem'
/*
 *This SP compares the row counts between the Staged Rows to Datamart Rows. 
 *This SP is intended for use with Blob to Azure DataMart ETL rather than Azure SQL DW.
 *Designed to be run after the StagingToDatamart Load - currently used in ETL System - note Blob files sent with Row Headers at present.
 *Test : exec [Audit].[CompareSTG2DMTRowCounts] @pApplicationCode = 'ETLSystem'
 */
DECLARE @MatchedFlag INT = 0;

WITH TempSourceFile AS
(
		 	
	SELECT TOP (1) SF.StageParentLoadId
		  ,SF.WarehouseParentLoadId	
		  ,SF.SourceFileId
		  ,SF.SourceFileName
	  FROM [Control].SourceFile AS SF
	  INNER JOIN [Control].[Application] AS A
	  ON SF.ApplicationId = A.ApplicationId 
		WHERE SF.StageDate		IS NOT NULL 
		AND SF.WarehouseDate	IS NOT NULL 
	    AND A.Code = @pApplicationCode
	  ORDER BY SF.SourceFileId DESC
)
--StageParentLoadId	WarehouseParentLoadId	SourceFileId	SourceFileName
--13306	13310	123	BISystem2017APR27
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
LoadIdSTG2DMT AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
								SELECT WarehouseParentLoadId 
								  FROM TempSourceFile
						    )
)
,
EXT2STG_Counts AS 
(
	SELECT 
		rt.EntityId,
		InsertedRows - 1 as InsertedRows, --Remove Header Row from Counts for SRC Rows
		replace(replace(lower(cet.[Table]),'_',''),'CTRL','CONTROL') AS EntityTypeTable,
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
STG2DMT_Counts AS 
(
	SELECT 
		rt.EntityId,
		InsertedRows,  
		replace(replace(lower(cet.[Table]),'_',''),'CTRL','CONTROL') AS EntityTypeTable,
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
						  FROM LoadIdSTG2DMT
					)
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
		WHEN (ec.InsertedRows = sc.InsertedRows  ) THEN 1 
		ELSE 0 
	END AS MatchedCountsFlag
FROM EXT2STG_Counts ec 
	FULL OUTER JOIN STG2DMT_Counts sc 
		ON ec.SourceFileName = sc.SourceFileName
		AND ec.EntityTypeTable = sc.EntityTypeTable
)
SELECT @MatchedFlag = ISNULL(MIN(CAST(MatchedCountsFlag AS INT)), 0) FROM Compare_Counts rt

IF @MatchedFlag = 0   
		RAISERROR ('STG2DMT Row counts did Not Match - Proceed with Caution - See Package Process Report', 16, 1) WITH SETERROR  	
GO