-- =============================================
-- Author:		Adatis Consulting
-- Create date: 07/07/2016
-- Description: Verifies whether a load process has been previously
--				run for a given entity so a package can skip the
--				unecessary repeat of processed packages.
-- =============================================
CREATE PROCEDURE [Control].[VerifyPackageExecution] (@EntityId int,
													@ProcessStream varchar(25),
													@VerifyResult int OUTPUT)
AS
BEGIN

	SET  @EntityId = 198
	SET  @ProcessStream = 'TRN2WAR'


	/* Additional logic to override if the whole file needs reprocessing */
	/*

	DECLARE	@SourceFileId int,
		@ProcessDateColumn varchar(25)


	SELECT @ProcessDateColumn = DateColumnName
	FROM Control.ProcessStream PS
	WHERE PS.Name = @ProcessStream
	
	DECLARE @sqlCommand nvarchar(1000),
			@ProcessDate DATETIME

	SELECT @SourceFileId = SF.SourceFileId
	FROM Control.Entity E
		INNER JOIN Control.SourceFile SF on E.SourceFileId = SF.SourceFileId
	WHERE E.EntityId = @EntityId

	SET @sqlCommand = 'SELECT @ProcessDate = '+@ProcessDateColumn+'
						FROM Control.SourceFile SF
						WHERE SourceFileId = @SourceFileId'
	EXECUTE sp_executesql @sqlCommand, N'@SourceFileId int, @ProcessDate datetime OUTPUT', @SourceFileId = @SourceFileId, @ProcessDate = @ProcessDate OUTPUT


	IF @ProcessDate IS NULL
		BEGIN
			print 'File not yet stamped, continue'
		END
	*/

	IF EXISTS(	SELECT null
			FROM [Control].[EntityProcessStream] EPS
			WHERE EPS.EntityId = @EntityId
				AND EPS.LoadProcess = @ProcessStream
				AND EPS.LoadStatusTypeId = 2)
	BEGIN
		SET @VerifyResult = 1
		RETURN @VerifyResult
	END
	ELSE
	BEGIN
		SET @VerifyResult = 0
		RETURN @VerifyResult
	END

	/* test sql */
	/*
	SELECT *
	FROM [Control].[EntityProcessStream] EPS
	WHERE EPS.EntityId = 198
		AND EPS.LoadProcess = 'TRN2WAR'
		AND EPS.LoadStatusTypeId = 2

	SELECT E.EntityId, SF.SourceFileName, ET.Name, ET.Description
	FROM Control.Entity E
		INNER JOIN Control.SourceFile SF on E.SourceFileId = SF.SourceFileId
		INNER JOIN Control.EntityType ET on E.EntityTypeId = ET.EntityTypeId
	WHERE E.EntityId = 198

	SELECT SF.*
	FROM Control.Entity E
		INNER JOIN Control.SourceFile SF on E.SourceFileId = SF.SourceFileId
	WHERE E.EntityId = 198
	*/

END
