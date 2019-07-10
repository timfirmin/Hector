CREATE PROCEDURE [DataQuality].[GetFeedTableDetails]
AS

-- =================================================================================================
-- Author:		Adatis
-- Create date: 30-01-2014
-- Description:	Stored Procedure to get feed table column details by table id.
-- ==================================================================================================

BEGIN
  -- Turn off the count 
  SET NOCOUNT ON
 
	 SELECT DISTINCT TableObjectId as TableID , SchemaName +'.'+ TableName AS TableName
	 FROM Metadata.vDatabaseStructure where DatabaseName='Scrub' AND TableName not like 'prescrub%'
	 ORDER BY TableName ASC

END
GO