﻿/*
Deployment script for BISystemTest

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BISystemTest"
:setvar DefaultFilePrefix "BISystemTest"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
PRINT N'Altering [Audit].[RowThroughput]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;

GO
ALTER TABLE [Audit].[RowThroughput]
    ADD [EntityTypeTable] VARCHAR (100) NULL;

GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

GO
BEGIN
  UPDATE [Audit].[RowThroughput]
     SET [EntityTypeTable] = [EntityName];
END

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

GO
ALTER TABLE [Audit].[RowThroughput] DROP COLUMN [EntityName];

GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Starting rebuilding table [Config].[Parameter]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Config].[tmp_ms_xx_Parameter] (
    [ParmaterId]         INT           IDENTITY (1, 1) NOT NULL,
    [ParamaterCode]      VARCHAR (10)  NULL,
    [ParamaterShortDesc] VARCHAR (20)  NULL,
    [ParamaterDesc]      VARCHAR (50)  NULL,
    [ParameterType]      VARCHAR (20)  NULL,
    [ParameterValue]     NVARCHAR (50) NULL,
    [ParameterDataType]  VARCHAR (30)  NULL,
    CONSTRAINT [tmp_ms_xx_constraint_pkcParameter1] PRIMARY KEY CLUSTERED ([ParmaterId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Config].[Parameter])
    BEGIN
        SET IDENTITY_INSERT [Config].[tmp_ms_xx_Parameter] ON;
        INSERT INTO [Config].[tmp_ms_xx_Parameter] ([ParmaterId], [ParamaterCode], [ParamaterShortDesc], [ParamaterDesc], [ParameterType], [ParameterValue], [ParameterDataType])
        SELECT   [ParmaterId],
                 [ParamaterCode],
                 [ParamaterShortDesc],
                 [ParamaterDesc],
                 [ParameterType],
                 [ParameterValue],
                 [ParameterDataType]
        FROM     [Config].[Parameter]
        ORDER BY [ParmaterId] ASC;
        SET IDENTITY_INSERT [Config].[tmp_ms_xx_Parameter] OFF;
    END

DROP TABLE [Config].[Parameter];

EXECUTE sp_rename N'[Config].[tmp_ms_xx_Parameter]', N'Parameter';

EXECUTE sp_rename N'[Config].[tmp_ms_xx_constraint_pkcParameter1]', N'pkcParameter', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[AutomationActionLog]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
CREATE TABLE [Azure].[AutomationActionLog] (
    [ActionId]          INT              IDENTITY (1, 1) NOT NULL,
    [ObjectName]        VARCHAR (255)    NOT NULL,
    [ActionName]        VARCHAR (255)    NOT NULL,
    [ActionDescription] VARCHAR (255)    NOT NULL,
    [InsertedDate]      DATETIME         NULL,
    [UpdatedDate]       DATETIME         NULL,
    [Result]            INT              NULL,
    [OperationID]       UNIQUEIDENTIFIER NULL,
    PRIMARY KEY CLUSTERED ([ActionId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Audit].[CompareSRC2STGRowCounts]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
CREATE PROC [Audit].[CompareSRC2STGRowCounts]
AS


--- This SP compares the row counts between the Source to Extract Process and the Extract to Stage Process. This SP is called after the Extract to Stage Process is completed.

DECLARE @MatchedFlag INT = 0;

WITH 

SourceFile
AS
(
	SELECT FileExtractedParentLoadId
			, StageParentLoadId
			, SourceFileId
			, SourceFileName 
	 FROM [Control].SourceFile 
	WHERE StageDate				 IS NOT NULL 
	  AND CleanDate				 IS NULL 
	  AND WarehouseDate          IS NULL
)
, 

LoadIdEXT2STG
AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
							  SELECT StageParentLoadId 
								FROM SourceFile
							)
)
, 

LoadIdSRC2EXT
AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
								SELECT FileExtractedParentLoadId 
								  FROM SourceFile
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
	, cet.[Table] AS EntityTypeTable
	, sf.SourceFileName

 FROM [Audit].[RowThroughput] rt 
INNER JOIN [Control].Entity ce         ON ce.EntityId      = rt.EntityId
INNER JOIN [Control].[EntityType] cet  ON cet.EntityTypeId = ce.EntityTypeId
INNER JOIN [Control].[SourceFile] sf   ON sf.SourceFileId  = ce.SourceFileId
	AND sf.SourceFileId IN (
								SELECT SourceFileId 
								  FROM SourceFile
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
	, rt.EntityTypeTable
	, rt.SourceFileName    AS SourceFileName
 
 FROM [Audit].[RowThroughput] rt

INNER JOIN [Control].EntityType cet   ON cet.[Table]        = rt.EntityTypeTable
									 AND cet.[Schema]       = 'DATAXCHANGE'
INNER JOIN [Control].Entity ce        ON ce.[EntityTypeId]  = cet.[EntityTypeId]
INNER JOIN [Control].[SourceFile] sf  ON sf.[SourceFileId]  = ce.[SourceFileId]
	AND rt.SourceFileName = sf.SourceFileName
	AND rt.SourceFileName IN (
								 SELECT SourceFileName 
								   FROM SourceFile
							  )
WHERE rt.LoadId In (
						SELECT LoadId 
                          FROM LoadIdSRC2EXT 
				   )

GROUP BY 
	ExecutionId
	, rt.EntityId
	, rt.SourceFileName
	, rt.EntityTypeTable

)


, Compare_Counts

AS
(
SELECT ec.InsertedRows AS SourceRowCounts, sc.InsertedRows AS TargetRowcounts
, sc.SourceFileName, sc.EntityTypeTable, CASE WHEN (ec.InsertedRows = sc.InsertedRows AND sc.FailedRows = 0 ) THEN 1 ELSE 0 END AS MatchedCountsFlag
FROM SRC2EXT_Counts ec 
FULL OUTER JOIN EXT2STG_Counts sc ON ec.SourceFileName = sc.SourceFileName
	AND ec.EntityTypeTable = sc.EntityTypeTable
)



SELECT @MatchedFlag = ISNULL(MIN(CAST(MatchedCountsFlag AS INT)), 0) FROM Compare_Counts rt


-- Uncomment the below line to test if package execution stops when there are one or nore tables in source and target with diffrence in rowcounts  
-- SET @Matched_YN = 0  



IF @MatchedFlag = 0  
	BEGIN  

		RAISERROR ('EXT2STG Row counts did Not Match - Stage to Clean Will not Process - See Package Process Report', 16, 1) WITH SETERROR  
	
	END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Audit].[CompareSTG2CLNRowCounts]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
CREATE PROC [Audit].[CompareSTG2CLNRowCounts]
AS

--- This SP compares the row counts between the Extract to Stage Process and the Stage to Clean Process. This SP is called after the Stage to Clean Process is completed.

DECLARE @MatchedFlag INT = 0;


WITH SourceFile
AS
(
	SELECT StageParentLoadId
		, CleanParentLoadId
		, SourceFileId
		, SourceFileName 
	 FROM [Control].SourceFile 
	WHERE StageDate IS NOT NULL 
		AND CleanDate IS NOT NULL 
		AND WarehouseDate IS NULL
)
, 

LoadIdEXT2STG
AS
(
	SELECT LoadId 
	  FROM [Audit].[PackageLoad] 
	 WHERE ParentLoadId IN (
								SELECT StageParentLoadId 
								  FROM SourceFile
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
								  FROM SourceFile
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
									  FROM SourceFile
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
		  rt.EntityId
		, InsertedRows
		, FailedRows
		, rt.LoadId
		, cet.[Table] AS EntityTypeTable
		, sf.SourceFileName

	 FROM [Audit].[RowThroughput] rt
	INNER JOIN [Control].Entity ce         ON ce.EntityId = rt.EntityId
	INNER JOIN [Control].[EntityType] cet  ON cet.EntityTypeId = ce.EntityTypeId
	INNER JOIN [Control].[SourceFile] sf   ON sf.SourceFileId = ce.SourceFileId
		AND sf.SourceFileId IN (
									SELECT SourceFileId 
									  FROM SourceFile)
	WHERE rt.LoadId IN (
							SELECT LoadId 
							  FROM LoadIdSSTG2CLN 
						)
)



, Compare_Counts
AS
(
SELECT  ec.InsertedRows AS SourceRowCounts, sc.InsertedRows AS TargetRowcounts
, sc.SourceFileName, sc.EntityTypeTable, sc.FailedRows, CASE WHEN (ec.InsertedRows = sc.InsertedRows AND sc.FailedRows = 0 ) THEN 1 ELSE 0 END AS MatchedCountsFlag
FROM EXT2STG_Counts ec 
FULL OUTER JOIN STG2CLN_Counts sc ON ec.SourceFileName = sc.SourceFileName
	AND ec.EntityTypeTable = sc.EntityTypeTable
)





SELECT @MatchedFlag = ISNULL(MIN(CAST(MatchedCountsFlag AS INT)), 0) FROM Compare_Counts rt



-- Uncomment the below line to test if package execution stops when there are one or nore tables in source and target with diffrence in rowcounts  
--SET @Matched_YN = 0  


IF @MatchedFlag = 0  
	BEGIN  

		RAISERROR ('STG2CLN Row counts did Not Match - Clean to Warehouse Will not Process - See Package Process Report', 16, 1) WITH SETERROR  
	
	END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[GetAction]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-11
-- Description:	Gets Action Details from Automationmatrix about the state of the action performed on the object
-- =============================================
CREATE PROCEDURE [Azure].[GetAction]
	@ObjectName varchar(255),
	@ActionName varchar(255)
AS
BEGIN
	SELECT TOP(1) 
	   [ObjectName]
      ,[ActionName]
      ,[ActionDescription]
      ,[InsertedDate]
      ,[UpdatedDate]
      ,[Result]
      ,[OperationID] 
	FROM [Azure].[AutomationActionLog]
	WHERE ObjectName = @ObjectName
	  AND ActionName = @ActionName
	ORDER BY InsertedDate DESC
END;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[GetActionStatus]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-11
-- Description:	Gets Action Details from Automationmatrix about the state of the action performed on the object
-- =============================================
CREATE PROCEDURE [Azure].[GetActionStatus]
	@ObjectName varchar(255),
	@ActionName varchar(255),
	@ActionStatus int OUT
AS
BEGIN
DECLARE @ActionStatusTemp INT = (SELECT TOP(1) [Result]
								 FROM [Azure].[AutomationActionLog]
								 WHERE ObjectName = @ObjectName
								   AND ActionName = @ActionName
								 ORDER BY InsertedDate DESC)

	SET @ActionStatus = ISNULL(@ActionStatusTemp ,-1)
END;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[GetActionStatusByOperatioinID]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-11
-- Description:	Gets Action Details from Automation Action Log Table about the state of the action (identified by OperationID) performed on the object
-- =============================================
CREATE PROCEDURE [Azure].[GetActionStatusByOperatioinID]
	@OperationID uniqueidentifier,
	@ActionStatus int OUT
AS
BEGIN
/* @uOperationID has been used as a middle parameter as SSIS had problems with conversion from varchar to GUID/uniqueidentifier */
DECLARE @ActionStatusTemp INT = (SELECT TOP(1) [Result]
								 FROM [Azure].[AutomationActionLog]
								 WHERE ISNULL(OperationID,NEWID()) = @OperationID
								 ORDER BY InsertedDate DESC)

	SET @ActionStatus = ISNULL(@ActionStatusTemp ,-1)
