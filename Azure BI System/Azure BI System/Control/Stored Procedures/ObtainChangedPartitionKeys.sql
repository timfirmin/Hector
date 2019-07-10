CREATE PROCEDURE [Control].[ObtainChangedPartitionKeys] (@SourceFileType varchar(25))
AS
BEGIN
	SET NOCOUNT ON

	SELECT PartitionKey

      FROM [Control].[SourceFile] SF 
	  INNER JOIN [Control].[SourceFileType] SFT ON SF.SourceFileTypeID = SFT.SourceFileTypeID
	 WHERE (Code = 'Online'
			AND MDSDate is not null
			AND	IsToBeLoaded = 1
			AND	coalesce(IsLoaded,0) = 0
			AND SF.SourceFileId >0 )
	 GROUP BY PartitionKey
		 
	 
END
GO