CREATE PROCEDURE [Control].[ResetSourceFileByName] 
(
@SourceFileName	VARCHAR(100), 
@ApplicationCode VARCHAR(100)
)  
AS

SET NOCOUNT ON;
--Used for Applications During ReExtract Process - Reset Columns to Allow Azure Load
--Exec  [Control].[ResetSourceFileByName] @SourceFileName = 'ETLSystem2017MAY08', @ApplicationCode = 'ETLSystem'
DECLARE @ApplicationId int
SELECT @ApplicationId = [ApplicationId] FROM [Control].[Application]  WHERE Code = @ApplicationCode

UPDATE [Control].SourceFile 
SET 
	StageDate = null, 
	StageParentLoadId = null, 
	CleanDate = null, 
	CleanParentLoadId = null, 
	TransformDate = null, 
	TransformParentLoadId  = null, 
	WarehouseDate  = null, 
	WarehouseParentLoadId  = null
FROM Control.SourceFile 
WHERE SourceFileName = @SourceFileName
AND ApplicationID = @ApplicationId
