BEGIN TRANSACTION

-- first insert into Package Load.
-- We need to insert a row for each extract BEFORE we deployed OS_DM_EXTRACT_CONTROL pull (SourceFileName < 10)
insert into [Audit].[PackageLoad] (ParentLoadId, ExecutionId, PackageName, LoadProcess, LoadStatusId, StartTime, EndTime, Duration)
Select distinct
  pl.ParentLoadId,
  pl.ExecutionId,
  'DMS OracleExtraction',
  'SRC2FILE',
  2,
  sysdatetime(),
  sysdatetime(),
  0
from [Audit].[PackageLoad] pl 
join [Control].[SourceFile] sf on (pl.ParentLoadId = sf.LoadId)
where sf.ApplicationId = 16
  and cast(sf.SourceFileName AS decimal(3,0)) <= 10;

-- insert into [Control].[Entity]
insert into [Control].[Entity] (ParentEntityId, SourceFileId, EntityTypeId, LoadId, ApplicationId)
select 
  pl.ParentLoadId,
  sf.SourceFileId,
  (Select EntityTypeId from [Control].[EntityType] cet where cet.ApplicationId = 16 and Name = 'OSDMExtractControl'),
  pl.LoadId,
  16
from [Control].[SourceFile] sf
join [Audit].[PackageLoad] pl on (pl.ParentLoadId = sf.LoadId)
where sf.ApplicationId = 16
  and pl.EnvironmentId is null -- identifies pl's just inserted

-- insert into [Audit].[RowThroughput]
insert into [Audit].[RowThroughput] (EntityId, LoadProcess, TaskName, ProcessStream, InsertedRows, LoadId)
select
  ce.EntityId,
  'SRC2FILE',
  'Custom Task',
  'SRC2FILE',
  1,
  ce.LoadId
from [Control].[Entity] ce
join [Audit].[PackageLoad] pl on (ce.LoadId = pl.LoadId)
where ce.ApplicationId = 16
  and pl.EnvironmentId is null; -- identifies pl's just inserted

-- check data - We should have all entries for table DMS_OS_DM_EXTRACT_CONTROL. One for each extract. InsertedRows to be 1
SELECT sf.LoadId, sf.SourceFileId, cet.[table], pl.LoadProcess, rt.InsertedRows
FROM [Audit].[PackageLoad] pl
JOIN [Control].[SourceFile] sf on (pl.ParentLoadId = sf.FileExtractedParentLoadId)
JOIN [Audit].[RowThroughput] rt on (pl.LoadId = rt.LoadId)
JOIN [Control].Entity ce        on (ce.EntityId     = rt.EntityId
                                and ce.SourceFileId = sf.SourceFileId)
JOIN [Control].[EntityType] cet on (cet.EntityTypeId = ce.EntityTypeId)
WHERE sf.ApplicationId = 16
order by cet.[table], sf.SourceFileId;

-- commit transaction
-- rollback transaction