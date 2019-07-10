CREATE VIEW [Metadata].[vFileStructure]
AS

SELECT        
       DB.Title AS FileName, 
       COL.Title AS ColumnName,
       Col.Description AS ColumnDescription,
       RTRIM(LOWER(OA.DataType)) AS ColumnDataType, 
       DB.ObjectId AS DatabaseObjectId, 
       COL.ObjectId AS ColumnObjectId,
       DB.SourceKey AS DBSourceKey, 
       COL.SourceKey AS ColumnSourceKey,
       OA.[ColumnLength], 
       OA.[Scale], 
       OA.[Precision], 
       OA.[IsNullable],[StartPosition],[EndPosition],[DataFormat]
FROM            
       (SELECT        
              ObjectId, 
              Title,  
              SourceKey
       FROM            
              Metadata.Object AS DB
    WHERE        
              (TypeId = 7)) 
       AS DB LEFT OUTER JOIN
        Metadata.ObjectRelationship AS FL2Col ON DB.ObjectId = FL2Col.FromObjectId LEFT OUTER JOIN
        Metadata.Object AS COL ON COL.ObjectId = FL2Col.ToObjectId LEFT OUTER JOIN 
              (SELECT 
              [ObjectId] AS ObjectId, 
              [ColumnId], 
              [DataType], 
              [ColumnLength], 
              [Scale], 
              [Precision], 
              [IsNullable], 
              [IsIdentity],[StartPosition],[EndPosition],[DataFormat]
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
                     [IsIdentity],[StartPosition],[EndPosition],[DataFormat])
              ) AS PivotTable) AS OA ON OA.ObjectId = COL.ObjectId
