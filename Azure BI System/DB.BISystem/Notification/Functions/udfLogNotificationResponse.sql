

CREATE FUNCTION [notification].[udfLogNotificationResponse]
(
	@notificationData NVarchar(MAX)
	,
	@templateID int
)
RETURNS NVarchar(MAX)
AS
BEGIN
	
	DECLARE @TextValue NVARCHAR(MAX)
	SET @TextValue = ''		

	If @templateID =2 and ISJSON(@notificationData)>0
	BEGIN
	SELECT @TextValue =  replace (
								 replace (
									replace (bodyText,'#NDate#',JSON_VALUE(@notificationData,'$[0].NDate'))
									,'#New#',JSON_VALUE( @notificationData,'$[0].NewStations')
									),
								    '#Updated#',JSON_VALUE( @notificationData, '$[0].UpdatedStations')
		) 
	FROM	[notification].[template] 
	Where TemplateID=@templateID
	
	END
	
	RETURN @TextValue

END