CREATE VIEW  [notification].[vNotificationQueueStatus]
AS 
SELECT
	notificationID
	, notificationSubject 
	, templateName as [Notification]
	, Processed as ProcessingStatus
	, recipientList as Recipients
	, len(recipientList) - len(replace(recipientList,';','')) as NumOfReceipients
	, requestSource as RequestSource
	, ExpiryDate
FROM 
	[notification].[notification] n
	join [notification].[template] t on t.templateID=n.templateID
	join [notification].[vTemplateRecipientList] l on l.templateID=t.templateID
WHERE
	QueueSysTime >= CAST (GETDATE() AS DATE)

