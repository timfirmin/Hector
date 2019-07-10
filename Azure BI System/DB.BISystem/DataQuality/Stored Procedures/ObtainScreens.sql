CREATE PROCEDURE [DataQuality].[ObtainScreens]

@ObjectId varchar(50)

AS

-- =============================================
-- Author:		Jeremy Kashel
-- Create date: 08/10/2012
-- Description:	Returns all the screens that must be run for a given package id
-- =============================================


SELECT		ScreenID,
			COALESCE(ScreenSQL,'') AS ScreenSQL,
			COALESCE(ScreenReferenceSQL,'') AS ScreenReferenceSQL
FROM		[DataQuality].[Screen]
--WHERE		ObjectId = Convert(uniqueidentifier, @PackageId)
WHERE		Cast(ObjectId As Varchar(50)) = @ObjectId
