CREATE PROCEDURE [Control].[ObtainEntityUploadDetails]
	@ApplicationCode	varchar(80),
	@SourceTable		varchar(80),
	@Container			varchar(50) OUTPUT
AS
BEGIN
	SET @Container =(SELECT	E.[Code]
					   FROM [Control].[EntityType] AS E
				  LEFT JOIN [Control].[Application] AS A
					     ON E.ApplicationId = A.ApplicationId
					  WHERE E.[Table] = @SourceTable
						AND E.IsSourceEntity = 1
						AND A.Code = @ApplicationCode
					)
END