END;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[GetETLProcessState]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author: Adatis Consulting - PS
-- Create date: 2016-11-03
-- Description:	Gets current state of ETL process
-- =============================================

CREATE PROCEDURE Azure.GetETLProcessState
	@ProcessState VARCHAR(50) OUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @ProcessState = (SELECT TOP 1 [ParameterValue] 
						 FROM [Config].[Parameter]
						 WHERE [ParamaterCode] = 'ETLState')
	
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[GetLoadStartParameters]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author: Adatis Consulting - PS
-- Create date: 2016-11-02
-- Description:	Checks the source file control table and determines whether load is required
-- PS: This follows up SAW design of ETL-ProcessStart PowerShell in automation account
-- PS: TODO: Need to be tested!
-- =============================================

CREATE PROCEDURE Azure.GetLoadStartParameters 
	@ApplicationId smallint,
	@Output VARCHAR(500) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IsETLReady BIT = 0;
	DECLARE @IsAnythingToProcess BIT = 0;

	DECLARE @ETLProgressState VARCHAR(50) = 'NotSpecified'

	EXEC Azure.GetETLProcessState 
		@ProcessState = @ETLProgressState OUT;
	
	/* Checks if there is anything to process */
	IF EXISTS (SELECT *
				 FROM [Control].[SourceFile] As A
				WHERE [ApplicationId] = 1
			      AND StageParentLoadId IS NULL
				  AND FileExtractedDate IS NOT NULL
				  AND [BlobUploadDate]  IS NOT NULL
				  AND [StageDate]	    IS NULL
				  AND [CleanDate]		IS NULL
				  AND [WarehouseDate]	IS NULL
				)
    SET @IsAnythingToProcess = 1

	/* Checks if there is anything running */
	IF @ETLProgressState NOT IN ('InProgress','Error')
		    SET @IsETLReady = 1


	/* Return JSON result to output variable that will be consumed by ETL-ProcessStart, ETL-ProcessEnd Runbook*/
	SET @Output=(SELECT 
				 	@IsAnythingToProcess AS [IsAnythingToProcess],
					@IsETLReady AS [IsETLReady]
				 FOR JSON PATH);
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[InsertAction]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-05-03
-- Description:	Inserts Action state to AutomationActionLog about the state of the action performed on the object
-- =============================================

