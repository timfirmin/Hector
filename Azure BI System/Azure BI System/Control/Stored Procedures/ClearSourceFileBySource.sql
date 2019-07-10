CREATE PROCEDURE  [Control].[ClearSourceFileBySource]
	@Source nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
--Set all SourceFile rows that exist to default so will not run for Apps where we only want most recent run
--Test : exec  [Control].[ClearSourceFileBySource]  @Source = 'ETLSystemFileServer'
update [Control].SourceFile
set	StageDate = getdate(), StageParentLoadId = 9999
where StageDate is null and [Source] = @Source

update [Control].SourceFile
set	CleanDate = getdate(), CleanParentLoadId = 9999
where CleanDate is null and [Source] = @Source

update [Control].SourceFile
set	TransformDate = getdate(), TransformParentLoadId = 9999
where TransformDate is null and [Source] = @Source
	
update [Control].SourceFile
set	WarehouseDate = getdate(), WarehouseParentLoadId = 9999
where WarehouseDate is null and [Source] = @Source

END