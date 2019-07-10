CREATE PROCEDURE [notification].[uspProcessNotification]
  @notificationId int
AS
BEGIN

		
		update [notification].[notification]
		set [processSysTime]=sysutcdatetime(),
		     Processed = 1
		where [notificationID] = @notificationID
	
END

