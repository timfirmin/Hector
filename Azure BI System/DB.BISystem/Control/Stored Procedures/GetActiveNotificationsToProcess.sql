CREATE PROCEDURE [Control].[GetActiveNotificationsToProcess]
AS
BEGIN
SELECT
		[CT].[NotificationId],
		[CT].[NotificationTypeId],
		[CT].[LoadStatusType],
		[CT].[NotificationProcessTypeId],
		[CT].[ShortDescription],
		[CT].[ErrorCode],
		[CT].[VerboseDescription],
		[CT].[NotificationSeverityId],
		[CT].[NotificationStatusId],
		[CT].[FeedName],
		[CT].[Stage],
		[CT].[FeedStartTime],
		[CT].[TimeOfCompletion] [FeedEndTime],
		[CT].[CreatedBy] [FeedLoadInitiatedBy],
		[CT].[RetryOnFailure]
		FROM [Control].[Notification] [CT]
WHERE 
	[CT].[NotificationStatusId] = 10 
	OR ([CT].[NotificationStatusId] = 40 AND [CT].[RetryOnFailure] < 3)

	ORDER BY [CT].LoadId ASC, [CT].[NotificationId] 
END
