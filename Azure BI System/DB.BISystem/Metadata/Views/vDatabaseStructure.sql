CREATE VIEW [Metadata].[vDatabaseStructure]
AS
SELECT        
       DB.Title AS DatabaseName, 
       SCH.Title AS SchemaName, 
       TBL.Title AS TableName, 
       COL.Title AS ColumnName,
       Col.Description AS ColumnDescription,
       OA.DataType AS ColumnDataType, 
       DB.ObjectId AS DatabaseObjectId, 
       SCH.ObjectId AS SchemaObjectId, 
    TBL.ObjectId AS TableObjectId, 
       COL.ObjectId AS ColumnObjectId,
       DB.SourceKey AS DBSourceKey, 
       SCH.SourceKey AS SchemaSourceKey, 
       TBL.SourceKey AS TableSourceKey,
       COL.SourceKey AS ColumnSourceKey,
       OA.[ColumnLength], 
       OA.[Scale], 
       OA.[Precision], 
       OA.[IsNullable],
       OA.[IsDate]
FROM            
       (SELECT        
              ObjectId, 
              Title,  
              SourceKey
       FROM            
              Metadata.Object AS DB
    WHERE        
              (TypeId = 1)) 
       AS DB LEFT OUTER JOIN
        Metadata.ObjectRelationship AS DB2SCH ON DB.ObjectId = DB2SCH.FromObjectId LEFT OUTER JOIN
        Metadata.Object AS SCH ON SCH.ObjectId = DB2SCH.ToObjectId LEFT OUTER JOIN
        Metadata.ObjectRelationship AS SCH2TBL ON SCH.ObjectId = SCH2TBL.FromObjectId LEFT OUTER JOIN
        Metadata.Object AS TBL ON TBL.ObjectId = SCH2TBL.ToObjectId LEFT OUTER JOIN
        Metadata.ObjectRelationship AS TBL2Col ON TBL.ObjectId = TBL2Col.FromObjectId LEFT OUTER JOIN
        Metadata.Object AS COL ON COL.ObjectId = TBL2Col.ToObjectId LEFT OUTER JOIN 
              (SELECT 
              [ObjectId] AS ObjectId, 
              [ColumnId], 
              [DataType], 
              [ColumnLength], 
              [Scale], 
              [Precision], 
              [IsNullable], 
              [IsIdentity],
              [IsDate]
       FROM
              (
              SELECT [ObjectId]
                           ,[Name]
                           ,[Value]
                     FROM Metadata.[ObjectAttribute]) AS SourceTable
              PIVOT
              (
              MAX(Value)
              FOR Name IN (
                     [ColumnId], 
                     [DataType], 
                     [ColumnLength], 
                     [Scale], 
                     [Precision], 
                     [IsNullable], 
                     [IsIdentity],
                     [IsDate])
              ) AS PivotTable) AS OA ON OA.ObjectId = COL.ObjectId
