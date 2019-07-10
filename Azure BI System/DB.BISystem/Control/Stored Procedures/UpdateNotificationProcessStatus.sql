CREATE PROCEDURE [Control].[UpdateNotificationProcessStatus] (@NotificationId int, @NotificationStatusId int)
AS
BEGIN

	-- IF FAILED, RetryOnFailure VALUE NEED TO BE INCREMENTED TILL 3
	-- NO CHANGE FOR STATUS OTHER THAN FAILURE

	IF @NotificationStatusId = 40 --FAILURE
	BEGIN
		UPDATE Control.Notification
		SET	NotificationStatusId = @NotificationStatusId,
			RetryOnFailure = RetryOnFailure + 1
		WHERE NotificationId = @NotificationId
	END
	ELSE
	BEGIN
		UPDATE Control.Notification
		SET NotificationStatusId = @NotificationStatusId
		WHERE NotificationId = @NotificationId
	END
END
