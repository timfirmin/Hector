CREATE  VIEW [notification].[vNotificationQueue]

AS

SELECT  
      [notificationID]  
FROM  [notification].[Notification]
WHERE Processed =0
      AND ISNULL([ExpiryDate],getdate()) >= getdate()