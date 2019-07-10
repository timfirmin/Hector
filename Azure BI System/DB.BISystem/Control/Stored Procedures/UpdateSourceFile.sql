-- =============================================
-- Author:		Adatis
-- Create date: 18/03/2013
-- Description:	Updates Source File milestone dates
-- =============================================
CREATE PROCEDURE [Control].[UpdateSourceFile]
	@SourceFileId	INT, 
	@Stream			VARCHAR(10),
	@ParentLoadId	INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @Stream = 'SRC2FILE'
	BEGIN
	    UPDATE Control.SourceFile
		   SET [FileExtractedDate]= GETDATE(),
	           [FileExtractedParentLoadId]= @ParentLoadId,
			   [ModifiedDate] = GETDATE()
	    WHERE SourceFileId = @SourceFileId
	END
	
	IF @Stream = 'FILE2EXT'
	BEGIN
		UPDATE Control.SourceFile
		SET	BlobUploadDate = GETDATE() ,
		[ModifiedDate] = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END
	
	IF @Stream in ('EXT2STG', 'SRC2STG')
	BEGIN
		UPDATE Control.SourceFile
		SET	StageDate = GETDATE()
		, [StageParentLoadId] = @ParentLoadId,
		[ModifiedDate] = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END
	
	IF @Stream = 'STG2CLN'
	BEGIN
		IF @ParentLoadId IS NOT NULL
		BEGIN
			UPDATE Control.SourceFile
			SET	CleanDate = GETDATE()
			, [CleanParentLoadId] = @ParentLoadId,
			[ModifiedDate] = GETDATE()
			WHERE SourceFileId = @SourceFileId
		END
		ELSE
		BEGIN
			UPDATE Control.SourceFile
			SET	CleanDate = GETDATE()
			WHERE SourceFileId = @SourceFileId
		END
	END	
		
	IF @Stream = 'CLN2WAR'
	BEGIN
		UPDATE Control.SourceFile
		SET	WarehouseDate = GETDATE(),
		[ModifiedDate] = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END;

	IF @Stream = 'CLN2TRN'
	BEGIN
		UPDATE Control.SourceFile
		SET	TransformDate = GETDATE(),
		[TransformParentLoadId] = @ParentLoadId,
		[ModifiedDate] = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END;

	IF @Stream = 'STG2TRN'
	BEGIN
		UPDATE Control.SourceFile
		SET	TransformDate = GETDATE(),
		[TransformParentLoadId] = @ParentLoadId,
		[ModifiedDate] = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END;

	IF @Stream in ('TRN2WAR', 'STG2DMT')
	BEGIN
		UPDATE Control.SourceFile
		SET	WarehouseDate = GETDATE(),
		[WarehouseParentLoadId] = @ParentLoadId,
		[ModifiedDate] = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END;

	IF @Stream = 'SRC2STG'
	BEGIN
		UPDATE Control.SourceFile
		SET	StageDate = GETDATE()
		,UnloadFile = 0
		,PurgeFromArchive = 0
		,FileUnloadedDate = NULL
		,FileUnloaded = 0
		,ArchivePurgedDate = NULL
		,ArchivePurged = 0
		WHERE SourceFileId = @SourceFileId
	END

	IF @Stream in ('CLN2MDS', 'STG2MDS')
	BEGIN
		UPDATE Control.SourceFile
		SET	MDSDate = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END

	IF @Stream in ('MDS2CLN', 'MDS2STG')
	BEGIN
		UPDATE Control.SourceFile
		SET	MDSDate = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END


	IF @Stream = 'CLN2WH'
	BEGIN
		UPDATE Control.SourceFile
		SET	WarehouseDate = GETDATE()
		,FileUnloaded = 0
		,UnloadFile = 0
		,IsLoaded = 1
		WHERE SourceFileId = @SourceFileId
	END


	IF @Stream = 'ANA2ARC'
	BEGIN
		UPDATE Control.SourceFile
		SET	WarehouseDate = GETDATE()
		,PurgeFromArchive = 0
		,ArchivePurged = 0
		WHERE SourceFileId = @SourceFileId
	END

	IF @Stream = 'STG2SCR'
	BEGIN
		UPDATE Control.SourceFile
		SET	ScrubDate = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END

	IF @Stream = 'SCR2CLN'
	BEGIN
		UPDATE Control.SourceFile
		SET	CleanDate = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END

	IF @Stream = 'CLN2OLP'
	BEGIN
		UPDATE Control.SourceFile
		SET	OLAPDate = GETDATE()
		,FileUnloaded = 0
		,UnloadFile = 0
		WHERE SourceFileId = @SourceFileId
	END

	IF @Stream = 'WAR2TAB'
	BEGIN
		UPDATE Control.SourceFile
		SET	OLAPDate = GETDATE()
		WHERE SourceFileId = @SourceFileId
	END


END
