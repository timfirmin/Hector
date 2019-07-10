CREATE VIEW  [notification].[vNotificationFailed]
AS 
SELECT
	count(*) as NotificationFailed
FROM 
	[notification].[notification] n
WHERE
	datediff(mi, queueSysTime, isnull(processSysTime, getdate())) > 15


