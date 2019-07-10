-- This script is to be run against Production ONLY BISystem (AZP-MS-SQL-P003)
-- Chris Ellis
-- 27th Feb 2017
begin transaction

-- First we need to reset the BlobUploadDate so we can reprocess the Blob Upload. Bug was incorrectly setting this on failure
 update Control.SourceFile
 set BlobUploadDate = null
 where SourceFileId = 1;

-- Second, we need the extract of DX_STMT_WKDT to be under one EntityId. This has already been corrected in the SSIS Extract package but we extracted in Live
-- Prior to this fix. The updates below ensures all the RowCounts are against a single EntityId so the RowCountValidation will no longer fail.

-- This sql indentifies those files that are not correct - Any that are not 58 is wrong
--select ce.SourceFileId, count(*)
--from Control.Entity ce
--inner join Control.SourceFile csf on ce.SourceFileId = csf.SourceFileId
--where csf.ApplicationId = 1
--group by ce.SourceFileId
--order by SourceFileId;

-- fix the Audit.RowThroughput so that dx_stmt_wkdt all have same EntityId
-- file 3
--select * from Audit.RowThroughput where EntityId in (174,175)
--select * from Audit.RowThroughput where RowThroughputId in (195);
update Audit.RowThroughput set EntityId = 175 where RowThroughputId = 195;

-- file 8
--select * from Audit.RowThroughput where EntityId in (465,466,467)
--select * from Audit.RowThroughput where RowThroughputId in (513, 514, 519);
update Audit.RowThroughput set EntityId = 467 where RowThroughputId in (513, 514, 519);

-- file 10
--select * from Audit.RowThroughput where EntityId in (583,584,585)
--select * from Audit.RowThroughput where RowThroughputId in (644, 646);
update Audit.RowThroughput set EntityId = 585 where RowThroughputId in (644, 646);

-- commit transaction
-- rollback transaction

