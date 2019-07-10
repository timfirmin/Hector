CREATE PROCEDURE [Control].[ObtainActivePartitionKeys] (@SourceFileType varchar(25))
AS
BEGIN
	--SET NOCOUNT ON

	SELECT PartitionKey,
       ISNULL(stuff( (SELECT ','+cast(OriginalFileId as varchar(10))
               FROM [Control].[SourceFile] SF2
               WHERE		(SF2.PartitionKey = SF.PartitionKey
							AND MDSDate is not null
							AND	IsToBeLoaded = 1
							AND	coalesce(IsLoaded,0) = 0) OR
							(SF2.PartitionKey = SF.PartitionKey
							AND MDSDate is not null
							AND	coalesce(IsToBeLoaded,0) = 1
							AND	coalesce(IsLoaded,0) = 1)					 
               ORDER BY OriginalFileId
               FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
            ,1,1,''),'0') SourceFileIDs
      FROM [Control].[SourceFile] SF INNER JOIN
			[Control].[SourceFileType] SFT ON SF.SourceFileTypeID = SFT.SourceFileTypeID
	 WHERE (Code = 'Online'
			AND MDSDate is not null
			AND	IsToBeLoaded = 1
			AND	coalesce(IsLoaded,0) = 0
			AND SF.OriginalFileId >0 ) OR
			(Code = 'Online'
			AND MDSDate is not null
			AND	coalesce(IsToBeLoaded,0)  = 0
			AND	coalesce(IsLoaded,0) = 1
			AND SF.OriginalFileId >0 )
	 GROUP BY PartitionKey
		
END

PRINT N'Altering [Control].[ObtainSourceFileIdForProcess]...';


