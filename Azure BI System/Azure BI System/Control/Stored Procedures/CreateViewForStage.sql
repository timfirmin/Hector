CREATE PROCEDURE  [Control].[CreateViewForStage]

	@SchemaName nVARCHAR(255),
	@TableName nVARCHAR(255),
	@DestinationDB nVARCHAR(255),
	@SourceDB nVARCHAR(255),
	@LoadId int 

AS

DECLARE @sql NVARCHAR(MAX)
DECLARE @ParamDefinition AS NVARCHAR(MAX)
DECLARE @MoreParamDefinition AS NVARCHAR(max) 
DECLARE @Moredynamicsql NVARCHAR(MAX)
DECLARE @sqlforview NVARCHAR(MAX)

IF LEFT(@SourceDB,11) <> 'SourceData_'
BEGIN 
	SET @SourceDB = 'SourceData_' + @SourceDB
END  

	SET  @sql = 
	REPLACE('SELECT [ColumnName] AS MetaDataColumnName
	 ,CASE WHEN tmp.name COLLATE DATABASE_DEFAULT IS NULL THEN tmp.Name COLLATE DATABASE_DEFAULT ELSE [ColumnName] COLLATE DATABASE_DEFAULT END AS SourceColumnName
	FROM [Metadata].[vDatabaseStructure]
	LEFT JOIN (SELECT c.name
	FROM %%SourceDB%%.sys.columns c
	JOIN %%SourceDB%%.sys.tables t ON c.object_id = t.object_id 
	WHERE t.name = @TableName )tmp ON tmp.name COLLATE DATABASE_DEFAULT = ColumnName COLLATE DATABASE_DEFAULT
	WHERE DatabaseName = @DestinationDB  AND SchemaName = @SchemaName AND TABLENAME = @TableName','%%SourceDB%%', @SourceDB
	)
	set @ParamDefinition = '@SchemaName VARCHAR(255),
							@TableName VARCHAR(255),
							@DestinationDB VARCHAR(255) ,
							@SourceDB VARCHAR(255)'

	CREATE table #ParamsList
	(
		ColumnName nVARCHAR(4000),
		DestinatonColumn nVARCHAR(4000)
	)
	
	INSERT INTO  #ParamsList  Execute sp_Executesql     @sql, 
					@ParamDefinition, 
					@SchemaName, 
					@TableName, 
					@DestinationDB, 
					@SourceDB 
				
			
	IF NOT EXISTS(SELECT 1 FROM #ParamsList)
		BEGIN
				RAISERROR ('Table doesnt exist in metadata', 16, 1) WITH SETERROR
		END  

	SET @sqlforview = 'create view v'+@TableName +' as select  '
	
	SELECT @sqlforview = @sqlforview + ISNULL(DestinatonColumn,'' +  ' cast(null as nvarchar(1000)) as ' + ColumnName )+',' FROM #ParamsList

  	SET @sqlforview = LEFT(@sqlforview,LEN(@sqlforview) -1) + ' from ' + @SourceDB + '.dbo.' + @TableName
	SET @MoreParamDefinition = '@sqlforview nVARCHAR(max)'				
	SET @moredynamicsql = REPLACE('EXEC %%@SourceDB%%.dbo.sp_executesql @sqlforview','%%@SourceDB%%',@SourceDB)

    EXEC sp_executesql @moredynamicsql, @MoreParamDefinition, @sqlforview