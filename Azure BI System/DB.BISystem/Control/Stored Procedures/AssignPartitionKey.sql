
CREATE PROCEDURE [Control].[AssignPartitionKey]

AS
BEGIN

DECLARE @PartitionKey AS INT  = NEXT VALUE FOR [Control].[PartitionKey] 
UPDATE Control.SourceFile
SET [PartitionKey] = @PartitionKey
WHERE
(IsLoaded = 'False' OR IsLoaded IS NULL)
AND IsToBeLoaded = 'True'
AND [PartitionKey] IS NULL
END
