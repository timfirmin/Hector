CREATE PROCEDURE [Control].[ObtainBulkEntityId] 
	
	@SourceFileList varchar(4000) ,
	@EntityName VARCHAR(50),
	@LoadId int = -1,
	@ParentEntityId INT = NULL   

 AS
 BEGIN
	SET NOCOUNT ON;
--DECLARE	@EntityName VARCHAR(50) = 'OrcUsageComponent'
--DECLARE	@LoadId int = -1
--DECLARE	@ParentEntityId INT = NULL   
--DECLARE @SourceFileList varchar(50) = '2,3,4,5,6,7,8'
--DECLARE @SourceFile AS INT 
--DECLARE C Cursor FOR SELECT VALUE from [Control].[SplitCSV] (@SourceFileList)

DECLARE @SourceFile AS INT 
DECLARE @tblEntityId AS TABLE (EntityId INT)
DECLARE C Cursor FOR SELECT VALUE from [Control].[SpiltCSV] (@SourceFileList)
DECLARE @SourceFileIdNew AS INT
DECLARE @EntityId AS INT
OPEN C

FETCH NEXT FROM C into @SourceFile

WHILE @@FETCH_STATUS = 0
BEGIN
--PRINT @SourceFile

SELECT @SourceFileIdNew = SourceFileId FROM Control.SourceFile WHERE OriginalFileId = @SourceFile

INSERT INTO  @tblEntityId EXEC [Control].[ObtainEntityId] @SourceFileIdNew, @EntityName,@LoadId,@ParentEntityId

FETCH NEXT FROM C INTO @SourceFile


END
CLOSE C

Select * FROM @tblEntityId

END

--DELETE FROM Control.Entity WHERE EntityId IN (5004, 5005)
GO