CREATE PROCEDURE [Azure].[InsertAction]
	@ObjectName VARCHAR(255),
	@ActionName VARCHAR(255),
	@ActionDescription VARCHAR(Max),
	@Result	INT,
	@OperationId UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO [Azure].[AutomationActionLog]
		(ObjectName,ActionName, ActionDescription, InsertedDate, Result, OperationID)
	VALUES
		(@ObjectName, @ActionName, @ActionDescription, SYSDATETIME(), @Result, @OperationId);
END;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[UpdateAction]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-12
-- Description:	Updates Action in AutomationActionLog about the state of the action performed on the object
-- =============================================

CREATE PROCEDURE [Azure].[UpdateAction]
	@ObjectName VARCHAR(255),
	@ActionName VARCHAR(255),
	@Result	INT
AS
BEGIN
	DECLARE @LastActionId INT = (SELECT TOP(1) ActionId 
								FROM [Azure].[AutomationActionLog]
								WHERE ObjectName = @ObjectName
								  AND ActionName = @ActionName
								  AND UpdatedDate IS NULL
								ORDER BY InsertedDate DESC);

	UPDATE [Azure].[AutomationActionLog] SET	
		UpdatedDate = SYSDATETIME(),
		Result = @Result
	WHERE ObjectName = @ObjectName
	  AND ActionName = @ActionName
	  AND ActionId = @LastActionId
END;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [Azure].[UpdateETLProcessState]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
-- =============================================
-- Author: Adatis Consulting - PS
-- Create date: 2016-11-03
-- Description:	Updates Parameter that holds current state of ETL process
-- =============================================

CREATE PROCEDURE Azure.UpdateETLProcessState
	@ProcessState VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [Config].[Parameter]
	   SET [ParameterValue] = @ProcessState    
	 WHERE [ParamaterCode] = 'ETLState'
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
