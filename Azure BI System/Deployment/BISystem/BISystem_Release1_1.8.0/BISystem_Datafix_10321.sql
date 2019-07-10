-- BISystem_Release1_1.8.0 (Correct ordering for processing SourceFiles)

begin transaction;

update [control].[SourceFile]
set BlobUploadDate = null
where SourceFileId = 10321;

--rollback transaction;
--commit transaction;