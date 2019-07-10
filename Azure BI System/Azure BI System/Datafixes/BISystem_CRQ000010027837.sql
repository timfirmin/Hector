--BISytem Fix
Begin Transaction;

Update [Audit].[RowThroughput]
set FailedRows = 0
where RowThroughputId = 253716;

-- commit Transaction;
-- Rollback Transaction;