CREATE PROCEDURE [Control].[GetNotificationMessageTemplate] (@NotificationMessageTypeId int)
AS
BEGIN
	SELECT
		MessageHTML
	FROM [Control].[NotificationEmailMessageFormats]
	WHERE NotificationMessageTypeId = @NotificationMessageTypeId AND IsDeleted = 0
END
