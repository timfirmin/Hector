CREATE PROCEDURE [DataQuality].[GetFeedTableColumnDetails]

AS
BEGIN
  -- Turn off the count 
  SET NOCOUNT ON
 
    SELECT  ET.Name TableDisplayName,(ET.[Schema]+'.'+ET.[Table]) TableName,ColumnObjectId as ColumnID,DB.ColumnName,DB.ColumnDataType,DB.IsNullable,
	CASE WHEN DB.ColumnDataType NOT LIKE '%varchar%' AND DB.ColumnDataType NOT LIKE '%char%' AND DB.ColumnDataType NOT LIKE '%uniqueidentifier%' THEN Precision 
	ELSE DB.ColumnLength END AS ColumnLength
	FROM control.EntityType ET
	INNER JOIN Metadata.vDatabaseStructure DB
	ON DB.TableName=ET.[Table]	AND DB.SchemaName=ET.[Schema]
	WHERE DB.DatabaseName='Scrub' AND TableName not like 'prescrub%'	
	ORDER BY TableDisplayName,DB.ColumnName asc
END