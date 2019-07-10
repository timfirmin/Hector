CREATE PROCEDURE [notification].[uspGetNotificationFromQueue]
	@notificationId int
AS


   SELECT    
      
	     n.[recipientList],
		 n.[notificationSubject],
		 n.[notificationResponse]  as notificationBody,
		 n.[profileName]
	FROM [notification].[vNotification] n
	WHERE  n.[Processed]=0 and n.[enabled]=1  and n.[notificationID] = @notificationId
	
